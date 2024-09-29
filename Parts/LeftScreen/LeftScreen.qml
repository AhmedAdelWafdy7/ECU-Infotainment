import QtQuick 2.15


Rectangle {
    id: leftScreen

    anchors{
        left: parent.left
        top: parent.top
        right: rightScreen.left
        bottom:bottomBar.top
    }
    color: "white"

    Image {
        id: carRender
        anchors.centerIn: parent
        width: parent.width * 1.5
        fillMode: Image.PreserveAspectFit
        source: "qrc:/assets/carRender.jpg"
    }


}
