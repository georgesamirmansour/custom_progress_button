import 'package:flutter/material.dart';
import 'custom_icon_button.dart';

enum ButtonState { idle, loading, success, fail }
enum ButtonShapeEnum { elevated, outline, flat }

class ProgressButton extends StatefulWidget {
  final Map<ButtonState, Widget> stateWidgets;
  final Map<ButtonState, Color> stateColors;
  final VoidCallback onPressed;
  final Function? onAnimationEnd;
  late ButtonState state;
  late final double minWidth;
  late final double maxWidth;
  final double? radius;
  late final double height;
  final Widget? progressWidget;
  late final double progressIndicatorSize;
  late final MainAxisAlignment progressAlignment;
  late final EdgeInsets padding;
  late final List<ButtonState> minWidthStates;
  late final ButtonShapeEnum buttonShapeEnum;
  late final double elevation;
  late final Color inLineBackgroundColor;
  late final bool enable;

  ProgressButton(
      {Key? key,
      required this.stateWidgets,
      required this.stateColors,
      this.state = ButtonState.idle,
      required this.onPressed,
      this.onAnimationEnd,
      this.minWidth = 200.0,
      this.maxWidth = 400.0,
      this.radius,
      this.height = 36.0,
      this.progressIndicatorSize = 10.0,
      this.progressWidget,
      this.progressAlignment = MainAxisAlignment.spaceEvenly,
      this.padding = EdgeInsets.zero,
      this.minWidthStates = const <ButtonState>[ButtonState.loading],
      this.buttonShapeEnum = ButtonShapeEnum.elevated,
      this.elevation = 8.0,
      this.enable = true,
      this.inLineBackgroundColor = Colors.white})
      : assert(
          stateWidgets.keys.toSet().containsAll(ButtonState.values.toSet()),
          'Must be non-null widgets provided in map of stateWidgets. Missing keys => ${ButtonState.values.toSet().difference(stateWidgets.keys.toSet())}',
        ),
        assert(
          stateColors.keys.toSet().containsAll(ButtonState.values.toSet()),
          'Must be non-null widgetds provided in map of stateWidgets. Missing keys => ${ButtonState.values.toSet().difference(stateColors.keys.toSet())}',
        ),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProgressButtonState();
  }

  factory ProgressButton.icon({
    required Map<ButtonState, CustomIconButton> iconButtons,
    required VoidCallback onPressed,
    ButtonState state = ButtonState.idle,
    Function? onAnimationEnd,
    maxWidth: 170.0,
    minWidth: 58.0,
    height: 53.0,
    radius: 100.0,
    progressIndicatorSize: 35.0,
    double iconPadding: 4.0,
    TextStyle? textStyle,
    ButtonShapeEnum buttonShapeEnum = ButtonShapeEnum.elevated,
    double elevation = 8.0,
    Color inLineBackgroundColor = Colors.white,
    bool enable = true,
    Widget? progressWidget,
    MainAxisAlignment? progressIndicatorAlignment,
    EdgeInsets padding = EdgeInsets.zero,
    List<ButtonState> minWidthStates = const <ButtonState>[ButtonState.loading],
  }) {
    assert(
      iconButtons != null &&
          iconButtons.keys.toSet().containsAll(ButtonState.values.toSet()),
      'Must be non-null widgets provided in map of stateWidgets. Missing keys => ${ButtonState.values.toSet().difference(iconButtons.keys.toSet())}',
    );

    if (textStyle == null) {
      textStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.w500);
    }

    Map<ButtonState, Widget> stateWidgets = {
      ButtonState.idle: buildChildWithIcon(
          iconButtons[ButtonState.idle]!, iconPadding, textStyle),
      ButtonState.loading: Column(),
      ButtonState.fail: buildChildWithIcon(
          iconButtons[ButtonState.fail]!, iconPadding, textStyle),
      ButtonState.success: buildChildWithIcon(
          iconButtons[ButtonState.success]!, iconPadding, textStyle)
    };

    Map<ButtonState, Color> stateColors = {
      ButtonState.idle: iconButtons[ButtonState.idle]!.color,
      ButtonState.loading: iconButtons[ButtonState.loading]!.color,
      ButtonState.fail: iconButtons[ButtonState.fail]!.color,
      ButtonState.success: iconButtons[ButtonState.success]!.color,
    };

    return ProgressButton(
      stateWidgets: stateWidgets,
      stateColors: stateColors,
      state: state,
      onPressed: onPressed,
      onAnimationEnd: onAnimationEnd,
      maxWidth: maxWidth,
      minWidth: minWidth,
      radius: radius,
      height: height,
      progressIndicatorSize: progressIndicatorSize,
      progressAlignment: MainAxisAlignment.center,
      progressWidget: progressWidget,
      minWidthStates: minWidthStates,
      elevation: elevation,
      padding: padding,
      buttonShapeEnum: buttonShapeEnum,
      inLineBackgroundColor: inLineBackgroundColor,
      enable: enable,
    );
  }
}

