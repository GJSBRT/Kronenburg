--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
local m = {} -- <<< Don't touch this!
-----------[ SETTINGS ]---------------------------------------------------

-- Delay in minutes between messages
m.delay = 15

-- Prefix appears in front of each message. 
-- Suffix appears on the end of each message.
-- Leave a prefix/suffix empty ( '' ) to disable them.
m.prefix = '^*Kronenburg Roleplay^r:'
m.suffix = ''

-- You can make as many messages as you want.
-- You can use ^0-^9 in your messages to change text color.
m.messages = {   
    'Wordt er niet gereageerd op ^8^*/report^r^7?‏‏‎ Maak dan een ticket of join de wachtkamer in onze discord! -> dsc.gg/kronenburgrp ',
    '^8^*FailRP?^r^7 of ^8^*Hulp nodig?^r^7.‏‏‎ Gebruik dan^8 ^*/report^7^r^7 in de chat.',
    'Lees de regels in onze ^8^*Discord^r^7! -> ^*dsc.gg/kronenburg^r',
    '^8^*Hulpdiensten^r^7 reageren ^8^*ALLEEN^r^7 op gedetailleerde meldingen!',
    'Illegale activiteiten via ^8^*Twitter^r^7 is niet toegestaan!',
    'Niet ^8tevreden^r met de roleplay? Maak het ^8scenario^r af en join de ^8wachtkamer^r met jou ^8clip^r -> dsc.gg/kronenburgrp '
}

-- Player identifiers on this list will not receive any messages.
-- Simply remove all identifiers if you don't want an ignore list.
m.ignorelist = { 
    '',

}
--------------------------------------------------------------------------


















-----[ CODE, DON'T TOUCH THIS ]-------------------------------------------
local playerIdentifiers
local enableMessages = true
local timeout = m.delay * 1000 * 60 -- from ms, to sec, to min
local playerOnIgnoreList = false
RegisterNetEvent('va:setPlayerIdentifiers')
AddEventHandler('va:setPlayerIdentifiers', function(identifiers)
    playerIdentifiers = identifiers
end)
Citizen.CreateThread(function()
    while playerIdentifiers == {} or playerIdentifiers == nil do
        Citizen.Wait(1000)
        TriggerServerEvent('va:getPlayerIdentifiers')
    end
    for iid in pairs(m.ignorelist) do
        for pid in pairs(playerIdentifiers) do
            if m.ignorelist[iid] == playerIdentifiers[pid] then
                playerOnIgnoreList = true
                break
            end
        end
    end
    if not playerOnIgnoreList then
        while true do
            for i in pairs(m.messages) do
                if enableMessages then
                    chat(i)
                end
                Citizen.Wait(timeout)
            end
            
            Citizen.Wait(0)
        end
    else
        print('Speler staat op zwarte lijst hij zal hem niet ontvangen .')
    end
end)
function chat(i)
	TriggerEvent('chat:addMessage',{
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 175, 0, 0.6); border-radius: 3px;"><i class="fas fa-bullhorn"></i> {0} {1} {2}</div>',
        args = {m.prefix, m.messages[i], m.suffix}
    })
end
--------------------------------------------------------------------------
