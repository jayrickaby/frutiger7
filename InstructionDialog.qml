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
    property int instructionType: InstructionDialog.Information
    property int buttons: DialogButtonBox.Ok

    flags: Qt.Dialog | Qt.WindowTitleHint | Qt.WindowCloseButtonHint

    signal buttonClicked(int role)

    enum InstructionTypes {
        Unknown,
        Warning,
        Question,
        Critical,
        Information,
        Permission,
        None
    }

    ColumnLayout {
        id: columnLayout

        spacing: 0

        RowLayout {
            Layout.alignment: Qt.AlignTop
            Image {
                Layout.preferredHeight: 32
                Layout.preferredWidth: 32

                source: {
                    switch (instructionType) {
                        case InstructionDialog.Unknown: return "assets/items/dialog/unknown.ico"
                        case InstructionDialog.Warning: return "assets/items/dialog/warning.ico"
                        case InstructionDialog.Question: return "assets/items/dialog/question.ico"
                        case InstructionDialog.Critical: return "assets/items/dialog/critical.ico"
                        case InstructionDialog.Information: return "assets/items/dialog/information.ico"
                        case InstructionDialog.Permission: return "assets/items/dialog/permission.ico"
                        case InstructionDialog.None: return ""

                        default: return ""
                    }

                }
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

            DialogButtonBox {
                id: buttonBox
                anchors.fill: parent
                anchors.margins: 10
                anchors.rightMargin: 11

                standardButtons: control.buttons

                onClicked: (button) => {
                    control.buttonClicked(button.DialogButtonBox.buttonRole)
                }
            }

            color: Theme.colWindowSecondaryBackground
        }
    }
    onActiveChanged: {
        if (!active) return

        control.requestActivate()

        // Make first button highlighted
        if (buttonBox && buttonBox.contentChildren[0]) {
            buttonBox.contentChildren[0].highlighted = true
        }
    }
}