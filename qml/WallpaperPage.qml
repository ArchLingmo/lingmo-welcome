/*
 * Copyright (C) 2026 LingmoOS Team.
 *
 * Author:     devalexandre <alexandre@dev2learn.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import LingmoUI.CompatibleModule 3.0 as LingmoUI

StepPage {
    id: page

    title: qsTr("Wallpaper")
    subtitle: qsTr("Click a picture to put it on your desktop. More in Settings → Background.")

    Item {
        id: area
        Layout.fillWidth: true
        implicitHeight: grid.height

    Grid {
        id: grid
        width: area.width
        columns: 4
        spacing: LingmoUI.Units.largeSpacing * 1.5

        readonly property real cellWidth: (area.width - spacing * (columns - 1)) / columns

        Repeater {
            model: welcome.wallpapers

            delegate: Item {
                id: thumb
                readonly property bool checked: welcome.wallpaper === modelData

                width: grid.cellWidth
                height: grid.cellWidth * 10 / 16

                Rectangle {
                    anchors.fill: parent
                    radius: LingmoUI.Theme.bigRadius + 4
                    color: "transparent"
                    border.width: 3
                    border.color: thumb.checked ? LingmoUI.Theme.highlightColor
                                                : mouse.containsMouse ? Qt.rgba(LingmoUI.Theme.highlightColor.r,
                                                                                LingmoUI.Theme.highlightColor.g,
                                                                                LingmoUI.Theme.highlightColor.b, 0.4)
                                                                      : "transparent"
                    Behavior on border.color { ColorAnimation { duration: LingmoUI.Units.shortDuration } }
                }

                RoundedImage {
                    anchors.fill: parent
                    anchors.margins: 6
                    radius: LingmoUI.Theme.bigRadius
                    source: "file://" + modelData
                    decodeSize: Qt.size(400, 250)
                    scale: mouse.pressed ? 0.97 : mouse.containsMouse ? 1.02 : 1
                    Behavior on scale { NumberAnimation { duration: LingmoUI.Units.shortDuration; easing.type: LingmoUI.Units.easing } }
                }

                // Check badge
                Rectangle {
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: 14
                    width: 22
                    height: 22
                    radius: 11
                    color: LingmoUI.Theme.highlightColor
                    border.width: 2
                    border.color: LingmoUI.Theme.highlightedTextColor
                    scale: thumb.checked ? 1 : 0
                    Behavior on scale { NumberAnimation { duration: LingmoUI.Units.shortDuration; easing.type: Easing.OutBack } }

                    Canvas {
                        anchors.fill: parent
                        onPaint: {
                            const ctx = getContext("2d")
                            ctx.reset()
                            ctx.strokeStyle = String(LingmoUI.Theme.highlightedTextColor)
                            ctx.lineWidth = 2
                            ctx.lineCap = "round"
                            ctx.lineJoin = "round"
                            ctx.beginPath()
                            ctx.moveTo(width * 0.30, height * 0.52)
                            ctx.lineTo(width * 0.45, height * 0.66)
                            ctx.lineTo(width * 0.71, height * 0.36)
                            ctx.stroke()
                        }
                    }
                }

                MouseArea {
                    id: mouse
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: welcome.setWallpaper(modelData)
                }
            }
        }
    }

    }

    LingmoUI.EmptyState {
        Layout.fillWidth: true
        Layout.topMargin: LingmoUI.Units.largeSpacing * 2
        visible: welcome.wallpapers.length === 0
        iconName: "preferences-desktop-wallpaper"
        text: qsTr("No wallpapers were found.")
    }

    Item { Layout.fillHeight: true }
}
