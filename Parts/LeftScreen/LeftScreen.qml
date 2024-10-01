import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import "../Icons"
import "../"


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

    RowLayout {
        id: root
        property int index: 0
        property int batteryPercentage: 90
        spacing : 18
        RowLayout {
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            spacing: 4
            Text {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                property bool current: root.index === 0
                color: current ? Theme.isDark ? Theme.white : "#171717" : Theme.black20
                text: "P"
                font.family: "Inter"
                font.bold: Font.Bold
                font.pixelSize: 18
            }
            Text {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                property bool current: root.index === 1
                color: current ? "#171717" : Theme.black20
                text: "R"
                font.family: "Inter"
                font.bold: Font.Bold
                font.pixelSize: 18
            }
            Text {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                property bool current: root.index === 2
                color: current ? "#171717" : Theme.black20
                text: "N"
                font.family: "Inter"
                font.bold: Font.Bold
                font.pixelSize: 18
            }
            Text {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                property bool current: root.index === 3
                color: current ? "#171717" : Theme.black20
                text: "D"
                font.family: "Inter"
                font.bold: Font.Bold
                font.pixelSize: 18
            }
        }

        RowLayout {
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Image {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    source: "qrc:/assets/icons/battery.png"
                    sourceSize: Qt.size(40,50)
                }
                Text {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    color:"black"
                    text: "20%"
                    font.family: "Inter"
                    font.bold: Font.Bold
                    font.pixelSize: 10
                }
            }

    }

}
