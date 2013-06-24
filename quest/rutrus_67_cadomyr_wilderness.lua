-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (67, 'quest.rutrus_67_cadomyr_wilderness');

require("base.common")
module("quest.rutrus_67_cadomyr_wilderness", package.seeall)

GERMAN = Player.german
ENGLISH = Player.english

-- Insert the quest title here, in both languages
Title = {}
Title[GERMAN] = "Sternenoase"
Title[ENGLISH] = "Oasis of Stars"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}
Description[GERMAN][1] = "Sammel zehnmal groben Sand und bringe diese Rutrus. Nimm das Beil in die Hand und benutzt es, w�hrend du vor einem Stein im Sand stehst."
Description[ENGLISH][1] = "Collect ten coarse sand and bring them back to Rutrus. Use the shovel in your hand, while standing in front of a stone in the desert."
Description[GERMAN][2] = "Geh zu Rutrus in der Sternenoase. Er hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][2] = "Go back to Rutrus in the Oasis of Stars, he certainly have another task for you."
Description[GERMAN][3] = "Sammel zwanzigmal Quarzsand und bringe diese Rutrus. Siebe groben Sand um Quarzsand herzustelle. Nimm eine Holzkelle in die Hand und benutzt es, w�hrend du vor einem Sieb."
Description[ENGLISH][3] = "Produce twenty quartz sand and bring them back to Rutrus. Sieve coarse sand to produce quartz sand. Use the wooden shovel in your hand, while standing in front of a sieve."
Description[GERMAN][4] = "Geh zu Rutrus in der Sternenoase. Er hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][4] = "Go back to Rutrus in the Oasis of Stars, he certainly have another task for you."
Description[GERMAN][5] = "Sammel f�nf ungeschliffene Topaze und bringe diese Rutrus. Du kannst sie entweder beim H�ndler kaufen oder in der Mine finden. Nimm hierf�r eine Spitzhacke in die Hand und benutzt sie, w�hrend du vor einem Stein stehst."
Description[ENGLISH][5] = "Collect five raw topaz and bring them back to Rutrus. You can buy them from a merchant or find them in a mine. Therefor use the pick-axe in your hand, while standing in front of a stone."
Description[GERMAN][6] = "Geh zu Rutrus in der Sternenoase. Er hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][6] = "Go back to Rutrus in the Oasis of Stars, he certainly have another task for you."
Description[GERMAN][7] = "Besorge zehn Kohleklumpen und bringe sie Rutrus. Du kannst Kohle entweder beim H�ndler kaufen oder in der Mine finden. Nimm hierf�r eine Spitzhacke in die Hand und benutzt sie, w�hrend du vor einem Stein stehst."
Description[ENGLISH][7] = "Produce ten lumps of coal and bring them to Rutrus. You can buy coal from a merchant or find them in a mine. Therefor use the pick-axe in your hand, while standing in front of a stone."
Description[GERMAN][8] = "Du hast alle Aufgaben von Rutrus erf�llt."
Description[ENGLISH][8] = "You have fulfilled all the tasks for Rutrus."


-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
QuestTarget = {}
QuestTarget[1] = {position(359, 678, 0), position(352, 678, 0)} -- stone
QuestTarget[2] = {position(359, 678, 0)} 
QuestTarget[3] = {position(359, 678, 0), position(143, 592, 0)} -- sieve
QuestTarget[4] = {position(359, 678, 0)} 
QuestTarget[5] = {position(359, 678, 0), position(133, 589, 0), position(169, 607, 0)} -- h�ndler mine
QuestTarget[6] = {position(359, 678, 0)} 
QuestTarget[7] = {position(359, 678, 0), position(133, 589, 0), position(143, 689, 0)} -- h�ndler mine
QuestTarget[8] = {position(359, 678, 0)} 

-- Insert the quest status which is reached at the end of the quest
FINAL_QUEST_STATUS = 8


function QuestTitle(user)
    return base.common.GetNLS(user, Title[GERMAN], Title[ENGLISH])
end

function QuestDescription(user, status)
    local german = Description[GERMAN][status] or ""
    local english = Description[ENGLISH][status] or ""

    return base.common.GetNLS(user, german, english)
end

function QuestTargets(user, status)
    return QuestTarget[status]
end

function QuestFinalStatus()
    return FINAL_QUEST_STATUS
end