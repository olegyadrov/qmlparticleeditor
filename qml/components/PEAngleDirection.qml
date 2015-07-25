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

import QtQuick.Particles 2.0

AngleDirection {
    id: peAngleDirection

    property string type: "AngleDirection"

    function toQML() {
        var properties = ["angle", "angleVariation", "magnitude", "magnitudeVariation"]

        var data = "            " + peAngleDirection.type + " { \n"

        for (var i = 0; i < properties.length; i++)
            data += "                %1: %2\n".arg(properties[i]).arg(JSON.stringify(peAngleDirection[properties[i]]))

        data += "            }"

        return data
    }
}
