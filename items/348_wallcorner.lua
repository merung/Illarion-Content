-- UPDATE common SET com_script='items.348_wallcorner' WHERE com_itemid = 348;

module("items.348_wallcorner", package.seeall())

function UseItem( User, Item, TargetItem, counter, param )
    if equapos(Item.pos,position(-106,-147,0)) then
        local lang=User:getPlayerLanguage();
        if ( (User:getQuestProgress(5) == 1) or (User:isAdmin()) ) then
                if lang==0 then
                    User:inform("Als du die Wand abtastet bemerkst du einen losen Ziegel. Im Inneren der Mauer findest du einige M�nzen.");
                else
                    User:inform("As you feel the wall you notice a loose brick. In the interior of the wall you find some coins.");
                end
            if (User:createItem( 3076, 23, 333, 0 ) ~= 0 ) then
                if lang==0 then
                    User:inform("Du kannst jedoch nicht mehr tragen.");
                else
                    User:inform("But you cannot carry more.");
                end;
            else
                User:setQuestProgress(5,2);
            end;
        elseif (User:getQuestProgress(5) == 2) then
                if lang==0 then
                    User:inform("Als deine Hand noch tiefer hineinf�hrt findest du einen kleinen Ring.");
                else
                    User:inform("As you reach deeper into the hole you find a tiny ring.");
                end
            if (User:createItem( 235, 1, 999, 0 ) ~= 0 ) then
                if lang==0 then
                    User:inform("Du kannst jedoch nicht mehr tragen.");
                else
                    User:inform("But you cannot carry more.");
                end;
            else
                User:setQuestProgress(5,3);
            end;
        else
            
                if lang==0 then
                    User:inform("Das Loch ist anscheinend leer.");
                else
                    User:inform("The hole seems to be empty.");
                end;
            
        end
    end
end
