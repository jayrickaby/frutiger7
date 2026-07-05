import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "."

Window {
    id: control
    width: columnLayout.implicitWidth
    height: columnLayout.implicitHeight

    minimumWidth: columnLayout.implicitWidth
    minimumHeight: columnLayout.implicitHeight
    maximumWidth: columnLayout.implicitWidth
    maximumHeight: columnLayout.implicitHeight

    color: Theme.colWindowBackground

    // Replicate Win7 (based on inspect)
    property string mainInstruction: ""
    property string contentText: ""


    ColumnLayout {
        id: columnLayout

        spacing: 0

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

            spacing: 10

            Text {
                Layout.leftMargin: 0
                Layout.rightMargin: -1
                Layout.topMargin: -4
                Layout.bottomMargin: 4

                text: control.contentText
                font.letterSpacing: 0.03
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

                Button {
                    Layout.alignment: Qt.AlignBottom | Qt.AlignRight
                    Layout.preferredHeight: 21
                    Layout.preferredWidth: 66
                    Layout.rightMargin: 1
                    Layout.bottomMargin: 2
                    text: "OK"

                    textVCenterOffset: -1

                    onClicked: {
                        control.close()
                    }
                }
            }

            color: Theme.colWindowSecondaryBackground
        }
    }
}