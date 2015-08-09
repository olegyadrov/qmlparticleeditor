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
import QtQuick.Particles 2.0
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import "../scripts/ObjectManager.js" as ObjectManager
import "../controls"

SceneItem {
    id: peFriction

    frameColor: settings.frictionColor

    property string type: "Friction"
    property bool isAffector: true
    property int uniqueID: ObjectManager.getNewAffectorID()

    Friction {
        id: friction
        anchors.fill: parent
        system: ObjectManager.getDefaultSystem()

        Component.onCompleted: {
            shape = scene.rectangleShapeComponent.createObject(friction)
        }

        function getListProperty(propertyName) {
            var listPropertyValues = []

            for (var key in friction[propertyName])
                listPropertyValues.push(friction[propertyName][key])

            return listPropertyValues
        }
    }

    property Component settingsComponent:
        Component {
            GridLayout {
                columns: 2

                PropertyNameLabel {
                    text: "Type"
                }
                TextField {
                    Layout.fillWidth: true

                    text: peFriction.type
                    enabled: false
                }

                PropertyNameLabel {
                    text: "Object name"
                }
                TextField {
                    Layout.fillWidth: true

                    maximumLength: 50

                    text: peFriction.objectName
                    onTextChanged:
                        peFriction.objectName = text
                }

                PropertyNameLabel {
                    text: "Width"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 1
                    maximumValue: consts.maxInt

                    value: peFriction.width
                    onValueChanged:
                        peFriction.width = value
                }

                PropertyNameLabel {
                    text: "Height"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 1
                    maximumValue: consts.maxInt

                    value: peFriction.height
                    onValueChanged:
                        peFriction.height = value
                }

                PropertyNameLabel {
                    text: "Enabled"
                }
                CheckBox {
                    Layout.fillWidth: true

                    checked: friction.enabled
                    onCheckedChanged:
                        friction.enabled = checked
                }

                PropertyNameLabel {
                    text: "Groups"
                }
                TextField {
                    Layout.fillWidth: true

                    text: friction.groups.join(",")
                    onTextChanged: {
                        // here [] !== [""], what is ~right~ for emitter's property "group" which equals to an empty string ("") by default
                        if (text === "")
                            friction.groups = []
                        else
                            friction.groups = text.split(",")
                    }
                }

                PropertyNameLabel {
                    text: "When colliding with"
                }
                TextField {
                    Layout.fillWidth: true

                    text: friction.whenCollidingWith.join(",")
                    onTextChanged:
                        friction.whenCollidingWith = text.split(",")
                }

                PropertyNameLabel {
                    text: "Once"
                }
                CheckBox {
                    Layout.fillWidth: true

                    checked: friction.once
                    onCheckedChanged:
                        friction.once = checked
                }

                PropertyNameLabel {
                    text: "Factor"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 0
                    maximumValue: consts.maxInt
                    decimals: 2

                    value: friction.factor
                    onValueChanged:
                        friction.factor = value
                }

                PropertyNameLabel {
                    text: "Threshold"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 0
                    maximumValue: consts.maxInt
                    decimals: 2

                    value: friction.threshold
                    onValueChanged:
                        friction.threshold = value
                }

                PropertyNameLabel {
                    text: "Shape"
                }
                ComboBox {
                    Layout.fillWidth: true
                    model: ["Ellipse", "Line", "Mask", "Rectangle"]
                    currentIndex:
                        switch (friction.shape.type) {
                        case "EllipseShape":
                            0; break
                        case "LineShape":
                            1; break
                        case "MaskShape":
                            2; break
                        case "RectangleShape":
                            3; break
                        }

                    onActivated: {
                        var oldShape = friction.shape

                        switch (index) {
                        case 0:
                            friction.shape = scene.ellipseShapeComponent.createObject(friction)
                            break
                        case 1:
                            friction.shape = scene.lineShapeComponent.createObject(friction)
                            break
                        case 2:
                            friction.shape = scene.maskShapeComponent.createObject(friction)
                            break
                        case 3:
                            friction.shape = scene.rectangleShapeComponent.createObject(friction)
                            break
                        }

                        oldShape.destroy()
                    }
                }

                PropertyNameLabel {
                    visible: friction.shape.type === "EllipseShape"
                    text: "Fill"
                }
                CheckBox {
                    visible: friction.shape.type === "EllipseShape"
                    Layout.fillWidth: true

                    Component.onCompleted: {
                        if (visible)
                            checked = friction.shape.fill
                    }
                    onVisibleChanged: {
                        if (visible)
                            checked = friction.shape.fill
                    }
                    onCheckedChanged:
                        friction.shape.fill = checked
                }

                PropertyNameLabel {
                    visible: friction.shape.type === "LineShape"
                    text: "Mirrored"
                }
                CheckBox {
                    visible: friction.shape.type === "LineShape"
                    Layout.fillWidth: true

                    Component.onCompleted: {
                        if (visible)
                            checked = friction.shape.mirrored
                    }
                    onVisibleChanged: {
                        if (visible)
                            checked = friction.shape.mirrored
                    }
                    onCheckedChanged:
                        friction.shape.mirrored = checked
                }

                PropertyNameLabel {
                    visible: friction.shape.type === "MaskShape"
                    text: "Source"
                }
                ImageSelector {
                    visible: friction.shape.type === "MaskShape"
                    Layout.fillWidth: true

                    Component.onCompleted: {
                        if (visible)
                            path = friction.shape.source
                    }
                    onVisibleChanged: {
                        if (visible)
                            path = friction.shape.source
                    }
                    onPathChanged:
                        friction.shape.source = path
                }

                Item {
                    Layout.fillHeight: true
                }
            }
        }

    function toQML() {
        var genericProperties = ["objectName", "x", "y", "width", "height"]
        var properties = ["enabled", "groups", "whenCollidingWith", "once", "factor", "threshold", "system"]
        var objectProperties = ["shape"]

        var data = "    " + peFriction.type + " {"

        for (var i = 0; i < genericProperties.length; i++)
            data += "\n        %1: %2".arg(genericProperties[i]).arg(JSON.stringify(peFriction[genericProperties[i]]))

        for (i = 0; i < properties.length; i++) {
            if (properties[i] === "system")
                data += "\n        %1: %2".arg(properties[i]).arg(friction.system.objectName)
            else if (properties[i] === "groups" || properties[i] === "whenCollidingWith")
                data += "\n        %1: %2".arg(properties[i]).arg(JSON.stringify(friction.getListProperty(properties[i])))
            else
                data += "\n        %1: %2".arg(properties[i]).arg(JSON.stringify(friction[properties[i]]))
        }

        for (i = 0; i < objectProperties.length; i++) {
            data += "\n        %1:\n%2".arg(objectProperties[i]).arg(friction[objectProperties[i]].toQML())
        }

        data += "\n    }"

        return data
    }
}
