require("base.lookat")

module("items.priest.jewel", package.seeall())

-- UPDATE common SET com_script='items.priest.jewel' WHERE com_itemid IN (62,67,71,82,83,334,463,465);

function LookAtItem(User,Item)
    world:itemInform(User,Item,base.lookat.GetItemDescription(User,Item,4,false,true ));
end