import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "."

Window {
    id: control
    width: columnLayout.implicitWidth
    height: columnLayout.implicitHeight

    color: Theme.colWindowBackground

    // Replicate Win7 (based on inspect)
    property string mainInstruction: ""
    property string contentText: ""


    ColumnLayout {
        id: columnLayout
        Layout.fillWidth: true
        Layout.fillHeight: true

        RowLayout {
            Layout.alignment: Qt.AlignTop
            Image {
                Layout.preferredHeight: 32
                Layout.preferredWidth: 32

                source: "assets/items/dialog/error.ico"
            }

            Layout.leftMargin: 10
            Layout.rightMargin: 10
            Layout.topMargin: 10
            Layout.bottomMargin: 10

            Text {
                text: control.contentText
                // font.letterSpacing: 0.10
                font.pointSize: 9
                renderType: Text.NativeRendering
            }
        }
        Rectangle {
            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true
            Layout.preferredHeight: 41

            Image {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                source: "assets/items/dialog/secondarypanel_background.png"
                fillMode: Image.Stretch
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: 8
                anchors.rightMargin: 10

                Item { Layout.fillWidth: true }  // spacer, push buttons right
                Button {
                    Layout.preferredHeight: 21
                    Layout.preferredWidth: 66
                    text: "OK"
                }
            }

            color: Theme.colWindowSecondaryBackground
        }
    }
}