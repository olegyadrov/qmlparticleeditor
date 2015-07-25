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
import QtQuick.Window 2.2

Window {
    title: "About"
    width: 320
    height: 240
    minimumWidth: 320
    minimumHeight: 240
    modality: Qt.ApplicationModal
    color: systemPalette.window

    ScrollView {
        anchors.fill: parent
    }

    TextEdit {
        id: textEdit
        anchors.fill: parent
        anchors.margins: 10
        renderType: Text.NativeRendering
        textFormat: TextEdit.RichText
        wrapMode: TextEdit.Wrap
        readOnly: true
        selectByMouse: false
        onLinkActivated: Qt.openUrlExternally(link)
        text: "<b>" + Qt.application.name + " " + Qt.application.version + "</b><br><br>

               Copyright (C) 2013-2015 <a href=\"https://linkedin.com/in/olegyadrov/\">Oleg Yadrov</a><br><br>

               QML Particle Editor application is distributed under
               <a href=\"http://www.apache.org/licenses/LICENSE-2.0\">Apache Software License, Version 2</a>.<br><br>

               Unless required by applicable law or agreed to in writing, software distributed under the License
               is distributed on an \"AS IS\" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied."

        MouseArea {
            anchors.fill: parent
            cursorShape: textEdit.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
            acceptedButtons: Qt.NoButton
        }
    }
}
