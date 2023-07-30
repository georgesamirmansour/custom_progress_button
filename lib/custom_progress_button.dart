import 'package:flutter/material.dart';
import 'custom_icon_button.dart';

// Enum to represent the different states of the button
enum ButtonState { idle, loading, success, fail }

// Enum to represent different button shapes
enum ButtonShapeEnum { elevated, outline, flat }

/// A customizable button that shows different states based on the [ButtonState].
/// It supports a loading state with an optional progress indicator.
/// The appearance and behavior of the button can be customized using various properties.
class CustomProgressButton extends StatefulWidget {
  // A map containing widgets to display for different button states.
  final Map<ButtonState, Widget> stateWidgets;

  // A map containing colors for different button states.
  final Map<ButtonState, Color> stateColors;

  // The function to be called when the button is pressed.
  final VoidCallback onPressed;

  // A function that is called when the animation ends.
  final Function? onAnimationEnd;

  // The initial state of the button. Defaults to [ButtonState.idle].
  late final ButtonState state;

  // The minimum width of the button. Defaults to 200.0.
  late final double minWidth;

  // The maximum width of the button. Defaults to 400.0.
  late final double maxWidth;

  // The corner radius of the button. If null, it will be set to half of the button's height.
  final double? radius;

  // The height of the button. Defaults to 36.0.
  late final double height;

  // The optional widget to display while the button is in the loading state.
  final Widget? progressWidget;

  // The size of the progress indicator. Defaults to 10.0.
  late final double progressIndicatorSize;

  // The alignment of the progress indicator when [progressWidget] is not provided.
  // Defaults to [MainAxisAlignment.spaceEvenly].
  late final MainAxisAlignment progressAlignment;

  // Padding around the button's child (content).
  late final EdgeInsets padding;

  // The list of states that should use the minimum width of the button.
  late final List<ButtonState> minWidthStates;

  // The shape of the button. Defaults to [ButtonShapeEnum.elevated].
  late final ButtonShapeEnum buttonShapeEnum;

  // The elevation of the button. Used only for [ButtonShapeEnum.elevated] and [ButtonShapeEnum.outline].
  late final double elevation;

  // The background color of the button when it's in the loading or success state.
  late final Color inLineBackgroundColor;

  // If false, the button will be disabled and not respond to touch events. Defaults to true.
  late final bool enable;

  CustomProgressButton({
    Key? key,
    required this.stateWidgets,
    required this.stateColors,
    this.state = ButtonState.idle,
    required this.onPressed,
    this.onAnimationEnd,
    this.minWidth = 200.0,
    this.maxWidth = 400.0,
    this.radius,
    this.height = 40.0,
    this.progressIndicatorSize = 10.0,
    this.progressWidget,
    this.progressAlignment = MainAxisAlignment.spaceEvenly,
    this.padding = EdgeInsets.zero,
    this.minWidthStates = const <ButtonState>[ButtonState.loading],
    this.buttonShapeEnum = ButtonShapeEnum.elevated,
    this.elevation = 8.0,
    this.enable = true,
    this.inLineBackgroundColor = Colors.white,
  })  : assert(
          stateWidgets.keys.toSet().containsAll(ButtonState.values.toSet()),
          'Must provide non-null widgets for all ButtonState values. Missing keys: ${ButtonState.values.toSet().difference(stateWidgets.keys.toSet())}',
        ),
        assert(
          stateColors.keys.toSet().containsAll(ButtonState.values.toSet()),
          'Must provide non-null colors for all ButtonState values. Missing keys: ${ButtonState.values.toSet().difference(stateColors.keys.toSet())}',
        ),
        super(key: key);

  // A factory constructor to create a [ProgressButton] with icon buttons for different states.
  factory CustomProgressButton.icon({
    required Map<ButtonState, CustomIconButton> iconButtons,
    required VoidCallback onPressed,
    ButtonState state = ButtonState.idle,
    Function? onAnimationEnd,
    maxWidth = 170.0,
    minWidth = 58.0,
    height = 53.0,
    radius = 100.0,
    progressIndicatorSize = 35.0,
    double iconPadding = 4.0,
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
      iconButtons.isNotEmpty &&
          iconButtons.keys.toSet().containsAll(ButtonState.values.toSet()),
      'Must provide non-null widgets for all ButtonState values. Missing keys: ${ButtonState.values.toSet().difference(iconButtons.keys.toSet())}',
    );

    if (textStyle == null) {
      textStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.w500);
    }

