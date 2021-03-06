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
require("base.class")
require("npc.base.consequence.consequence")
require("item.gems")

module("npc.base.consequence.gemcraft", package.seeall)

gemcraft = base.class.class(npc.base.consequence.consequence.consequence,
function(self)
    npc.base.consequence.consequence.consequence:init(self);
    
    self["perform"] = _craft_helper;
end);

function _craft_helper(self, npcChar, player)
    item.gems.magicSmith(npcChar, player) 
end;
