//-----------------------------------------------------------------------------
/** @file pentobi/qml/ScoreDisplay.qml
    @author Markus Enzenberger
    @copyright GNU General Public License version 3 or later */
//-----------------------------------------------------------------------------

import QtQuick 2.0

Row {
    id: root

    property real pointSize
    property int altPlayer: gameModel.altPlayer
    property real points0: gameModel.points0
    property real points1: gameModel.points1
    property real points2: gameModel.points2
    property real points3: gameModel.points3
    property real bonus0: gameModel.bonus0
    property real bonus1: gameModel.bonus1
    property real bonus2: gameModel.bonus2
    property real bonus3: gameModel.bonus3
    property bool hasMoves0: gameModel.hasMoves0
    property bool hasMoves1: gameModel.hasMoves1
    property bool hasMoves2: gameModel.hasMoves2
    property bool hasMoves3: gameModel.hasMoves3

    ScoreElement2 {
        visible: gameModel.nuColors == 4 && gameModel.nuPlayers == 2
        value: points0 + points2
        isFinal: ! hasMoves0 && ! hasMoves2
        pointSize: root.pointSize
        height: root.height
        width: 5.9 * pointSize
        color1: gameDisplay.color0
        color2: gameDisplay.color2
    }
    ScoreElement2 {
        visible: gameModel.nuColors == 4 && gameModel.nuPlayers == 2
        value: points1 + points3
        isFinal: ! hasMoves1 && ! hasMoves3
        pointSize: root.pointSize
        height: root.height
        width: 5.9 * pointSize
        color1: gameDisplay.color1
        color2: gameDisplay.color3
    }
    ScoreElement {
        value: points0
        bonus: bonus0
        isFinal: ! hasMoves0
        pointSize: root.pointSize
        height: root.height
        width: 5 * pointSize
        color: color0
    }
    ScoreElement {
        value: points1
        bonus: bonus1
        isFinal: ! hasMoves1
        pointSize: root.pointSize
        height: root.height
        width: 5 * pointSize
        color: color1
    }
    ScoreElement {
        visible: gameModel.nuColors > 2
        value: points2
        bonus: bonus2
        isFinal: ! hasMoves2
        pointSize: root.pointSize
        height: root.height
        width: 5 * pointSize
        color: color2
    }
    ScoreElement {
        visible: gameModel.nuColors > 3 && gameModel.gameVariant != "classic_3"
        value: points3
        bonus: bonus3
        isFinal: ! hasMoves3
        pointSize: root.pointSize
        height: root.height
        width: 5 * pointSize
        color: color3
    }
    ScoreElement2 {
        visible: gameModel.gameVariant == "classic_3"
        value: points3
        isAltColor: true
        isFinal: ! hasMoves3
        pointSize: root.pointSize
        height: root.height
        width: 5.9 * pointSize
        color1: theme.colorGreen
        color2:
            switch (altPlayer) {
            case 0: return gameDisplay.color0
            case 1: return gameDisplay.color1
            case 2: return gameDisplay.color2
            }
    }
}
