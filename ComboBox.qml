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

    readonly property string imgArrowBackgroundRightPressed: "arrow_background_right_pressed.png"
    readonly property string imgArrowBackgroundRightHot: "arrow_background_right_hot.png"

    readonly property string imgListVerticalBackground: "list_vertical_background.png"
    readonly property string imgListVerticalBackgroundDisabled: "list_vertical_background_disabled.png"
    readonly property string imgListVerticalBackgroundFocused: "list_vertical_background_focused.png"
    readonly property string imgListVerticalBackgroundHot: "list_vertical_background_hot.png"

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    rightPadding: padding + comboIndicator.width

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
            color: highlighted ? control.palette.highlight : "transparent"
        }
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
            if (control.down) return dirComboboxAssets + imgArrowBackgroundRightPressed
            if (indicatorMouseArea.containsMouse) return dirComboboxAssets + imgArrowBackgroundRightHot

            return ""
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
            source: control.enabled ? dirComboboxAssets + imgArrow : dirComboboxAssets + imgArrowDisabled
        }
    }

    contentItem: T.TextField {
        id: textField

        enabled: control.editable

        padding: 6
        // topPadding: padding + 1
        bottomPadding: padding - 1

        verticalAlignment: TextInput.AlignVCenter

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

        background: BorderImage {
            anchors.fill: parent

            border.left: 1
            border.right: 1
            border.top: 1
            border.bottom: 1

            horizontalTileMode: BorderImage.Repeat
            verticalTileMode: BorderImage.Repeat

            // Swap the image asset depending on whether the button is hovered or pressed
            source: {
                if (!control.enabled) {
                    return dirComboboxAssets + imgListVerticalBackgroundDisabled
                }
                if (control.focused) {
                    return dirComboboxAssets + imgListVerticalBackgroundFocused
                }
                if (control.hovered) {
                    return dirComboboxAssets + imgListVerticalBackgroundHot
                }
                return dirComboboxAssets + imgListVerticalBackground
            }
        }
    }
}