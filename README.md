# UniQmlTk

A Qt6 QML toolkit library providing reusable UI components with theming support and custom window management. Made specifically for Uni desktop environment.

## Features

- **Custom Window Components**: Frameless window with custom title bar and resize handles
- **Overlay Support**: Layer shell integration for desktop overlays with animations
- **Theme Management**: Dynamic theme and accent color management with Qt Universal style integration
- **UI Components**: Pre-styled buttons and other reusable components

## Components

### BaseWindow
A frameless `ApplicationWindow` with custom window decorations, including:
- Custom title bar with drag support
- Double-click to maximize/restore
- Window resize handles on all edges and corners
- Integrated theme management
- Content loader for easy customization

### BaseSidebarShellOverlay
A sidebar overlay window using KDE Layer Shell for desktop integration:
- Right-anchored overlay with smooth slide-in animations
- Configurable title and subtitle
- Content loader for custom content
- Automatic theme management

### ThemeManager
QML singleton-style theme manager that:
- Synchronizes with system settings
- Supports light/dark theme switching
- Provides 20 preset accent colors
- Automatically updates windows when settings change

### UniButton
A pre-styled button component with consistent padding and font sizing.

## Requirements

- Qt6 (Core, Quick, Gui modules)
- CMake 3.16 or higher
- C++20 compatible compiler
- KDE Layer Shell (for overlay components)

## Building

```bash
mkdir build
cd build
cmake ..
cmake --build .
```

## Installation

```bash
sudo cmake --install . --prefix=/usr
```

The library will be installed to standard system directories:
- Libraries: `/usr/lib/`
- QML modules: `/usr/lib/qt6/qml/UniQmlTk/`
- CMake config: `/usr/lib/cmake/UniQmlTk/`

## Usage

### CMake Integration

```cmake
find_package(UniQmlTk REQUIRED)
target_link_libraries(your_target PRIVATE UniQmlTk::UniQmlTk)
```

### QML Import

```qml
import UniQmlTk 1.0

BaseWindow {
    mainContent: Component {
        Rectangle {
            color: "lightblue"
            Text {
                anchors.centerIn: parent
                text: "Hello, UniQmlTk!"
            }
        }
    }
}
```

### Using Theme Manager

The `ThemeManager` is automatically initialized in `BaseWindow` and `BaseSidebarShellOverlay`. To use it standalone:

```qml
import UniQmlTk 1.0

ApplicationWindow {
    id: window

    ThemeManager {
        id: themeManager
        targetWindow: window
        Component.onCompleted: initialize()
    }
}
```

Theme settings are stored in system settings under `global/theme` and `global/accent` keys.

### Creating an Overlay

```qml
import UniQmlTk 1.0

BaseSidebarShellOverlay {
    titleText: "Settings"
    subtitleText: "Configure your application"

    mainContent: Component {
        // Your custom content here
    }
}
```

## License

MIT
