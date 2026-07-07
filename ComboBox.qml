// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only
// Qt-Security score:significant reason:default

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Controls.Basic.impl
import QtQuick.Effects
import QtQuick.Templates as T

import "."

T.ComboBox {
    id: control

    readonly property url imgBorder: Theme.dirItemAssets + "combobox/border.ico"
    readonly property url imgDropdownButtonRight: Theme.dirItemAssets + "combobox/dropdownbuttonright.ico"
    readonly property url imgDropdownButtonArrow: Theme.dirItemAssets + "combobox/dropdownbutton_arrow.ico"
    readonly property url imgListBoxBorder: Theme.dirItemAssets + "listbox/border_vscroll.ico"

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    rightPadding: padding + comboIndicator.width

    enum DropdownButtonStates { Normal, Hot, Pressed, Disabled }
    enum BorderStates { Normal, Hot, Focused, Disabled }
    enum ListBoxBorderStates { Normal, Focused, Hot, Disabled }

    delegate: ItemDelegate {
        required property var model
        required property int index

        height: 15
        width: ListView.view.width
        text: model[control.textRole]
        palette.text: control.palette.text
        palette.highlightedText: control.palette.highlightedText
        highlighted: control.highlightedIndex === index
        hoverEnabled: control.hoverEnabled

        font.letterSpacing: 0.05

        padding: 0

        bottomPadding: 1
        leftPadding: 2

        background: Rectangle {
            color: highlighted ? Theme.colTextHighlight : "transparent"
        }
    }

    indicator: Item {
        id: comboIndicator
        width: 17
        height: control.height
        anchors.right: parent.right

        BorderImage {
            id: comboIndicatorBackground
            anchors.fill: parent
            border.left: 2
            border.right: 2
            border.top: 2
            border.bottom: 2
            horizontalTileMode: BorderImage.Repeat
            verticalTileMode: BorderImage.Stretch

            source: imgDropdownButtonRight

            currentFrame: {
                if (control.down && comboIndicatorBackground.opacity === 1) return ComboBox.DropdownButtonStates.Pressed

                return ComboBox.DropdownButtonStates.Hot
            }

            // This is weird spaghetti logic.
            // Mouse begins initial fade in -> Clicked activates pushed state -> Pushed state maintains that it stays faded in even if no mouse
            opacity: indicatorMouseArea.containsMouse || control.popup.visible ? 1 : 0

            Behavior on opacity {
                NumberAnimation {
                    duration: comboIndicatorBackground.opacity === 0 ? 200 : 700
                    easing.type: Easing.Linear
                }
            }
        }
         MouseArea {
                id: indicatorMouseArea
                anchors.fill: parent
                hoverEnabled: true

                propagateComposedEvents: true
                onPressed: (mouse) => mouse.accepted = false
            }

            Image {
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: -1
                source: imgDropdownButtonArrow
                currentFrame: {
                    if (!control.enabled) return ComboBox.DropdownButtonStates.Disabled

                    return ComboBox.DropdownButtonStates.Normal
                }
            }
    }

    contentItem: T.TextField {
        id: textField

        enabled: control.editable

        padding: 6
        topPadding: 3
        bottomPadding: padding - 1

        verticalAlignment: TextInput.AlignVCenter

        selectionColor: Theme.colTextHighlight

        font.pointSize: 9
        font.letterSpacing: 0.05
        renderType: Text.NativeRendering
    }

    background: BorderImage {
        anchors.fill: parent
        visible: control.editable

        border.left: 2
        border.right: 2
        border.top: 2
        border.bottom: 2

        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Repeat

        // Swap the image asset depending on whether the button is hovered or pressed
        source: imgBorder

        currentFrame: {
            if (!control.enabled) return ComboBox.BorderStates.Disabled

            if (control.focused) return ComboBox.BorderStates.Focused

            if (control.hovered) return ComboBox.BorderStates.Hot

            return ComboBox.BorderStates.Normal
        }
    }

     popup: T.Popup {
        id: itemList
        y: control.height
        width: control.width
        height: Math.min(contentItem.implicitHeight + topPadding + bottomPadding, control.Window.height - topMargin - bottomMargin)
        topMargin: 6
        bottomMargin: 6
        font: control.font
        palette: control.palette
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.delegateModel
            currentIndex: control.highlightedIndex
            highlightMoveDuration: 0

            T.ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Item {
            RectangularShadow {
                width: itemList.width - 8
                height: itemList.height - 8
                blur: 2
                offset.x: 1 + 8
                offset.y: 1 + 8
                color: "#8e8e8e"
                spread: 2
                radius: 0
            }

            BorderImage {
                anchors.fill: parent

                border.left: 1
                border.right: 1
                border.top: 1
                border.bottom: 1

                horizontalTileMode: BorderImage.Repeat
                verticalTileMode: BorderImage.Repeat

                source: imgListBoxBorder

                currentFrame : {
                    return ComboBox.ListBoxBorderStates.Normal
                }
            }
        }
    }
}