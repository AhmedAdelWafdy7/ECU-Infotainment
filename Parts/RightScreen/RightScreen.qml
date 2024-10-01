import QtQuick 2.15
import QtLocation 5.15
import QtPositioning 5.15
import "../Icons"
import "../"

Rectangle {
    id: rightScreen

    anchors{
        top: parent.top
        right: parent.right
        bottom: bottomBar.top
    }

    width: parent.width * 2/3



    Plugin {
            id: mapPlugin
            name: "mapboxgl"
            PluginParameter { name: "mapboxgl.access_token"; value: "pk.eyJ1IjoiaGFzZWVidGFyaXExOTk4IiwiYSI6ImNsbGw4cXQ3YTFsdXkzanBxaG1rZDZrYTgifQ.8M9sbj-GM8oDrhAfCMUasw"}
        }

        Map {
            id: map
            anchors.fill: parent
            plugin: mapPlugin
            center: QtPositioning.coordinate(31.037933, 31.381523) // Oslo
            zoomLevel: 14

            PinchHandler {
                id: pinch
                target: null
                onActiveChanged: if (active) {
                    map.startCentroid = map.toCoordinate(pinch.centroid.position, false)
                }
                onScaleChanged: (delta) => {
                    map.zoomLevel += Math.log2(delta)
                    map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
                }
                onRotationChanged: (delta) => {
                    map.bearing -= delta
                    map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
                }
                grabPermissions: PointerHandler.TakeOverForbidden
            }
            WheelHandler {
                id: wheel
                // workaround for QTBUG-87646 / QTBUG-112394 / QTBUG-112432:
                // Magic Mouse pretends to be a trackpad but doesn't work with PinchHandler
                // and we don't yet distinguish mice and trackpads on Wayland either
                acceptedDevices: Qt.platform.pluginName === "cocoa" || Qt.platform.pluginName === "wayland"
                                 ? PointerDevice.Mouse | PointerDevice.TouchPad
                                 : PointerDevice.Mouse
                rotationScale: 1/120
                property: "zoomLevel"
            }
            DragHandler {
                id: drag
                target: null
                onTranslationChanged: (delta) => map.pan(-delta.x, -delta.y)
            }
            Shortcut {
                enabled: map.zoomLevel < map.maximumZoomLevel
                sequence: StandardKey.ZoomIn
                onActivated: map.zoomLevel = Math.round(map.zoomLevel + 1)
            }
            Shortcut {
                enabled: map.zoomLevel > map.minimumZoomLevel
                sequence: StandardKey.ZoomOut
                onActivated: map.zoomLevel = Math.round(map.zoomLevel - 1)
            }
        }

        Image {
            id: lockIcon
            source: (systemHandler.carLocked ? "qrc:/assets/padlock.png" : "qrc:/assets/open-padlock-silhouette.png")

            MouseArea{
                anchors.fill: parent
                onClicked: systemHandler.setCarLocked( !systemHandler.carLocked)
            }

            anchors{
                top: parent.top
                left: parent.left
                margins: 10
            }
            width: parent.width / 50
            fillMode: Image.PreserveAspectFit
        }

        Text{
            id:dateDisplay
            anchors{
                left: lockIcon.right
                leftMargin: 20
                bottom: lockIcon.bottom
            }

            font.pixelSize: 12
            font.bold: true
            color: "black"

            text: systemHandler.currentTime
        }
        Text{
            id:tempDisplay
            anchors{
                left: dateDisplay.right
                leftMargin: 20
                bottom: dateDisplay.bottom
            }

            font.pixelSize: 12
            font.bold: true
            color: "black"

            text: systemHandler.outdoorTemp + "°F"
        }
        Image{
            id: usernameIcon
            anchors{
                left: tempDisplay.right
                leftMargin: 20
                bottom: tempDisplay.bottom
            }
            source: "qrc:/assets/icons/icons.svg"
            sourceSize: Qt.size(18,18)
        }

        Text{
            id:usernameDisplay
            anchors{
                left: usernameIcon.right
                leftMargin: 2
                bottom: usernameIcon.bottom
            }

            font.pixelSize: 12
            font.bold: true
            color: "black"

            text: systemHandler.username
        }

        NavigationSearchBox{
            id: navSearchbox
            width: parent.width * 1/3
            height: parent.height * 1 /12
            anchors{
                left: lockIcon.left
                top: lockIcon.bottom
                topMargin: 10
            }
        }


}
