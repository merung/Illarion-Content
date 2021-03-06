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
require("handler.createplayeritem")
require("questsystem.base")
module("questsystem.hagar_coin.trigger6", package.seeall)

local QUEST_NUMBER = 10001
local PRECONDITION_QUESTSTATE = 10
local POSTCONDITION_QUESTSTATE = 8

local POSITION = position(462, 285, 0)
local RADIUS = 2
local LOOKAT_TEXT_DE = "In einem kleinen Astloch findest du eine M�nze..."
local LOOKAT_TEXT_EN = "In a small hole, you find a coin..."

function LookAtItem(PLAYER, item)
  if PLAYER:isInRangeToPosition(POSITION,RADIUS)
      and questsystem.base.fulfilsPrecondition(PLAYER, QUEST_NUMBER, PRECONDITION_QUESTSTATE) then
	base.lookat.SetSpecialDescription(item, LOOKAT_TEXT_DE, LOOKAT_TEXT_EN)
	world:itemInform(PLAYER,item,base.lookat.GenerateLookAt(PLAYER, item, base.lookat.NONE));
    
handler.createplayeritem.createPlayerItem(PLAYER, 3077, 999, 10):execute()
    
    questsystem.base.setPostcondition(PLAYER, QUEST_NUMBER, POSTCONDITION_QUESTSTATE)
    return true
  end

  return false
end
