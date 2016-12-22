import QtQuick 2.0
import QtQuick.Controls 1.1
import "Main.js" as Logic

Menu {
    title: qsTr("&Computer")

    MenuItem {
        text: qsTr("Computer &Colors")
        enabled: ! isRated
        visible: ! isAndroid || enabled
        onTriggered: Logic.showComputerColorDialog()
    }
    MenuItem {
        text: qsTr("&Play")
        enabled: ! gameModel.isGameOver && ! isRated
        visible: ! isAndroid || enabled
        onTriggered: Logic.computerPlay()
    }
    MenuSeparator { }
    MenuItem {
        text: qsTr("Play &Single Move")
        enabled: ! gameModel.isGameOver && ! isRated
        visible: ! isAndroid || enabled
        onTriggered: { isPlaySingleMoveRunning = true; Logic.genMove() }
    }
    MenuItem {
        text: qsTr("St&op")
        enabled: playerModel.isGenMoveRunning && ! isRated
         // Android doesn't use levels with long thinking times
        visible: ! isAndroid
        onTriggered: cancelRunning()
    }
    MenuSeparator { }
    Menu {
        title:
            switch (gameModel.gameVariant)
            {
            case "classic": return qsTr("&Level (Classic, 4 Players)")
            case "classic_2": return qsTr("&Level (Classic, 2 Players)")
            case "classic_3": return qsTr("&Level (Classic, 3 Players)")
            case "duo": return qsTr("&Level (Duo)")
            case "junior": return qsTr("&Level (Junior)")
            case "trigon": return qsTr("&Level (Trigon, 4 Players)")
            case "trigon_2": return qsTr("&Level (Trigon, 2 Players)")
            case "trigon_3": return qsTr("&Level (Trigon, 3 Players)")
            case "nexos": return qsTr("&Level (Nexos, 4 Players)")
            case "nexos_2": return qsTr("&Level (Nexos, 2 Players)")
            case "callisto": return qsTr("&Level (Callisto, 4 Players)")
            case "callisto_2": return qsTr("&Level (Callisto, 2 Players)")
            case "callisto_3": return qsTr("&Level (Callisto, 3 Players)")
            }
        enabled: ! isRated
        visible: ! isAndroid || enabled

        ExclusiveGroup { id: levelGroup }
        MenuItemLevel { level: 1 }
        MenuItemLevel { level: 2 }
        MenuItemLevel { level: 3 }
        MenuItemLevel { level: 4 }
        MenuItemLevel { level: 5 }
        MenuItemLevel { level: 6 }
        MenuItemLevel { level: 7 }
    }
}
