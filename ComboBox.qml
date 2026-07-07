// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only
// Qt-Security score:significant reason:default

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Controls.Basic.impl
import QtQuick.Templates as T

T.ComboBox {
    id: control

    readonly property url dirComboboxAssets: Qt.resolvedUrl("assets/items/combobox/")
    readonly property url dirEditableAssets: Qt.resolvedUrl("assets/items/textedit/")

    readonly property string imgEditableBackground: "background.png"
    readonly property string imgEditableBackgroundFocused: "background_focused.png"
    readonly property string imgEditableBackgroundHot: "background_hot.png"
    readonly property string imgEditableBackgroundDisabled: "background_disabled.png"

    readonly property string imgArrow: "arrow.png"
    readonly property string imgArrowDisabled: "arrow_disabled.png"

    readonly property string imgArrowBackground: "arrow_background.png"
    readonly property string imgArrowBackgroundPressed: "arrow_background_pressed.png"
    readonly property string imgArrowBackgroundHot: "arrow_background_hot.png"
    readonly property string imgArrowBackgroundDisabled: "arrow_background_disabled.png"

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    rightPadding: padding + comboIndicator.width

    delegate: ItemDelegate {
        required property var model
        required property int index

        width: ListView.view.width
        text: model[control.textRole]
        palette.text: control.palette.text
        palette.highlightedText: control.palette.highlightedText
        font.weight: control.currentIndex === index ? Font.DemiBold : Font.Normal
        highlighted: control.highlightedIndex === index
        hoverEnabled: control.hoverEnabled
    }

    indicator: BorderImage {
        id: comboIndicator
        width: 17
        height: control.height

        anchors.right: parent.right
        border.left: 2
        border.right: 2
        border.top: 2
        border.bottom: 2
        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Stretch

        source: {
            if (!control.enabled) return dirComboboxAssets + imgArrowBackgroundDisabled
            if (control.focused) return dirComboboxAssets + imgArrowBackgroundHot
            if (control.down) return dirComboboxAssets + imgArrowBackgroundPressed
            if (control.hovered) return dirComboboxAssets + imgArrowBackgroundHot

//            return dirComboboxAssets +
            return ""
        }

        Image {
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: -1
            source: control.enabled ? dirComboboxAssets + imgArrow : dirComboboxAssets + imgArrowDisabled
        }
    }

    contentItem: T.TextField {
        id: textField

        enabled: control.editable

        padding: 6
        topPadding: padding + 1
        bottomPadding: padding - 1

        verticalAlignment: TextInput.AlignVCenter

        font.pointSize: 9
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
        source: {
            if (!control.enabled) {
                return dirEditableAssets + imgEditableBackgroundDisabled
            }
            if (control.focused) {
                return dirEditableAssets + imgEditableBackgroundFocused
            }
            if (control.hovered) {
                return dirEditableAssets + imgEditableBackgroundHot
            }
            return dirEditableAssets + imgEditableBackground
        }
    }

     popup: T.Popup {
        y: control.height
        width: control.width
        height: Math.min(contentItem.implicitHeight, control.Window.height - topMargin - bottomMargin)
        topMargin: 6
        bottomMargin: 6
        font: control.font
        palette: control.palette

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.delegateModel
            currentIndex: control.highlightedIndex
            highlightMoveDuration: 0

            Rectangle {
                z: 10
                width: parent.width
                height: parent.height
                color: "transparent"
                border.color: control.palette.mid
            }

            // Show a contour around the highlighted item in high contrast mode
            Rectangle {
                property Item highlightedItem: parent ? parent.itemAtIndex(control.highlightedIndex) : null
                visible: Qt.styleHints.accessibility.contrastPreference === Qt.HighContrast && highlightedItem
                z: 11
                x: highlightedItem ? highlightedItem.x : 0
                y: highlightedItem ? highlightedItem.y : 0
                width: highlightedItem ? highlightedItem.width : 0
                height: highlightedItem ? highlightedItem.height : 0
                color: "transparent"
                border.color: control.palette.dark
            }

            T.ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            color: control.palette.window
        }
    }
}