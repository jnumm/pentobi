import QtQuick.Controls 1.1
import "Main.js" as Logic

MenuItem {
    property int level

    text: "&" + level
    checkable: true
    exclusiveGroup: levelGroup
    checked: {
        switch (gameModel.gameVariant) {
        case "classic_2": return playerModel.levelClassic2 === level
        case "classic_3": return playerModel.levelClassic3 === level
        case "duo": return playerModel.levelDuo === level
        case "trigon": return playerModel.levelTrigon === level
        case "trigon_2": return playerModel.levelTrigon2 === level
        case "trigon_3": return playerModel.levelTrigon3 === level
        case "junior": return playerModel.levelJunior === level
        case "nexos": return playerModel.levelNexos === level
        case "nexos_2": return playerModel.levelNexos2 === level
        case "callisto": return playerModel.levelCallisto === level
        case "callisto_2": return playerModel.levelCallisto2 === level
        case "callisto_3": return playerModel.levelCallisto3 === level
        default: return playerModel.levelClassic === level
        }
    }
    onTriggered: Logic.setLevel(level)
}
