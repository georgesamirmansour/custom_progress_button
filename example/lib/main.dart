import 'package:flutter/material.dart';
import 'package:custom_progress_button/custom_progress.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'progress button',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'progress button demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late ButtonState buttonState;

  @override
  void initState() {
    buttonState = ButtonState.idle;
    super.initState();
  }


  void _incrementCounter() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        _counter++;
        if (buttonState == ButtonState.idle)
          buttonState = ButtonState.loading;
        else if (buttonState == ButtonState.loading)
          buttonState = ButtonState.fail;
        else if (buttonState == ButtonState.fail)
          buttonState = ButtonState.success;
        else if (buttonState == ButtonState.success)
          buttonState = ButtonState.idle;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: 20,
            ),
            ProgressButton(
              // change button text depend on current state
              stateWidgets: {
                ButtonState.success: Text(
                  'Success',
                  style: TextStyle(fontSize: 20),
                ),
                ButtonState.fail: Text(
                  'Fail',
                  style: TextStyle(fontSize: 20),
                ),
                ButtonState.loading: Text(
                  'Loading',
                  style: TextStyle(fontSize: 20),
                ),
                ButtonState.idle: Text(
                  'Idle',
                  style: TextStyle(fontSize: 20),
                ),
              },
              // used in case of ButtonShapeEnum = ButtonShapeEnum.flat
              // this is line rounded to button
              inLineBackgroundColor: Colors.red,
              // change button color depending on current button state
              stateColors: {
                ButtonState.success: Colors.green,
                ButtonState.fail: Colors.redAccent,
                ButtonState.loading: Colors.red,
                ButtonState.idle: Colors.blue,
              },
              // called when animation of button ended
              onAnimationEnd: () {},
              // button radius
              radius: 100.0,
              // button height
              height: 70,
              // button shape enum as elevated, outline, flat
              buttonShapeEnum: ButtonShapeEnum.flat,
              // change default elevation of button,
              elevation: 10.0,
              // change alignment between progress and text of button in case of loading state
              progressAlignment: MainAxisAlignment.center,
              // disable/enable clicking on button
              enable: true,
              // button states are idle, loading, success, fail
              state: ButtonState.idle,
              // add padding
              padding: EdgeInsets.zero,
              // add max width to button
              maxWidth: 200.0,
              // default min width of button
              minWidth: 100.0,
              // progress size
              progressIndicatorSize: 10.0,
              // change default progress widget of button, default is
              progressWidget: CircularProgressIndicator(),
              // on pressed action
              onPressed: () {
                _incrementCounter();
              },
            )
          ],
        ),
      ),
    );
  }
}
