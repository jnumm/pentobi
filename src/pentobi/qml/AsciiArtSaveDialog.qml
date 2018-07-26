//-----------------------------------------------------------------------------
/** @file pentobi/qml/AsciiArtSaveDialog.qml
    @author Markus Enzenberger
    @copyright GNU General Public License version 3 or later */
//-----------------------------------------------------------------------------

import QtQuick 2.0
import "Main.js" as Logic
import "." as Pentobi

Pentobi.FileDialog {
    title: isDesktop ? qsTr("Export ASCII Art") : ""
    selectExisting: false
    nameFilterText: qsTr("Text files (*.txt)")
    nameFilter: "*.txt"
    folder: rootWindow.folder
    onAccepted: {
        rootWindow.folder = folder
        Logic.exportAsciiArt(fileUrl)
    }
}
