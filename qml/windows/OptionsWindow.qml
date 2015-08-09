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
import "../controls"

Window {
    title: "Options"
    width: 360
    height: 500
    minimumWidth: 360
    minimumHeight: 500
    modality: Qt.ApplicationModal
    color: systemPalette.window

    GridLayout {
        anchors.fill: parent
        anchors.margins: columnSpacing
        columns: 2

        PropertyNameLabel {
            text: "Emitter color"
        }
        ColorSelector {
            Layout.fillWidth: true

            color: settings.emitterColor
            onColorChanged:
                settings.emitterColor = color
        }

        PropertyNameLabel {
            text: "Age color"
        }
        ColorSelector {
            Layout.fillWidth: true

            color: settings.ageColor
            onColorChanged:
                settings.ageColor = color
        }

        PropertyNameLabel {
            text: "Attractor color"
        }
        ColorSelector {
            Layout.fillWidth: true

            color: settings.attractorColor
            onColorChanged:
                settings.attractorColor = color
        }

        PropertyNameLabel {
            text: "Friction color"
        }
        ColorSelector {
            Layout.fillWidth: true

            color: settings.frictionColor
            onColorChanged:
                settings.frictionColor = color
        }

        PropertyNameLabel {
            text: "Gravity color"
        }
        ColorSelector {
            Layout.fillWidth: true

            color: settings.gravityColor
            onColorChanged:
                settings.gravityColor = color
        }

        PropertyNameLabel {
            text: "Turbulence color"
        }
        ColorSelector {
            Layout.fillWidth: true

            color: settings.turbulenceColor
            onColorChanged:
                settings.turbulenceColor = color
        }

        PropertyNameLabel {
            text: "Wander color"
        }
        ColorSelector {
            Layout.fillWidth: true

            color: settings.wanderColor
            onColorChanged:
                settings.wanderColor = color
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
