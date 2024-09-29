import QtQuick 2.15
import QtQuick.Window 2.15
import "Parts/BottomBar"
import "Parts/RightScreen"
import "Parts/LeftScreen"

Window {
    width: 800
    height: 480
    visible: true
    title: qsTr("Infotainment")

    BottomBar {
        id: bottomBar
    }

    LeftScreen{
        id: leftScreen
    }

    RightScreen{
        id: rightScreen
    }

}
