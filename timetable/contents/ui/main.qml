/********************************************************************
Copyright (C) 2016 R. Harish Navnit <harishnavnit@gmail.com>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*********************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.1

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras


Item {
    id: timetableApplet

    Layout.minimumWidth: 256
    Layout.minimumHeight: 256
    Layout.fillWidth: true
    Layout.fillHeight: true
    LayoutMirroring.enabled: Qt.application.layoutDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    property Item timetable: timetableLoader.item

    PlasmaExtras.Heading {
        id: appletHeader
        width: parent.width
        visible: true
        text: i18n("Stops list");
    }

    PlasmaExtras.ScrollArea {
        id: mainScrollArea
        anchors.top: appletHeader.bottom
        anchors.topMargin: 5

        height: parent.height
        width: parent.width

        Flickable {
            id: timetableView
            anchors.fill: parent

            contentHeight: contentsColumn.height

            Column {
                id: contentsColumn
                width: timetableView.width

                Loader {
                    id: timetableLoader
                    width: parent.width
                    source: "Timetable.qml"
                    active: true
                }
            }
        }
    }
}
