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
-- UPDATE items SET itm_script='item.id_360_icefield' where itm_id=360;

require("base.common")
require("monster.base.monstermagic")

module("item.id_360_icefield", package.seeall)

function CharacterOnField(User)

    -- dont harm dead chars anymore
    if (User:increaseAttrib("hitpoints", 0) == 0) then
        return
    end

    -- dont harm NPCs
    if User:getType() == Character.npc then
        return
    end

    --immune
    if User:getType() == Character.monster then
        if User:getMonsterType() == 681 then -- Shiny Deathdragon
            return
        end
    end

    -- Eisflamme auf dem Feld suchen
    -- !!Eventuell gibt es Probleme, wenn sich mehrere Flammen auf einem Feld befinden!!
    local Items = base.common.GetItemsOnField(User.pos)
    local FieldItem
    for _, item in pairs(Items) do
        if(item.id == 360) then
            FieldItem = item
            break
        end
    end

    if (FieldItem.quality > 100) and User.pos.z ~= 100 and User.pos.z ~= 101 and User.pos.z ~= 40 then --no harmful flames on noobia or the working camp

        local resist = monster.base.monstermagic.SpellResistence(User) * 10
        if resist < FieldItem.quality then
            local damageDealt = math.random((7/100) * math.floor((FieldItem.quality  -resist) * 100), (9/100) * math.floor((FieldItem.quality - resist) * 100))
            User:increaseAttrib("hitpoints", -damageDealt)

            User:inform("Du f�hlst, wie das eiskalte Feuer allm�hlich deine Haut verbrennt.",
                        "You feel the icecold fire gradually burn your skin.")
        else
            DeleteFlame(User, FieldItem)
        end
    else
        DeleteFlame(User, FieldItem);
        User:inform("Die Eisflamme war nur eine Illusion und verpufft.",
                    "The iceflame was just an illusion and disappears.");
    end
end

function DeleteFlame(User, FlameItem)
    local field = world:getField(User.pos);
    local count = field:countItems();
    local currentitem;
    local items = { };
    for i=0, count-1 do
        currentitem = world:getItemOnField(User.pos);
        world:erase(currentitem, currentitem.number);
        if(currentitem.id ~= FlameItem.id) then
            table.insert(items, currentitem);
        end
    end
    for i,item in pairs(items) do
        world:createItemFromItem(item, User.pos, true);
    end
end
