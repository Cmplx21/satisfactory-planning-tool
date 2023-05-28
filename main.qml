import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: "Satisfactory Planning Tool"

    Material.theme: Material.Dark // Set dark mode
    Material.accent: Material.Teal // Set accent color

    Component.onCompleted: {
        window.showMaximized()
    }

    //    Drawer {
    //        id: drawer
    //        width: 0.25 * window.width
    //        height: window.height
    //        position: 0.1
    //    }
    Flickable {
        id: flickable
        anchors.fill: parent
        contentWidth: drawArea.width * drawArea.scale
        contentHeight: drawArea.height * drawArea.scale
        interactive: true

        PinchArea {
            id: pinchArea
            anchors.fill: parent
            property real minScale: 0.1
            property real maxScale: 10

            onPinchStarted: {
                pinch.target = drawArea
                pinch.minimumScale = minScale
                pinch.maximumScale = maxScale
            }
            onPinchUpdated: {
                flickable.contentX += pinch.previousCenter.x - pinch.center.x
                flickable.contentY += pinch.previousCenter.y - pinch.center.y
            }
        }

        Rectangle {
            id: drawArea
            width: 2000
            height: 2000
            color: "lightgrey"
            scale: 1

            MouseArea {
                id: drawAreaMouseArea
                anchors.fill: parent
                preventStealing: true // Prevent the PinchArea from stealing the MouseArea's events

                onWheel: function (wheel) {
                    var scaleChange = 1.0 + (wheel.angleDelta.y / 1200.0)
                    var newScale = Math.min(Math.max(
                                                pinchArea.minScale,
                                                drawArea.scale * scaleChange),
                                            pinchArea.maxScale)
                    drawArea.scale = newScale
                }
            }
        }
    }
}
