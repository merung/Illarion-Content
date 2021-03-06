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
-- This script spawns treasure chests (2830) whereever needed
-- Estralis

require("base.common")

module("scheduled.spawn_treasure", package.seeall)

function spawnTreasure()

	treasurePos=position(703,422,-3); --Salavesh dungeon
	
    if table.getn(world:getPlayersInRangeOf(treasurePos,20)) == 0 and world:isItemOnField(treasurePos) == false then --only spawn a treasure if nobody is around and there is no item on the tile
	
		world:createItemFromId(2830,1,treasurePos,false,333,{trsCat=math.random(0,4)}); --spawn the chest only if the tile is empty
		
	end
	
end