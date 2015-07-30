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
import QtQuick.Particles 2.0
import Qt.labs.settings 1.0
import "scripts/ObjectManager.js" as ObjectManager
import "controls"
import "windows"

ApplicationWindow {
    title: "QML Particle Editor"
    width: 800
    height: 600
    minimumWidth: 800
    minimumHeight: 600
    visible: true

    menuBar: MenuBar {
        Menu {
            title: "File"

            MenuItem {
                text: "Options..."
                onTriggered: optionsWindow.show()
            }

            MenuItem {
                text: "Export QML code"
                onTriggered: exportWindow.show()
            }
        }

        Menu {
            title: "Particles"

            MenuItem {
                text: "New emitter"
                onTriggered: sceneArea.scene.createObject("Emitter", { "scene" : sceneArea.scene })
            }

            Menu {
                title: "New affector"
                MenuItem { text: "Age"; onTriggered: sceneArea.scene.createObject("Age", { "scene" : sceneArea.scene }) }
                MenuItem { text: "Attractor"; onTriggered: sceneArea.scene.createObject("Attractor", { "scene" : sceneArea.scene }) }
                MenuItem { text: "Friction"; onTriggered: sceneArea.scene.createObject("Friction", { "scene" : sceneArea.scene }) }
                MenuItem { text: "Gravity"; onTriggered: sceneArea.scene.createObject("Gravity", { "scene" : sceneArea.scene }) }
                MenuItem { text: "Turbulence"; onTriggered: sceneArea.scene.createObject("Turbulence", { "scene" : sceneArea.scene }) }
                MenuItem { text: "Wander"; onTriggered: sceneArea.scene.createObject("Wander", { "scene" : sceneArea.scene }) }
            }

            MenuSeparator { }

            MenuItem {
                text: "Delete selected item"
                shortcut: "Del"
                onTriggered: sceneArea.scene.deleteSelectedItem()
            }

            MenuSeparator {}

            MenuItem {
                text: "Manage particles"
                onTriggered: particlesWindow.show()
            }
        }

        Menu {
            title: "Help"

            MenuItem {
                text: "About"
                onTriggered: aboutWindow.show()
            }
        }
    }

    SplitView {
        anchors.fill: parent

        SceneArea {
            id: sceneArea

            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        SettingsPanel {
            id: settingsPanel

            implicitWidth: 250

            Layout.minimumWidth: 200
            Layout.maximumWidth: 500

            Layout.fillHeight: true

            settingsComponent: sceneArea.settingsComponent
        }
    }

    QtObject {
        id: consts

        // http://doc.qt.io/qt-5/qml-int.html
        readonly property int maxInt: 2000000000
        readonly property int minInt: -2000000000
    }

    SystemPalette {
        id: systemPalette
    }

    FontLoader {
        source: "../resources/fonts/liberationmono.ttf"
    }

    QtObject {
        id: settings
        property color emitterColor:    "#0000ff"
        property color ageColor:        "#ff0000"
        property color attractorColor:  "#ff0000"
        property color frictionColor:   "#ff0000"
        property color gravityColor:    "#ff0000"
        property color turbulenceColor: "#ff0000"
        property color wanderColor:     "#ff0000"
    }

    Settings {
        property alias emitterColor: settings.emitterColor
        property alias ageColor: settings.ageColor
        property alias attractorColor: settings.attractorColor
        property alias frictionColor: settings.frictionColor
        property alias gravityColor: settings.gravityColor
        property alias turbulenceColor: settings.turbulenceColor
        property alias wanderColor: settings.wanderColor
    }

    OptionsWindow {
        id: optionsWindow
    }

    ExportWindow {
        id: exportWindow
    }

    ParticlesWindow {
        id: particlesWindow
    }

    AboutWindow {
        id: aboutWindow
    }
}
