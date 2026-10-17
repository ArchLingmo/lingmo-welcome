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

// First screen: the brand, one line of welcome and "Get started"
Item {
    id: page

    signal start()
    signal skip()

    ColumnLayout {
        anchors.fill: parent
        anchors.leftMargin: LingmoUI.Units.largeSpacing * 3
        anchors.rightMargin: LingmoUI.Units.largeSpacing * 3
        anchors.bottomMargin: LingmoUI.Units.largeSpacing * 2
        spacing: LingmoUI.Units.largeSpacing

        // Our wallpaper with the Lingmo logo on top
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: 180

            RoundedImage {
                id: banner
                anchors.fill: parent
                radius: LingmoUI.Theme.hugeRadius
                source: welcome.wallpapers.length > 0 ? "file://" + welcome.wallpapers[0] : ""
                decodeSize: Qt.size(1400, 0)
            }

            // Soft shade so the white logo reads on any wallpaper
            Rectangle {
                anchors.fill: parent
                radius: LingmoUI.Theme.hugeRadius
                gradient: Gradient {
                    GradientStop { position: 0.0; color: Qt.rgba(0, 0, 0, 0.05) }
                    GradientStop { position: 1.0; color: LingmoUI.Theme.overlayScrimColor }
                }
            }

            Image {
                id: logo
                anchors.centerIn: parent
                width: Math.min(parent.width * 0.55, 420)
                height: width * 652 / 2868
                sourceSize: Qt.size(width * 2, height * 2)
                source: welcome.logoWhite
                fillMode: Image.PreserveAspectFit
                smooth: true
                opacity: 0
                scale: 0.92

                Component.onCompleted: {
                    opacity = 1
                    scale = 1
                }
                Behavior on opacity { NumberAnimation { duration: 700; easing.type: Easing.OutCubic } }
                Behavior on scale { NumberAnimation { duration: 900; easing.type: Easing.OutBack } }
            }
        }

        Label {
            Layout.fillWidth: true
            Layout.topMargin: LingmoUI.Units.largeSpacing
            horizontalAlignment: Text.AlignHCenter
            text: qsTr("Welcome to ArchLingmo")
            font.pointSize: LingmoUI.Units.fontDisplay
            font.weight: Font.Bold
            wrapMode: Text.WordWrap
        }

        Label {
            Layout.fillWidth: true
            Layout.leftMargin: LingmoUI.Units.largeSpacing * 4
            Layout.rightMargin: LingmoUI.Units.largeSpacing * 4
            horizontalAlignment: Text.AlignHCenter
            text: qsTr("A few quick steps to make this desktop yours. You can change everything later in Settings.")
            color: LingmoUI.Theme.secondaryTextColor
            font.pointSize: LingmoUI.Units.fontBody
            wrapMode: Text.WordWrap
        }

        LingmoUI.ActionButton {
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: LingmoUI.Units.largeSpacing
            Layout.preferredWidth: Math.max(implicitWidth, 200)
            Layout.preferredHeight: LingmoUI.Units.controlHeight + 8
            primary: true
            font.pointSize: LingmoUI.Units.fontSubheading
            text: qsTr("Get started")
            focus: true
            onClicked: page.start()
            Keys.onReturnPressed: page.start()
        }
        LingmoUI.ActionButton {
            flat: true
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Skip for now")
            onClicked: page.skip()
        }
    }
}