    // Create a map of widgets for different states.
    Map<ButtonState, Widget> stateWidgets = {
      ButtonState.idle: buildChildWithIcon(
          iconButtons[ButtonState.idle]!, iconPadding, textStyle),
      ButtonState.loading: Column(),
      ButtonState.fail: buildChildWithIcon(
          iconButtons[ButtonState.fail]!, iconPadding, textStyle),
      ButtonState.success: buildChildWithIcon(
          iconButtons[ButtonState.success]!, iconPadding, textStyle),
    };

    // Create a map of colors for different states.
    Map<ButtonState, Color> stateColors = {
      ButtonState.idle: iconButtons[ButtonState.idle]!.color,
      ButtonState.loading: iconButtons[ButtonState.loading]!.color,
      ButtonState.fail: iconButtons[ButtonState.fail]!.color,
      ButtonState.success: iconButtons[ButtonState.success]!.color,
    };

    // Return a new [ProgressButton] instance with the configured properties.
    return CustomProgressButton(
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

  @override
  State<StatefulWidget> createState() {
    return _CustomProgressButtonState();
  }
}

// The private state class for [ProgressButton]
class _CustomProgressButtonState extends State<CustomProgressButton>
    with TickerProviderStateMixin {
  AnimationController? colorAnimationController;
  Animation<Color?>? colorAnimation;
  double? width;
  Duration animationDuration = Duration(milliseconds: 500);
  Widget? progressWidget;

  // Start color animations when the state changes
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

  // Create a color animation between the given [begin] and [end] colors
  Animation<Color?> _colorAnimation(Color? begin, Color? end) =>
      ColorTween(begin: begin, end: end).animate(CurvedAnimation(
        parent: colorAnimationController!,
        curve: Interval(
          0,
          1,
          curve: Curves.easeIn,
        ),
      ));

  // Get the background color based on the current animation value or the current state
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

  // Get a new animation controller
  AnimationController get _animationController =>
      AnimationController(duration: animationDuration, vsync: this);

  // Get the progress widget or a default CircularProgressIndicator if not provided
  Widget get _progress =>
      widget.progressWidget ??
      CircularProgressIndicator(
        backgroundColor: widget.stateColors[widget.state],
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );

  @override
  void dispose() {
    colorAnimationController!.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomProgressButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.state != widget.state) {
      colorAnimationController?.reset();
      startAnimations(oldWidget.state, widget.state);
    }
  }

  // Get the button child based on whether it's in the loading state or not
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

  // Get an animated opacity widget based on visibility and the child widget
  AnimatedOpacity _animatedOpacity(bool visibility, Widget? child) =>
      AnimatedOpacity(
        opacity: visibility ? 1.0 : 0.0,
        duration: Duration(milliseconds: 250),
        child: child,
      );

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
          ),
        );
      },
    );
  }

  // Get the button child based on the current animation value
  Widget get _buttonChild => getButtonChild(
      colorAnimation == null ? true : colorAnimation!.isCompleted);

  // Get the elevation for elevated and outlined button shapes
  double get _buttonElevation =>
      widget.buttonShapeEnum == ButtonShapeEnum.elevated ||
              widget.buttonShapeEnum == ButtonShapeEnum.outline
          ? widget.elevation
          : 0.0;

  // Get the button shape based on the current button shape enum
  RoundedRectangleBorder get buttonShape =>
      widget.buttonShapeEnum == ButtonShapeEnum.elevated ||
              widget.buttonShapeEnum == ButtonShapeEnum.flat
          ? _roundedRectangleBorderElevated
          : _roundedRectangleBorderOutlined;

  // Get the background color for the outlined button shape
  Color get _backgroundColor =>
      widget.buttonShapeEnum == ButtonShapeEnum.elevated ||
              widget.buttonShapeEnum == ButtonShapeEnum.flat
          ? backgroundColor!
          : widget.inLineBackgroundColor;

  // Get the rounded rectangle border for the elevated button shape
  RoundedRectangleBorder get _roundedRectangleBorderElevated =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          widget.radius == null ? widget.height / 2 : widget.radius!,
        ),
        side: BorderSide(color: Colors.transparent, width: 0),
      );

  // Get the rounded rectangle border for the outlined button shape
  RoundedRectangleBorder get _roundedRectangleBorderOutlined =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          widget.radius == null ? widget.height / 2 : widget.radius!,
        ),
        side: BorderSide(color: backgroundColor!, width: 1),
      );
}
