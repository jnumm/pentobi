//-----------------------------------------------------------------------------
/** @file pentobi/qml/PentobiMenuItem.qml
    @author Markus Enzenberger
    @copyright GNU General Public License version 3 or later */
//-----------------------------------------------------------------------------

import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2

// Custom menu item that displays shortcuts (MenuItem in Qt 5.11 does not).
MenuItem {
    id: root

    property string shortcut: action && action.shortcut ? action.shortcut : ""

    property real _anyItemIndicatorWidth: {
        if (menu)
            for (var i = 0; i < menu.count; ++i)
                if (menu.itemAt(i).checkable)
                    return menu.itemAt(i).indicator.width
        return 0
    }

    implicitHeight:
        Math.round(font.pixelSize * (isDesktop ? 1.9 : 2.2)
                   * Screen.devicePixelRatio) / Screen.devicePixelRatio
    // Explicitly set hoverEnabled to true, otherwise hover highlighting and
    // submenu opening doesn't work in KDE on Ubuntu 18.10 (bug in Qt?)
    hoverEnabled: true
    background: Rectangle {
        color: {
            if (! root.highlighted)
                return "transparent"
            // Note that MenuItem in Qt 5.11 does neither fully use the system
            // palette, nor make its actually used colors available.
            // palette.midlight looks similar to the one used in style Default,
            // but doesn't work in style Fusion on KDE, so we use
            // palette.highlight there.
            return globalStyle.toLowerCase() === "fusion" ?
                        palette.highlight : palette.midlight
        }
    }
    contentItem: RowLayout {
        Label {
            id: labelText

            text: root.text
            color: {
                // See comment at background
                if (root.highlighted)
                    return globalStyle.toLowerCase() === "fusion" ?
                                palette.highlightedText : palette.buttonText
                return palette.text
            }
            verticalAlignment: Text.AlignVCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.leftMargin: 0.1 * font.pixelSize + _anyItemIndicatorWidth
                               + 0.2 * font.pixelSize
            Layout.rightMargin: 0.4 * font.pixelSize
        }
        Label {
            visible: isDesktop && shortcut !== ""
            text: {
                var text = shortcut
                //: Shortcut modifier key as displayed in menu item text (abbreviate if long)
                text = text.replace("Ctrl", qsTr("Ctrl"))
                //: Shortcut modifier key as displayed in menu item text (abbreviate if long)
                return text.replace("Shift", qsTr("Shift"))
            }
            color: labelText.color
            opacity: 0.6
            verticalAlignment: Text.AlignVCenter
            Layout.fillHeight: true
            Layout.rightMargin: 0.1 * font.pixelSize
        }
    }
}
