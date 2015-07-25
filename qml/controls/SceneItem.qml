/****************************************************************************
**
** Copyright (C) 2013-2015 Oleg Yadrov
**
** Licensed under the Apache License, Version 2.0 (the "License");
** you may not use this file except in compliance with the License.
** You may obtain a copy of the License at
**
** http://www.apache.org/licenses/LICENSE-2.0
**
** Unless required by applicable law or agreed to in writing, software
** distributed under the License is distributed on an "AS IS" BASIS,
** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
** See the License for the specific language governing permissions and
** limitations under the License.
**
****************************************************************************/

import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Item {
    id: sceneItem

    width: 100
    height: 100

    property color frameColor: "#000000"
    property Item scene

    Rectangle {
        anchors.fill: parent
        visible: true
        color: "#00000000"
        border.width: (scene.selectedItem === sceneItem) ? 3 : 1
        border.color: frameColor
    }

    MouseArea {
        anchors.fill: parent
        drag.target: sceneItem
        drag.minimumX: 0
        drag.maximumX: scene.width - width
        drag.minimumY: 0
        drag.maximumY: scene.height - height
        drag.threshold: 0.0
        onPressed: {
            scene.selectedItem = sceneItem
        }
    }
}
