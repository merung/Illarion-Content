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
require("handler.sendmessagetoplayer")
require("questsystem.base")
require("base.lookat")
require("base.common")
module("questsystem.Geld_in_Hecke.trigger5", package.seeall)

local QUEST_NUMBER = 700
local PRECONDITION_QUESTSTATE = 2
local POSTCONDITION_QUESTSTATE = 2

local POSITION = position(685, 316, 0)
local RADIUS = 2
local LOOKAT_TEXT_DE = "Ganz unten auf dem Boden des Fasses siehst du eine Notiz, die folgendes besagt: \"Das Geld liegt wie immer in der Hecke.\""
local LOOKAT_TEXT_EN = "On the very bottom of the barrel is a hidden note. You can read the following: \"The money is as always in the hedge!\""

function LookAtItem(PLAYER, item)
  if PLAYER:isInRangeToPosition(POSITION,RADIUS)
      and ADDITIONALCONDITIONS(PLAYER)
      and questsystem.base.fulfilsPrecondition(PLAYER, QUEST_NUMBER, PRECONDITION_QUESTSTATE) then

    itemInformNLS(PLAYER, item, LOOKAT_TEXT_DE, LOOKAT_TEXT_EN)

    HANDLER(PLAYER)

    questsystem.base.setPostcondition(PLAYER, QUEST_NUMBER, POSTCONDITION_QUESTSTATE)
    return true
  end

  return false
end

function itemInformNLS(player, item, textDe, textEn)
  local lookAt = base.lookat.GenerateLookAt(player, item)
  lookAt.description = base.common.GetNLS(player, textDe, textEn)
  world:itemInform(player, item, lookAt)
end


function HANDLER(PLAYER)
    handler.sendmessagetoplayer.sendMessageToPlayer(PLAYER, "Geh und suche in der Hecke beim Cadomyr Wegschild nicht weit von hier.", "Go and seach in the hedge at the Cadomyr signpost not far from here."):execute()
end

function ADDITIONALCONDITIONS(PLAYER)
return true
end