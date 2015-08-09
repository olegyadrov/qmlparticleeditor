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
    id: peAge

    frameColor: settings.ageColor

    property string type: "Age"
    property bool isAffector: true
    property int uniqueID: ObjectManager.getNewAffectorID()

    Age {
        id: age
        anchors.fill: parent
        system: ObjectManager.getDefaultSystem()

        Component.onCompleted: {
            shape = scene.rectangleShapeComponent.createObject(age)
        }

        function getListProperty(propertyName) {
            var listPropertyValues = []

            for (var key in age[propertyName])
                listPropertyValues.push(age[propertyName][key])

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

                    text: peAge.type
                    enabled: false
                }

                PropertyNameLabel {
                    text: "Object name"
                }
                TextField {
                    Layout.fillWidth: true

                    maximumLength: 50

                    text: peAge.objectName
                    onTextChanged:
                        peAge.objectName = text
                }

                PropertyNameLabel {
                    text: "Width"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 1
                    maximumValue: consts.maxInt

                    value: peAge.width
                    onValueChanged:
                        peAge.width = value
                }

                PropertyNameLabel {
                    text: "Height"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 1
                    maximumValue: consts.maxInt

                    value: peAge.height
                    onValueChanged:
                        peAge.height = value
                }

                PropertyNameLabel {
                    text: "Enabled"
                }
                CheckBox {
                    Layout.fillWidth: true

                    checked: age.enabled
                    onCheckedChanged:
                        age.enabled = checked
                }

                PropertyNameLabel {
                    text: "Groups"
                }
                TextField {
                    Layout.fillWidth: true

                    text: age.groups.join(",")
                    onTextChanged: {
                        // here [] !== [""], what is ~right~ for emitter's property "group" which equals to an empty string ("") by default
                        if (text === "")
                            age.groups = []
                        else
                            age.groups = text.split(",")
                    }
                }

                PropertyNameLabel {
                    text: "When colliding with"
                }
                TextField {
                    Layout.fillWidth: true

                    text: age.whenCollidingWith.join(",")
                    onTextChanged: {
                        // here [] !== [""], what is ~right~ for emitter's property "group" which equals to an empty string ("") by default
                        if (text === "")
                            age.whenCollidingWith = []
                        else
                            age.whenCollidingWith = text.split(",")
                    }
                }

                PropertyNameLabel {
                    text: "Once"
                }
                CheckBox {
                    Layout.fillWidth: true

                    checked: age.once
                    onCheckedChanged:
                        age.once = checked
                }

                PropertyNameLabel {
                    text: "Advanced position"
                }
                CheckBox {
                    Layout.fillWidth: true

                    checked: age.advancePosition
                    onCheckedChanged:
                        age.advancePosition = checked
                }

                PropertyNameLabel {
                    text: "Life left"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 0
                    maximumValue: consts.maxInt
                    stepSize: 1000

                    value: age.lifeLeft
                    onValueChanged:
                        age.lifeLeft = value
                }

                PropertyNameLabel {
                    text: "Shape"
                }
                ComboBox {
                    Layout.fillWidth: true
                    model: ["Ellipse", "Line", "Mask", "Rectangle"]
                    currentIndex:
                        switch (age.shape.type) {
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
                        var oldShape = age.shape

                        switch (index) {
                        case 0:
                            age.shape = scene.ellipseShapeComponent.createObject(age)
                            break
                        case 1:
                            age.shape = scene.lineShapeComponent.createObject(age)
                            break
                        case 2:
                            age.shape = scene.maskShapeComponent.createObject(age)
                            break
                        case 3:
                            age.shape = scene.rectangleShapeComponent.createObject(age)
                            break
                        }

                        oldShape.destroy()
                    }
                }

                PropertyNameLabel {
                    visible: age.shape.type === "EllipseShape"
                    text: "Fill"
                }
                CheckBox {
                    visible: age.shape.type === "EllipseShape"
                    Layout.fillWidth: true

                    Component.onCompleted: {
                        if (visible)
                            checked = age.shape.fill
                    }
                    onVisibleChanged: {
                        if (visible)
                            checked = age.shape.fill
                    }
                    onCheckedChanged:
                        age.shape.fill = checked
                }

                PropertyNameLabel {
                    visible: age.shape.type === "LineShape"
                    text: "Mirrored"
                }
                CheckBox {
                    visible: age.shape.type === "LineShape"
                    Layout.fillWidth: true

                    Component.onCompleted: {
                        if (visible)
                            checked = age.shape.mirrored
                    }
                    onVisibleChanged: {
                        if (visible)
                            checked = age.shape.mirrored
                    }
                    onCheckedChanged:
                        age.shape.mirrored = checked
                }

                PropertyNameLabel {
                    visible: age.shape.type === "MaskShape"
                    text: "Source"
                }
                ImageSelector {
                    visible: age.shape.type === "MaskShape"
                    Layout.fillWidth: true

                    Component.onCompleted: {
                        if (visible)
                            path = age.shape.source
                    }
                    onVisibleChanged: {
                        if (visible)
                            path = age.shape.source
                    }
                    onPathChanged:
                        age.shape.source = path
                }

                Item {
                    Layout.fillHeight: true
                }
            }
        }

    function toQML() {
        var genericProperties = ["objectName", "x", "y", "width", "height"]
        var properties = ["enabled", "groups", "whenCollidingWith", "once", "advancePosition", "lifeLeft", "system"]
        var objectProperties = ["shape"]

        var data = "    " + peAge.type + " {"

        for (var i = 0; i < genericProperties.length; i++)
            data += "\n        %1: %2".arg(genericProperties[i]).arg(JSON.stringify(peAge[genericProperties[i]]))

        for (i = 0; i < properties.length; i++) {
            if (properties[i] === "system")
                data += "\n        %1: %2".arg(properties[i]).arg(age.system.objectName)
            else if (properties[i] === "groups" || properties[i] === "whenCollidingWith")
                data += "\n        %1: %2".arg(properties[i]).arg(JSON.stringify(age.getListProperty(properties[i])))
            else
                data += "\n        %1: %2".arg(properties[i]).arg(JSON.stringify(age[properties[i]]))
        }

        for (i = 0; i < objectProperties.length; i++) {
            data += "\n        %1:\n%2".arg(objectProperties[i]).arg(age[objectProperties[i]].toQML())
        }

        data += "\n    }"

        return data
    }
}
