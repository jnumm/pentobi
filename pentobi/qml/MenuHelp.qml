//-----------------------------------------------------------------------------
/** @file pentobi/qml/MenuHelp.qml
    @author Markus Enzenberger
    @copyright GNU General Public License version 3 or later */
//-----------------------------------------------------------------------------

import QtQuick.Controls 2.3

PentobiMenu {
    title: qsTr("Help")

    PentobiMenuItem {
        action: actionHelp
    }
    Action {
        text: qsTr("Report Bug")
        onTriggered: Qt.openUrlExternally("https://github.com/enz/pentobi/issues")
    }
    Action {
        text: qsTr("About Pentobi")
        onTriggered: aboutDialog.open()
    }
}
