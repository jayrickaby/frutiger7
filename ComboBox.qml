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

    indicator: DropdownIndicator {
        width: 17
        height: control.height
        anchors.right: control.right

        buttonType: DropdownIndicator.ButtonTypes.Right

        onClicked: {
            if (popup.opened) {
                popup.close()
                return
            }

            popup.open()
            return
        }
    }

    contentItem: TextField {
        id: textField
        enabled: control.editable
        anchors.right: control.right

        rightPadding: indicator.width + 4

        // Force binding because else it won't update
        Binding on text {
            value: control.displayText
        }
    }

     popup: T.Popup {
        id: itemList
        y: control.height
        width: control.width
        height: Math.min(contentItem.implicitHeight + topPadding + bottomPadding, control.Window.height - topMargin - bottomMargin)

        font: control.font
        palette: control.palette

        padding: 1
        rightPadding: padding + shadowMargin
        bottomPadding: padding + shadowMargin

        popupType: Popup.Window

        onOpenedChanged: {
            if (opened) indicator.down = true
            else indicator.down = undefined
        }

        contentItem: ListView {
            id: itemList
            clip: true

            implicitHeight: contentHeight
            model: control.delegateModel
            currentIndex: control.highlightedIndex
            highlightMoveDuration: 0
            boundsBehavior: Flickable.StopAtBounds

            T.ScrollBar.vertical: ScrollBar {
                interactive: false
            }
        }

        background: Item {
            anchors.fill: parent
            RectangularShadow {
                anchors.fill: parent

                anchors.rightMargin: 8 + popup.shadowMargin
                anchors.bottomMargin: 8 + popup.shadowMargin

                blur: 2
                offset.x: 1 + 8
                offset.y: 1 + 8
                color: "#8e8e8e"
                spread: 2
                radius: 0
            }

            BorderImage {
                anchors.fill: parent

                anchors.rightMargin: popup.shadowMargin
                anchors.bottomMargin: popup.shadowMargin

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