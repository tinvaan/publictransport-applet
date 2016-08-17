/***************************************************************************
 *   Copyright (C) 2016 by R. Harish Navnit <harishnavnit@gmail.com>       *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .        *
 ***************************************************************************/

import QtQuick 2.0

import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: serviceproviderCheckRoot

    width: parent.width
    height: parent.height
    anchors.fill: parent

    PlasmaCore.DataSource {
        id: mainDataSource

        interval: 6000
        engine: "publictransport"

        // At this point we don't know if service providers exist locally
        // Hence it's not possible to form and connect to a arrival/departure source
        connectedSources: ["ServiceProviders"]
    }

    Loader {
        id: gtfsImportLoader
        anchors.fill: parent
        source: "GtfsService.qml"
        active: {
            var data = mainDataSource.data
            return data.isEmpty()
        }
    }
}
