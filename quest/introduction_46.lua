--[[
Illarion Server

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU Affero General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your option) any
later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU Affero General Public License for more
details.

You should have received a copy of the GNU Affero General Public License along
with this program.  If not, see <http://www.gnu.org/licenses/>. 
]]
-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (125, 'quest.alexis_dostas_125_cadomyr');

local common = require("base.common")
local factions = require("base.factions")
local introduction = require("lte.introduction")

local M = {}

local GERMAN = Player.german
local ENGLISH = Player.english

-- Insert the quest title here, in both languages
local Title = {}
Title[GERMAN] = "Einführung"
Title[ENGLISH] = "Introduction"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do

local waypoint, waypointRadius, waypointNameG, waypointNameE = introduction.initWaypoint(user)
local queststatus = User:getQuestProgress(44) --here, we save which places were visited
local germanText
local englishText
   
for i = 1, #waypoint do
     
    if not common.isBitSet(queststatus, i) then
        germanText = germanText..", "..waypointNameG[i]
        englishText = englishText..", "..waypointNameE[i]
    end
end

--Remove leading comma
germanText = string.sub(germanText, 3)
englishText = string.sub(englishText, 3)
    
local Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}
Description[GERMAN][1] = "GERMAN QUEST: : "..germanText.."."
Description[ENGLISH][1] = "Set out and explore your realm. Find other player characters and talk to them. Also, explore your home city. Interesting sites are marked with a red symbol on your map. You haven't visited: "..englishText.."."
Description[GERMAN][2] = "GERMAN DONE"
Description[ENGLISH][2] = "You finished the introduction. Have fun!"

-- Insert the quest status which is reached at the end of the quest
local FINAL_QUEST_STATUS = 2

function M.QuestTitle(user)
    return common.GetNLS(user, Title[GERMAN], Title[ENGLISH])
end

function M.QuestDescription(user, status)
    local german = Description[GERMAN][status] or ""
    local english = Description[ENGLISH][status] or ""

    return common.GetNLS(user, german, english)
end

function M.QuestStart()
    return Start
end

function M.QuestTargets(user, status)

    local waypoint, waypointRadius, waypointNameG, waypointNameE = introduction.initWaypoint(user)
    local queststatus = User:getQuestProgress(44) --here, we save which places were visited
    local QuestTarget = {}
    
    for i = 1, #waypoint do
     
        if not common.isBitSet(queststatus, i) then
            table.insert(QuestTarget[i], waypoint[i])
        end
    end

    return QuestTarget[status]
end

function M.QuestFinalStatus()
    return FINAL_QUEST_STATUS
end
return M
