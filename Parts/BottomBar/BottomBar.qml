import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import "../Icons/"

Rectangle {
    id: bottomBar
    anchors{
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }

    color: "black"
    height: parent.height / 12

    Image{
        id:carSettingsIcon
        anchors {
            left:  parent.left
            leftMargin: 30
            verticalCenter: parent.verticalCenter
        }

        height: parent.height * .85
        fillMode: Image.PreserveAspectFit

        source: "qrc:/assets/electric-car.png"

    }


    RowLayout {
            id: middleLayout
            anchors.centerIn: parent
            spacing: 20

            Icon{
                icon.source: "qrc:/assets/icons/phone-call.png"
            }

            Icon{
                icon.source: "qrc:/assets/icons/radio.png"
            }

            Icon{
                icon.source: "qrc:/assets/icons/bluetooth.png"
            }

            Icon{
                icon.source: "qrc:/assets/icons/spotify.png"
            }

            Icon{
                icon.source: "qrc:/assets/icons/camera.png"
            }

            Icon{
                icon.source: "qrc:/assets/icons/video-marketing.png"
            }

        }
    HVAC{
        id: driverHVAC
        anchors{
            top: parent.top
            bottom: parent.bottom
            right: volume.right
            rightMargin: 150
            left: carSettingsIcon.right
        }
        hvacController: passengerHVAC
    }

    VolumeControl{
        id: volumeControl
        anchors {
            right:  parent.right
            rightMargin: 30
            top: parent.top
            bottom: parent.bottom
        }

    }
}

