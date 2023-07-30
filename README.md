Sure! Below is the full README for version 2.0.0 of the `ProgressButton` widget.

# ProgressButton v2.0.0

`ProgressButton` is a customizable button widget for Flutter that allows displaying different states based on the `ButtonState` enum. It supports a loading state with an optional progress indicator. The appearance and behavior of the button can be customized using various properties.

## Installation

Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  progress_button: ^2.0.0
```

Then, run `flutter pub get` to install the package.

## Usage

Import the package in your Dart file:

```dart
import 'package:progress_button/progress_button.dart';
```

### Basic Usage

To use the `ProgressButton`, provide a map of widgets for different button states and a map of colors for different states. Then, set the `state` property to control the current state of the button.

```dart
ProgressButton(
  stateWidgets: {
    ButtonState.idle: Text('Submit'), // Idle state widget
    ButtonState.loading: CircularProgressIndicator(), // Loading state widget
    ButtonState.success: Icon(Icons.check), // Success state widget
    ButtonState.fail: Icon(Icons.close), // Fail state widget
  },
  stateColors: {
    ButtonState.idle: Colors.blue, // Idle state color
    ButtonState.loading: Colors.grey, // Loading state color
    ButtonState.success: Colors.green, // Success state color
    ButtonState.fail: Colors.red, // Fail state color
  },
  state: ButtonState.idle, // Initial state
  onPressed: () {
    // Handle button press
  },
),
```

### Advanced Usage

#### Customizing Button Properties

You can customize various properties of the `ProgressButton`:

```dart
ProgressButton(
  // ... other properties
  minWidth: 200.0, // Minimum width of the button
  maxWidth: 400.0, // Maximum width of the button
  radius: 20.0, // Corner radius of the button
  height: 48.0, // Height of the button
  progressIndicatorSize: 20.0, // Size of the progress indicator
  progressAlignment: MainAxisAlignment.center, // Alignment of the progress indicator
  padding: EdgeInsets.symmetric(horizontal: 16.0), // Padding around the button's child
  minWidthStates: [ButtonState.loading], // List of states that should use the minimum width
  buttonShapeEnum: ButtonShapeEnum.elevated, // Shape of the button (elevated, outline, or flat)
  elevation: 4.0, // Elevation of the button (used only for elevated and outlined shapes)
  inLineBackgroundColor: Colors.white, // Background color for loading and success states
  enable: true, // Enable or disable the button
),
```

#### Using Icon Buttons

You can use the `ProgressButton.icon` constructor to create buttons with icon buttons for different states:

```dart
ProgressButton.icon(
  iconButtons: {
    ButtonState.idle: CustomIconButton(
      text: 'Submit',
      icon: Icon(Icons.send),
      color: Colors.blue,
    ),
    ButtonState.loading: CustomIconButton(
      icon: CircularProgressIndicator(),
      color: Colors.grey,
    ),
    ButtonState.success: CustomIconButton(
      icon: Icon(Icons.check),
      color: Colors.green,
    ),
    ButtonState.fail: CustomIconButton(
      icon: Icon(Icons.close),
      color: Colors.red,
    ),
  },
  onPressed: () {
    // Handle button press
  },
),
```

## CustomIconButton Class

The `CustomIconButton` class represents an icon button with optional text and color. You can use this class to customize the appearance of the `ProgressButton` icon buttons.

```dart
class CustomIconButton {
  final String? text;
  final Widget? icon;
  final Color color;

  const CustomIconButton({
    this.text,
    this.icon,
    required this.color,
  });
}
```

## Utility Functions

The `ProgressButton` package also provides utility functions to help build widgets containing icons, text, and gaps with specified styles:

- `buildChildWithIcon`: A function to build a widget containing an icon and optional text with a specified gap.
- `buildChildWithIC`: A function to build a widget containing text and an icon with a specified gap.
- `buildText`: A function to build a text widget with the provided text and text style.

## Feedback and Contributions

We welcome feedback and contributions! If you encounter any issues or have suggestions for improvements, please [file an issue](https://github.com/georgesamirmansour/custom_progress_button/issues) on GitHub.

If you want to contribute to the project, feel free to open a pull request. We appreciate your help in making `ProgressButton` even better!

## License

This project is licensed under the [MIT License](https://github.com/georgesamirmansour/custom_progress_button/LICENSE).