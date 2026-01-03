import QtQuick
import QtQuick.Controls.Universal
import UniQmlTk

QtObject {
    id: themeManager

    property var targetWindow: null

    readonly property var colorMap: ({
                                         "Lime": Universal.Lime,
                                         "Green": Universal.Green,
                                         "Emerald": Universal.Emerald,
                                         "Teal": Universal.Teal,
                                         "Cyan": Universal.Cyan,
                                         "Cobalt": Universal.Cobalt,
                                         "Indigo": Universal.Indigo,
                                         "Violet": Universal.Violet,
                                         "Pink": Universal.Pink,
                                         "Magenta": Universal.Magenta,
                                         "Crimson": Universal.Crimson,
                                         "Red": Universal.Red,
                                         "Orange": Universal.Orange,
                                         "Amber": Universal.Amber,
                                         "Yellow": Universal.Yellow,
                                         "Brown": Universal.Brown,
                                         "Olive": Universal.Olive,
                                         "Steel": Universal.Steel,
                                         "Mauve": Universal.Mauve,
                                         "Taupe": Universal.Taupe
                                     })

    function updateTheme(theme) {
        if (targetWindow) {
            targetWindow.Universal.theme = theme === "light" ? Universal.Light : Universal.Dark
        }
    }

    function updateAccentColor(col) {
        if (targetWindow) {
            targetWindow.Universal.accent = colorMap[col] || col
        }
    }

    function updateFontFamily(family) {
        if (targetWindow) {
            targetWindow.font.family = family
        }
    }

    function initialize() {
        var theme = SystemSettings.value("global/theme", "light")
        var accent = SystemSettings.value("global/accent", "#7f5bff")
        var fontFamily = SystemSettings.value("global/fontfamily", "Noto Sans")

        updateTheme(theme)
        updateAccentColor(accent)
        updateFontFamily(fontFamily)
    }

    property Connections settingsConnection: Connections {
        target: SystemSettings

        function onSettingChanged(key, value) {
            if (key === "global/theme") {
                themeManager.updateTheme(value)
            }
            if (key === "global/accent") {
                themeManager.updateAccentColor(value)
            }
            if (key === "global/fontfamily") {
                themeManager.updateFontFamily(value)
            }
        }
    }
}
