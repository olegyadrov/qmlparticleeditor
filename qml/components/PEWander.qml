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
    id: peWander

    frameColor: "#ff0000"

    property string type: "Wander"
    property bool isAffector: true
    property int uniqueID: ObjectManager.getNewAffectorID()

    Wander {
        id: wander
        anchors.fill: parent
        system: ObjectManager.getDefaultSystem()

        Component.onCompleted: {
            shape = scene.rectangleShapeComponent.createObject(wander)
        }

        function getListProperty(propertyName) {
            var listPropertyValues = []

            for (var key in wander[propertyName])
                listPropertyValues.push(wander[propertyName][key])

            return listPropertyValues
        }

        function getAffectedParameter() {
            var affectedParameterString = ""

            switch (affectedParameter) {
            case Wander.Position:
                affectedParameterString = "Wander.Position"
                break
            case Wander.Velocity:
                affectedParameterString = "Wander.Velocity"
                break
            case Wander.Acceleration:
                affectedParameterString = "Wander.Acceleration"
                break
            }

            return affectedParameterString
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

                    text: peWander.type
                    enabled: false
                }

                PropertyNameLabel {
                    text: "Object name"
                }
                TextField {
                    Layout.fillWidth: true

                    maximumLength: 50

                    text: peWander.objectName
                    onTextChanged:
                        peWander.objectName = text
                }

                PropertyNameLabel {
                    text: "Width"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 1
                    maximumValue: consts.maxInt

                    value: peWander.width
                    onValueChanged:
                        peWander.width = value
                }

                PropertyNameLabel {
                    text: "Height"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 1
                    maximumValue: consts.maxInt

                    value: peWander.height
                    onValueChanged:
                        peWander.height = value
                }

                PropertyNameLabel {
                    text: "Enabled"
                }
                CheckBox {
                    Layout.fillWidth: true

                    checked: wander.enabled
                    onCheckedChanged:
                        wander.enabled = checked
                }

                PropertyNameLabel {
                    text: "Groups"
                }
                TextField {
                    Layout.fillWidth: true

                    text: wander.groups.join(",")
                    onTextChanged: {
                        // here [] !== [""], what is ~right~ for emitter's property "group" which equals to an empty string ("") by default
                        if (text === "")
                            wander.groups = []
                        else
                            wander.groups = text.split(",")
                    }
                }

                PropertyNameLabel {
                    text: "When colliding with"
                }
                TextField {
                    Layout.fillWidth: true

                    text: wander.whenCollidingWith.join(",")
                    onTextChanged:
                        wander.whenCollidingWith = text.split(",")
                }

                PropertyNameLabel {
                    text: "Once"
                }
                CheckBox {
                    Layout.fillWidth: true

                    checked: wander.once
                    onCheckedChanged:
                        wander.once = checked
                }

                PropertyNameLabel {
                    text: "Affected parameter"
                }
                ComboBox {
                    Layout.fillWidth: true
                    model: ["Position", "Velocity", "Acceleration"]
                    currentIndex:
                        switch (wander.affectedParameter) {
                        case Wander.Position:
                            0; break
                        case Wander.Velocity:
                            1; break
                        case Wander.Acceleration:
                            2; break
                        }

                    onActivated: {
                        switch (index) {
                        case 0:
                            wander.affectedParameter = Wander.Position
                            break
                        case 1:
                            wander.affectedParameter = Wander.Velocity
                            break
                        case 2:
                            wander.affectedParameter = Wander.Acceleration
                            break
                        }
                    }
                }

                PropertyNameLabel {
                    text: "Pace"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 0
                    maximumValue: consts.maxInt
                    decimals: 2

                    value: wander.pace
                    onValueChanged:
                        wander.pace = value
                }

                PropertyNameLabel {
                    text: "X variance"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 0
                    maximumValue: consts.maxInt
                    decimals: 2

                    value: wander.xVariance
                    onValueChanged:
                        wander.xVariance = value
                }

                PropertyNameLabel {
                    text: "Y variance"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 0
                    maximumValue: consts.maxInt
                    decimals: 2

                    value: wander.yVariance
                    onValueChanged:
                        wander.yVariance = value
                }

                PropertyNameLabel {
                    text: "Shape"
                }
                ComboBox {
                    Layout.fillWidth: true
                    model: ["Ellipse", "Line", "Mask", "Rectangle"]
                    currentIndex:
                        switch (wander.shape.type) {
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
                        var oldShape = wander.shape

                        switch (index) {
                        case 0:
                            wander.shape = scene.ellipseShapeComponent.createObject(wander)
                            break
                        case 1:
                            wander.shape = scene.lineShapeComponent.createObject(wander)
                            break
                        case 2:
                            wander.shape = scene.maskShapeComponent.createObject(wander)
                            break
                        case 3:
                            wander.shape = scene.rectangleShapeComponent.createObject(wander)
                            break
                        }

                        oldShape.destroy()
                    }
                }

                PropertyNameLabel {
                    visible: wander.shape.type === "EllipseShape"
                    text: "Fill"
                }
                CheckBox {
                    visible: wander.shape.type === "EllipseShape"
                    Layout.fillWidth: true

                    Component.onCompleted: {
                        if (visible)
                            checked = wander.shape.fill
                    }
                    onVisibleChanged: {
                        if (visible)
                            checked = wander.shape.fill
                    }
                    onCheckedChanged:
                        wander.shape.fill = checked
                }

                PropertyNameLabel {
                    visible: wander.shape.type === "LineShape"
                    text: "Mirrored"
                }
                CheckBox {
                    visible: wander.shape.type === "LineShape"
                    Layout.fillWidth: true

                    Component.onCompleted: {
                        if (visible)
                            checked = wander.shape.mirrored
                    }
                    onVisibleChanged: {
                        if (visible)
                            checked = wander.shape.mirrored
                    }
                    onCheckedChanged:
                        wander.shape.mirrored = checked
                }

                PropertyNameLabel {
                    visible: wander.shape.type === "MaskShape"
                    text: "Source"
                }
                ImageSelector {
                    visible: wander.shape.type === "MaskShape"
                    Layout.fillWidth: true

                    Component.onCompleted: {
                        if (visible)
                            path = wander.shape.source
                    }
                    onVisibleChanged: {
                        if (visible)
                            path = wander.shape.source
                    }
                    onPathChanged:
                        wander.shape.source = path
                }

                Item {
                    Layout.fillHeight: true
                }
            }
        }

    function toQML() {
        var genericProperties = ["objectName", "x", "y", "width", "height"]
        var properties = ["enabled", "groups", "whenCollidingWith", "once", "affectedParameter", "pace", "xVariance", "yVariance", "system"]
        var objectProperties = ["shape"]

        var data = "    " + peWander.type + " {"

        for (var i = 0; i < genericProperties.length; i++)
            data += "\n        %1: %2".arg(genericProperties[i]).arg(JSON.stringify(peWander[genericProperties[i]]))

        for (i = 0; i < properties.length; i++) {
            if (properties[i] === "system")
                data += "\n        %1: %2".arg(properties[i]).arg(wander.system.objectName)
            else if (properties[i] === "groups" || properties[i] === "whenCollidingWith")
                data += "\n        %1: %2".arg(properties[i]).arg(JSON.stringify(wander.getListProperty(properties[i])))
            else if (properties[i] === "affectedParameter")
                data += "\n        %1: %2".arg(properties[i]).arg(wander.getAffectedParameter())
            else if (properties[i] === "proportionalToDistance")
                data += "\n        %1: %2".arg(properties[i]).arg(wander.getProportionalToDistance())
            else
                data += "\n        %1: %2".arg(properties[i]).arg(JSON.stringify(wander[properties[i]]))
        }

        for (i = 0; i < objectProperties.length; i++) {
            data += "\n        %1:\n%2".arg(objectProperties[i]).arg(wander[objectProperties[i]].toQML())
        }

        data += "\n    }"

        return data
    }
}