class _ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {
  AnimationController? colorAnimationController;
  Animation<Color?>? colorAnimation;
  double? width;
  Duration animationDuration = Duration(milliseconds: 500);
  Widget? progressWidget;

  void startAnimations(ButtonState? oldState, ButtonState? newState) {
    Color? begin = widget.stateColors[oldState!];
    Color? end = widget.stateColors[newState!];
    if (widget.minWidthStates.contains(newState)) {
      width = widget.minWidth;
    } else {
      width = widget.maxWidth;
    }
    colorAnimation = _colorAnimation(begin, end);
    colorAnimationController!.forward();
  }

  Animation<Color?> _colorAnimation(Color? begin, Color? end) =>
      ColorTween(begin: begin, end: end).animate(CurvedAnimation(
        parent: colorAnimationController!,
        curve: Interval(
          0,
          1,
          curve: Curves.easeIn,
        ),
      ));

  Color? get backgroundColor => colorAnimation == null
      ? widget.stateColors[widget.state]
      : colorAnimation!.value ?? widget.stateColors[widget.state];

  @override
  void initState() {
    super.initState();
    width = widget.maxWidth;
    colorAnimationController = _animationController;
    colorAnimationController!.addStatusListener((status) {
      if (widget.onAnimationEnd != null) {
        widget.onAnimationEnd!(status, widget.state);
      }
    });

    progressWidget = _progress;
  }

  AnimationController get _animationController =>
      AnimationController(duration: animationDuration, vsync: this);

  Widget get _progress =>
      widget.progressWidget ??
      CircularProgressIndicator(
          backgroundColor: widget.stateColors[widget.state],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white));

  @override
  void dispose() {
    colorAnimationController!.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ProgressButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.state != widget.state) {
      colorAnimationController?.reset();
      startAnimations(oldWidget.state, widget.state);
    }
  }

  Widget getButtonChild(bool visibility) {
    Widget? buttonChild = widget.stateWidgets[widget.state];
    if (widget.state == ButtonState.loading) {
      return Row(
        mainAxisAlignment: widget.progressAlignment,
        children: <Widget>[
          SizedBox(
            child: progressWidget,
            width: widget.minWidth / 3,
            height: widget.height > 55
                ? widget.height / 2
                : widget.progressIndicatorSize,
          ),
          buttonChild ?? Container(),
        ],
      );
    }
    return _animatedOpacity(visibility, buttonChild);
  }

  AnimatedOpacity _animatedOpacity(bool visibility, Widget? child) =>
      AnimatedOpacity(
          opacity: visibility ? 1.0 : 0.0,
          duration: Duration(milliseconds: 250),
          child: child);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: colorAnimationController!,
      builder: (context, child) {
        return AnimatedContainer(
            width: width,
            height: widget.height,
            duration: animationDuration,
            child: MaterialButton(
              padding: widget.padding,
              shape: buttonShape,
              color: _backgroundColor,
              elevation: _buttonElevation,
              onPressed: widget.enable ? widget.onPressed : null,
              child: _buttonChild,
            ));
      },
    );
  }

  Widget get _buttonChild => getButtonChild(
      colorAnimation == null ? true : colorAnimation!.isCompleted);

  double get _buttonElevation =>
      widget.buttonShapeEnum == ButtonShapeEnum.elevated ||
              widget.buttonShapeEnum == ButtonShapeEnum.outline
          ? widget.elevation
          : 0.0;

  RoundedRectangleBorder get buttonShape =>
      widget.buttonShapeEnum == ButtonShapeEnum.elevated ||
              widget.buttonShapeEnum == ButtonShapeEnum.flat
          ? _roundedRectangleBorderElevated
          : _roundedRectangleBorderOutlined;

  Color get _backgroundColor =>
      widget.buttonShapeEnum == ButtonShapeEnum.elevated ||
              widget.buttonShapeEnum == ButtonShapeEnum.flat
          ? backgroundColor!
          : widget.inLineBackgroundColor;

  RoundedRectangleBorder get _roundedRectangleBorderElevated =>
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              widget.radius == null ? widget.height / 2 : widget.radius!),
          side: BorderSide(color: Colors.transparent, width: 0));

  RoundedRectangleBorder get _roundedRectangleBorderOutlined =>
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              widget.radius == null ? widget.height / 2 : widget.radius!),
          side: BorderSide(color: backgroundColor!, width: 1));
}
