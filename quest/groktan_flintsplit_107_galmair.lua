-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (107, 'quest.groktan_flintsplit_107_galmair');

require("base.common")
module("quest.groktan_flintsplit_107_galmair", package.seeall)

GERMAN = Player.german
ENGLISH = Player.english

-- Insert the quest title here, in both languages
Title = {}
Title[GERMAN] = "Die Erinnerung"
Title[ENGLISH] = "The Reminder"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}
Description[GERMAN][1] = "Besorge fünf Seile und bringe sie Groktan. Du kannst sie bei einem Händler kaufen oder mit einer Nadel am Schneidertisch herstellen. "
Description[ENGLISH][1] = "Obtain five ropes and bring them to Groktan. You can buy them from a merchant or produce them by using a needle in your hand whilst standing in front of a tailoring table."
Description[GERMAN][2] = "Gehe zu Groktan Flintsplit, dem Schuldeneintreiber von Galmair. Er hat bestimmt noch eine Aufgabe für dich."
Description[ENGLISH][2] = "Go back to Groktan Flintsplit, the debt-collector of Galmair, he certainly has another task for you."
Description[GERMAN][3] = "Suche Miggs in der Bibliothek von Galmair auf und sprich ihn wegen der Nachricht an."
Description[ENGLISH][3] = "Seek Miggs in the libary of Galmair and talk to him about the letter."
Description[GERMAN][4] = "Kehre zu Groktan zurück."
Description[ENGLISH][4] = "Return to Groktan."
Description[GERMAN][5] = "Gehe zu Groktan Flintsplit, dem Schuldeneintreiber von Galmair. Er hat bestimmt noch eine Aufgabe für dich."
Description[ENGLISH][5] = "Go back to Groktan Flintsplit, the debt-collector of Galmair, he certainly has another task for you."
Description[GERMAN][6] = "Suche Bruno Blackhole in der Malachitmine bei Galmair und sprich ihn wegen der Nachricht an."
Description[ENGLISH][6] = "Seek Bruno Blackhole in the Malachite Mine near Galmair and talk to him about the letter."
Description[GERMAN][7] = "Kehre zu Groktan zurück."
Description[ENGLISH][7] = "Return to Groktan."
Description[GERMAN][8] = "Gehe zu Groktan Flintsplit, dem Schuldeneintreiber von Galmair. Er hat bestimmt noch eine Aufgabe für dich."
Description[ENGLISH][8] = "Go back to Groktan Flintsplit, the debt-collector of Galmair, he certainly has another task for you."
Description[GERMAN][9] = "Suche Fronita Emery auf dem Marktplatz von Runewick und sprich sie wegen der Nachricht an."
Description[ENGLISH][9] = "Seek Fronita Emery in the marketplace of Runewick and talk to her about the letter."
Description[GERMAN][10] = "Kehre zu Groktan zurück."
Description[ENGLISH][10] = "Return to Groktan."
Description[GERMAN][11] = "Gehe zu Groktan Flintsplit, dem Schuldeneintreiber von Galmair. Er hat bestimmt noch eine Aufgabe für dich."
Description[ENGLISH][11] = "Go back to Groktan Flintsplit, the debt-collector of Galmair, he certainly has another task for you."
Description[GERMAN][12] = "Suche Königin Rosaline Edwards in ihrem Palast in Cadomyr und sprich sie wegen der Nachricht an."
Description[ENGLISH][12] = "Seek Queen Rosaline Edwards of Cadomyr, she should be in her palace, and talk to her about the letter."
Description[GERMAN][13] = "Kehre zu Groktan zurück."
Description[ENGLISH][13] = "Return to Groktan."
Description[GERMAN][14] = "Du hast alle Aufgaben von Groktan Flintsplit erfüllt."
Description[ENGLISH][14] = "You have fulfilled all the tasks for Groktan Flintsplit."


-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
QuestTarget = {}
QuestTarget[1] = {position(388, 238, 0), position(366, 275, 0)} 
QuestTarget[2] = {position(388, 238, 0)} 
QuestTarget[3] = {position(374, 216, 0)} 
QuestTarget[4] = {position(388, 238, 0)} 
QuestTarget[5] = {position(388, 238, 0)} 
QuestTarget[6] = {position(439, 359, 0)} 
QuestTarget[7] = {position(388, 238, 0)} 
QuestTarget[8] = {position(388, 238, 0)} 
QuestTarget[9] = {position(893, 799, 1)} 
QuestTarget[10] = {position(388, 238, 0)} 
QuestTarget[11] = {position(388, 238, 0)} 
QuestTarget[12] = {position(122, 521, 0)} 
QuestTarget[13] = {position(388, 238, 0)} 
QuestTarget[14] = {position(388, 238, 0)} 

-- Insert the quest status which is reached at the end of the quest
FINAL_QUEST_STATUS = 14


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