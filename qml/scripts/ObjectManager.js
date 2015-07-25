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

.pragma library

var system
var particles = []
var emitters = []
var affectors = []

function getDefaultSystem() {
    return system
}

var counters = {
    particles: 0,
    emitters: 0,
    affectors: 0
}

function getNewParticleID() {
    return counters.particles++
}

function getNewEmitterID() {
    return counters.emitters++
}

function getNewAffectorID() {
    return counters.affectors++
}
