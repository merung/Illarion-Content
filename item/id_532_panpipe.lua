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
-- I_532 playing the panpipe

-- UPDATE common SET com_script='item.id_532_panpipe' WHERE com_itemid=532;

require("item.base.music")
require("item.general.wood")

module("item.id_532_panpipe", package.seeall)

skill = Character.panpipe

item.base.music.addTalkText("#me blows hard in the panpipes, making a loud, annoying, screeching sound.", "#me pustet in die Panfl�te und erzeugt ein lautes, nerviges, fast schreiendes Ger�usch.", skill );
item.base.music.addTalkText("#me blows in the panpipes randomly, letting out a few loud uncoordinated sounds.", "#me bl�st wirr auf der Panfl�te, laute aber unmelodische T�ne sind die Folge.", skill);
item.base.music.addTalkText("#me blows gently in the panpipes, singing a few, short tunes.","#me spielt einige leise T�ne sachte auf der Panfl�te. ", skill);
item.base.music.addTalkText("#me plays a nice, coordinated melody on the panpipes.","#me spielt eine klare Melodie auf der Panfl�te. ", skill);
item.base.music.addTalkText("#me plays his panpipes, blowing gently and gracefully, singing an impressively beautiful melody.","#me spielt beh�ndig eine beeindruckende Melodie voller Anmut auf der Panfl�te. ", skill);

function UseItem(User, SourceItem)
    item.base.music.PlayInstrument(User,SourceItem, skill);
end

LookAtItem = item.general.wood.LookAtItem
