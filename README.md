# progress_button

Progress button help developer to make custom progress with button and animation.

## Getting Started

Features
```groovy
    1.change button shape with elevated, outline or flat
    2.change button state using idle, loading, success or fail
    3.you can use button with icon
```
## Examples: ProgressButton
```groovy
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
               onPressed: () {},
             )
```
## Examples: ProgressButton.icon
```groovy
 ProgressButton.icon(
              // set states of button with text and your custom icon is widget
              iconButtons: {
                ButtonState.success: CustomIconButton(
                    icon: Icon(Icons.check),
                    color: Colors.green,
                    text: 'Success'),
                ButtonState.fail: CustomIconButton(
                    icon: Icon(Icons.clear), color: Colors.red, text: 'Fail'),
                ButtonState.loading: CustomIconButton(
                    icon: Icon(Icons.downloading),
                    color: Colors.red,
                    text: 'Loading'),
                ButtonState.idle: CustomIconButton(
                    icon: Icon(Icons.login), color: Colors.green, text: 'Idle'),
              },
              // set default text style from here
              textStyle: TextStyle(color: Colors.black, fontSize: 18.0),
              // padding between icon and text
              iconPadding: 10.0,
              // used in case of ButtonShapeEnum = ButtonShapeEnum.flat
              // this is line rounded to button
              inLineBackgroundColor: Colors.red,
              // change button color depending on current button state
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
              // change alignment of progress in case of loading state
              progressIndicatorAlignment: MainAxisAlignment.center,
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
              onPressed: () {},
            )
```
License
--------
MIT License

Copyright (c) 2021 George Samir

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.