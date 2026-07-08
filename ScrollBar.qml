// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only
// Qt-Security score:significant reason:default

import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import "."

T.ScrollBar {
    id: control

    readonly property url imgButtonArrow: Theme.dirItemAssets + "scrollbar/arrowbtn.ico"
    readonly property url imgArrow: Theme.dirItemAssets + "scrollbar/arrowbtn_arrow.ico"
    readonly property url imgButtonThumb: Theme.dirItemAssets + "scrollbar/thumbbtn_vertical.ico"
    readonly property url imgGripper: Theme.dirItemAssets + "scrollbar/gripper_vertical.ico"
    readonly property url imgTrack: Theme.dirItemAssets + "scrollbar/track_vert.ico"

    enum ArrowStates {
        UpNormal, UpHot, UpPressed, UpDisabled,
        DownNormal, DownHot, DownPressed, DownDisabled,
        LeftNormal, LeftHot, LeftPressed, LeftDisabled,
        RightNormal, RightHot, RightPressed, RightDisabled,
        UpHover, DownHover, LeftHover, RightHover
    }

    enum BarStates {
        Normal, Hot, Pressed, Disabled, Hover
    }

    topPadding: lineUp.height
    bottomPadding: lineDown.height
    implicitWidth: 17

    // Auto stretch to the top and bottom
    anchors.top: parent ? parent.top : undefined
    anchors.bottom: parent ? parent.bottom : undefined

    visible: control.policy !== T.ScrollBar.AlwaysOff
    minimumSize: orientation === Qt.Horizontal ? height / width : width / height

    // TODO: Transfer 'sizing margins' to all images
    // TODO: Figure out what happens when size gets smaller
    // TODO: Add horizontal mode

    contentItem: Item {
        id: thumb
        height: Math.max(17, control.size * control.availableHeight)

        visible: control.interactive

        Image {
            id: thumbGripper

            z: 1

            anchors.centerIn: parent

            visible: parent.height >= 19

            fillMode: Image.Pad

            source: imgGripper
            currentFrame : {
                if (!control.enabled) return ScrollBar.BarStates.Disabled
                if (pressed) return ScrollBar.BarStates.Pressed
                if (hovered) return ScrollBar.BarStates.Hot
                return ScrollBar.BarStates.Normal
            }
        }

        BorderImage {
            id: thumbBackground

            z: 0

            anchors.fill: parent

            border.left: 8
            border.top: 5
            border.right: 8
            border.bottom: 5

            horizontalTileMode: BorderImage.Repeat
            verticalTileMode: BorderImage.Repeat

            source: imgButtonThumb
            currentFrame : {
                if (!control.enabled) return ScrollBar.BarStates.Disabled
                if (pressed) return ScrollBar.BarStates.Pressed
                if (hovered) return ScrollBar.BarStates.Hot
                return ScrollBar.BarStates.Normal
            }
        }
    }

    // Line Up Buttons
        T.Button {
            id: lineUp
            anchors { top: parent.top; left: parent.left; right: parent.right }
            height: lineUpBackground.implicitHeight

            onClicked: control.decrease()

            contentItem: Image {
                id: lineUpArrow

                // Fixes weird stretching
                fillMode: Image.Pad

                source: imgArrow
                currentFrame : {
                    if (!control.enabled || !control.interactive) return ScrollBar.ArrowStates.UpDisabled
                    if (lineUp.pressed) return ScrollBar.ArrowStates.UpPressed
                    if (lineUp.hovered) return ScrollBar.ArrowStates.UpHot
                    return ScrollBar.ArrowStates.UpNormal
                }
            }

            background: Image {
                id: lineUpBackground

                source: imgButtonArrow
                currentFrame : {
                    if (!control.enabled || !control.interactive) return ScrollBar.ArrowStates.UpDisabled
                    if (lineUp.pressed) return ScrollBar.ArrowStates.UpPressed
                    if (lineUp.hovered) return ScrollBar.ArrowStates.UpHot
                    return ScrollBar.ArrowStates.UpNormal
                }
            }
        }


        T.Button {
            id: lineDown
            anchors { bottom: parent.bottom; left: parent.left; right: parent.right }
            height: lineUpBackground.implicitHeight

            onClicked: control.increase()

            contentItem: Image {
                id: lineDownArrow

                // Fixes weird stretching
                fillMode: Image.Pad

                source: imgArrow
                currentFrame : {
                    if (!control.enabled || !control.interactive) return ScrollBar.ArrowStates.DownDisabled
                    if (lineDown.pressed) return ScrollBar.ArrowStates.DownPressed
                    if (lineDown.hovered) return ScrollBar.ArrowStates.DownHot
                    return ScrollBar.ArrowStates.DownNormal
                }
            }

            background: Image {
                id: lineDownBackground

                source: imgButtonArrow
                currentFrame : {
                    if (!control.enabled || !control.interactive) return ScrollBar.ArrowStates.DownDisabled
                    if (lineDown.pressed) return ScrollBar.ArrowStates.DownPressed
                    if (lineDown.hovered) return ScrollBar.ArrowStates.DownHot
                    return ScrollBar.ArrowStates.DownNormal
                }
            }
        }

    background: Item {
        anchors.fill: parent

        // Tracks
        Image {
            id: upperTrack
            anchors {
                fill: parent
                topMargin: control.topPadding
                bottomMargin: control.contentItem.height
            }
            height: Math.max(0, control.contentItem.y - lineUp.height)

            source: imgTrack

            HoverHandler {
                id: upperTrackHover
            }

            currentFrame : {
                if (!control.enabled || !control.interactive) return ScrollBar.BarStates.Disabled
                // if (upperTrackTap.pressed) return ScrollBar.BarStates.Pressed
                if (upperTrackHover.hovered) return ScrollBar.BarStates.Hot
                if (lowerTrackHover.hovered) return ScrollBar.BarStates.Hover
                return ScrollBar.BarStates.Normal
            }
        }
        Image {
            id: lowerTrack
            anchors {
                fill: parent
                topMargin: control.contentItem.height + control.contentItem.y
                bottomMargin: control.bottomPadding
            }

            source: imgTrack

            HoverHandler {
                id: lowerTrackHover
            }



            currentFrame : {
                if (!control.enabled || !control.interactive) return ScrollBar.BarStates.Disabled
                // if (lowerTrackTap.pressed) return ScrollBar.BarStates.Pressed
                if (lowerTrackHover.hovered) return ScrollBar.BarStates.Hot
                if (upperTrackHover.hovered) return ScrollBar.BarStates.Hover
                return ScrollBar.BarStates.Normal
            }
        }
    }
}