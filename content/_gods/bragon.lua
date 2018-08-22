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

local class = require('base.class')
local baseelder = require("content._gods.baseelder")

local M = {}

M.Bragon = class(
    baseelder.BaseElder,
    function(self, ...)
        self:_init(...)
    end
)

function M.Bragon:_init(ordinal, elderOrdinal)
    baseelder.BaseElder._init(self, ordinal, elderOrdinal) -- call the base class constructor
    self.nameDe = "Br�gon"
    self.nameEn = "Br�gon"
    self.descriptionDe = "der Gott des Feuers"
    self.descriptionEn = "God of fire"
    self.devotionItems = {} --FIXME

end



return M