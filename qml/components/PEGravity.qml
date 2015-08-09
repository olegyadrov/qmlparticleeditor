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
    id: peGravity

    frameColor: settings.gravityColor

    property string type: "Gravity"
    property bool isAffector: true
    property int uniqueID: ObjectManager.getNewAffectorID()

    Gravity {
        id: gravity
        anchors.fill: parent
        system: ObjectManager.getDefaultSystem()

        Component.onCompleted: {
            shape = scene.rectangleShapeComponent.createObject(gravity)
        }

        function getListProperty(propertyName) {
            var listPropertyValues = []

            for (var key in gravity[propertyName])
                listPropertyValues.push(gravity[propertyName][key])

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

                    text: peGravity.type
                    enabled: false
                }

                PropertyNameLabel {
                    text: "Object name"
                }
                TextField {
                    Layout.fillWidth: true

                    maximumLength: 50

                    text: peGravity.objectName
                    onTextChanged:
                        peGravity.objectName = text
                }

                PropertyNameLabel {
                    text: "Width"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 1
                    maximumValue: consts.maxInt

                    value: peGravity.width
                    onValueChanged:
                        peGravity.width = value
                }

                PropertyNameLabel {
                    text: "Height"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: 1
                    maximumValue: consts.maxInt

                    value: peGravity.height
                    onValueChanged:
                        peGravity.height = value
                }

                PropertyNameLabel {
                    text: "Enabled"
                }
                CheckBox {
                    Layout.fillWidth: true

                    checked: gravity.enabled
                    onCheckedChanged:
                        gravity.enabled = checked
                }

                PropertyNameLabel {
                    text: "Groups"
                }
                TextField {
                    Layout.fillWidth: true

                    text: gravity.groups.join(",")
                    onTextChanged: {
                        // here [] !== [""], what is ~right~ for emitter's property "group" which equals to an empty string ("") by default
                        if (text === "")
                            gravity.groups = []
                        else
                            gravity.groups = text.split(",")
                    }
                }

                PropertyNameLabel {
                    text: "When colliding with"
                }
                TextField {
                    Layout.fillWidth: true

                    text: gravity.whenCollidingWith.join(",")
                    onTextChanged:
                        gravity.whenCollidingWith = text.split(",")
                }

                PropertyNameLabel {
                    text: "Once"
                }
                CheckBox {
                    Layout.fillWidth: true

                    checked: gravity.once
                    onCheckedChanged:
                        gravity.once = checked
                }

                PropertyNameLabel {
                    text: "Angle"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt
                    decimals: 2

                    value: gravity.angle
                    onValueChanged:
                        gravity.angle = value
                }

                PropertyNameLabel {
                    text: "Magnitude"
                }
                SpinBox {
                    Layout.fillWidth: true

                    minimumValue: consts.minInt
                    maximumValue: consts.maxInt
                    decimals: 2

                    value: gravity.magnitude
                    onValueChanged:
                        gravity.magnitude = value
                }

                PropertyNameLabel {
                    text: "Shape"
                }
                ComboBox {
                    Layout.fillWidth: true
                    model: ["Ellipse", "Line", "Mask", "Rectangle"]
                    currentIndex:
                        switch (gravity.shape.type) {
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
                        var oldShape = gravity.shape

                        switch (index) {
                        case 0:
                            gravity.shape = scene.ellipseShapeComponent.createObject(gravity)
                            break
                        case 1:
                            gravity.shape = scene.lineShapeComponent.createObject(gravity)
                            break
                        case 2:
                            gravity.shape = scene.maskShapeComponent.createObject(gravity)
                            break
                        case 3:
                            gravity.shape = scene.rectangleShapeComponent.createObject(gravity)
                            break
                        }

                        oldShape.destroy()
                    }
                }

                PropertyNameLabel {
                    visible: gravity.shape.type === "EllipseShape"
                    text: "Fill"
                }
                CheckBox {
                    visible: gravity.shape.type === "EllipseShape"
                    Layout.fillWidth: true

                    Component.onCompleted: {
                        if (visible)
                            checked = gravity.shape.fill
                    }
                    onVisibleChanged: {
                        if (visible)
                            checked = gravity.shape.fill
                    }
                    onCheckedChanged:
                        gravity.shape.fill = checked
                }

                PropertyNameLabel {
                    visible: gravity.shape.type === "LineShape"
                    text: "Mirrored"
                }
                CheckBox {
                    visible: gravity.shape.type === "LineShape"
                    Layout.fillWidth: true

                    Component.onCompleted: {
                        if (visible)
                            checked = gravity.shape.mirrored
                    }
                    onVisibleChanged: {
                        if (visible)
                            checked = gravity.shape.mirrored
                    }
                    onCheckedChanged:
                        gravity.shape.mirrored = checked
                }

                PropertyNameLabel {
                    visible: gravity.shape.type === "MaskShape"
                    text: "Source"
                }
                ImageSelector {
                    visible: gravity.shape.type === "MaskShape"
                    Layout.fillWidth: true

                    Component.onCompleted: {
                        if (visible)
                            path = gravity.shape.source
                    }
                    onVisibleChanged: {
                        if (visible)
                            path = gravity.shape.source
                    }
                    onPathChanged:
                        gravity.shape.source = path
                }

                Item {
                    Layout.fillHeight: true
                }
            }
        }

    function toQML() {
        var genericProperties = ["objectName", "x", "y", "width", "height"]
        var properties = ["enabled", "groups", "whenCollidingWith", "once", "angle", "magnitude", "system"]
        var objectProperties = ["shape"]

        var data = "    " + peGravity.type + " {"

        for (var i = 0; i < genericProperties.length; i++)
            data += "\n        %1: %2".arg(genericProperties[i]).arg(JSON.stringify(peGravity[genericProperties[i]]))

        for (i = 0; i < properties.length; i++) {
            if (properties[i] === "system")
                data += "\n        %1: %2".arg(properties[i]).arg(gravity.system.objectName)
            else if (properties[i] === "groups" || properties[i] === "whenCollidingWith")
                data += "\n        %1: %2".arg(properties[i]).arg(JSON.stringify(gravity.getListProperty(properties[i])))
            else
                data += "\n        %1: %2".arg(properties[i]).arg(JSON.stringify(gravity[properties[i]]))
        }

        for (i = 0; i < objectProperties.length; i++) {
            data += "\n        %1:\n%2".arg(objectProperties[i]).arg(gravity[objectProperties[i]].toQML())
        }

        data += "\n    }"

        return data
    }
}
