## Changelog

### Version 2.0.1
- update README

### Version 2.0.0
- **Breaking Change**: Renamed the package from `progress_button` to `custom_progress_button` to avoid naming conflicts.
- Added support for null-safety.
- Updated the `custom_icon_button` dependency to version 2.0.0, which also supports null-safety.
- Updated Flutter SDK version to support null-safety.
- Updated documentation and examples for clarity and accuracy.
- Improved overall performance and stability.

### Version 1.2.0
- Added support for customizing the button's corner radius.
- Added new properties to customize the button's appearance:
    - `elevation`: The elevation of the button for elevated and outlined shapes.
    - `inLineBackgroundColor`: The background color of the button when it's in the loading or success state.
    - `enable`: If false, the button will be disabled and not respond to touch events.
    - `progressAlignment`: The alignment of the progress indicator when `progressWidget` is not provided.
    - `minWidthStates`: The list of states that should use the minimum width of the button.
    - `buttonShapeEnum`: The shape of the button (elevated, outline, or flat).
- Fixed a bug where the button's appearance would not update correctly when the state changes.

### Version 1.1.0
- Added support for creating buttons with icon buttons for different states using the `ProgressButton.icon` constructor.
- Introduced the `CustomIconButton` class to represent an icon button with optional text and color.
- Added utility functions to help build widgets containing icons, text, and gaps with specified styles.
- Improved the README with comprehensive usage instructions and examples.

### Version 1.0.0
- Initial release of the `progress_button` package.
- Provides a customizable button widget that shows different states based on the `ButtonState` enum.
- Supports a loading state with an optional progress indicator.
- Allows customization of appearance and behavior using various properties.