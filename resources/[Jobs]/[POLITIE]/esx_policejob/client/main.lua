local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


local prevMaleVariation       = 0
local prevFemaleVariation     = 0
local femaleHash              = GetHashKey("mp_f_freemode_01")
local maleHash                = GetHashKey("mp_m_freemode_01")
local changed                 = false
local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastStation             = nil
local LastPart                = nil
local LastPartNum             = nil
local LastEntity              = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local IsHandcuffed            = false
local HandcuffTimer           = nil
local IsDragged               = false
local CopPed                  = 0
local hasAlreadyJoined        = false
local blipsCops               = {}
local isDead                  = false
local CurrentTask             = {}
local isPolitie               = false
local sleep                   = 0

local DragStatus = {}
DragStatus.IsDragged = false
DragStatus.draganim = false



ESX = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(7)
	end

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)




function SetVehicleMaxMods(vehicle)
	local props = {
		modEngine       = 2,
		modBrakes       = 2,
		modTransmission = 2,
		modSuspension   = 3,
		modTurbo        = true,
	}

	ESX.Game.SetVehicleProperties(vehicle, props)
end

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function setUniform(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)

		if skin.sex == 0 then
			if Config.Uniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 50)
			end
			if job == 'be_wear' then
				SetPedArmour(playerPed, 70)
			end
			if job == 'dsilicht_wear' then
				SetPedArmour(playerPed, 60)
			end
			if job == 'dsizwaar_wear' then
				SetPedArmour(playerPed, 90)
			end
			if job == 'dsimiddel_wear' then
				SetPedArmour(playerPed, 80)
			end
			if job == 'atvest_wear' then
				SetPedArmour(playerPed, 50)
			end
			if job == 'aot_wear' then
				SetPedArmour(playerPed, 50)
			end
			if job == 'justitie_wear' then
				SetPedArmour(playerPed, 65)
			end
		else
			if Config.Uniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
			if job == 'atvest_wear' then
				SetPedArmour(playerPed, 100)
			end
		end

	end)
end

function OpenCloakroomMenu()

	local playerPed = PlayerPedId()
	local grade = PlayerData.job.grade_name

	local elements = {
		{ label = _U('citizen_wear'), value = 'citizen_wear' }
	}

	if grade == 'aspirant' then
		table.insert(elements, { label = _U('police_wear'), value = 'aspnhkort_wear' })
		table.insert(elements, { label = _U('lang_wear'), value = 'aspnhlang_wear' })
		table.insert(elements, { label = _U('politievest_wear'), value = 'politievest_wear' })
		table.insert(elements, { label = _U('bullet_wear'), value = 'bullet_wear' }) -- Kogelwerend Vest
		table.insert(elements, { label = _U('kogelwerendweg_wear'), value = 'kogelwerendweg_wear' }) -- Kogelwerend Vest Weg
		table.insert(elements, { label = _U('pet_wear'), value = 'pet_wear' })
		table.insert(elements, { label = _U('taser_los'), value = 'taser' }) -- Taser beenholster
		table.insert(elements, { label = _U('traffic_wear'), value = 'traffic_wear' })
		table.insert(elements, { label = _U('casino_wear'), value = 'casino_wear' })
	elseif grade == 'surveillant' then
		table.insert(elements, { label = _U('police_wear'), value = 'nhkort_wear' })
		table.insert(elements, { label = _U('lang_wear'), value = 'nhlang_wear' })
		table.insert(elements, { label = _U('politievest_wear'), value = 'politievest_wear' })
		table.insert(elements, { label = _U('bullet_wear'), value = 'bullet_wear' }) -- Kogelwerend Vest
		table.insert(elements, { label = _U('kogelwerendweg_wear'), value = 'kogelwerendweg_wear' }) -- Kogelwerend Vest Weg
		table.insert(elements, { label = _U('pet_wear'), value = 'pet_wear' })
		table.insert(elements, { label = _U('taser_los'), value = 'taser' }) -- Taser beenholster
		table.insert(elements, { label = _U('traffic_wear'), value = 'traffic_wear' })
		table.insert(elements, { label = _U('casino_wear'), value = 'casino_wear' })
	elseif grade == 'agent' then
		table.insert(elements, { label = _U('police_wear'), value = 'nhkort_wear' })
		table.insert(elements, { label = _U('lang_wear'), value = 'nhlang_wear' })
		table.insert(elements, { label = _U('motor_wear'), value = 'motor_wear' })
		table.insert(elements, { label = _U('bullet_wear'), value = 'bullet_wear' }) -- Kogelwerend Vest
		table.insert(elements, { label = _U('kogelwerendweg_wear'), value = 'kogelwerendweg_wear' }) -- Kogelwerend Vest Weg
		table.insert(elements, { label = _U('politievest_wear'), value = 'politievest_wear' })
		table.insert(elements, { label = _U('traffic_wear'), value = 'traffic_wear' })
		table.insert(elements, { label = _U('verkeerspolitie_wear'), value = 'vpvest_wear' })
		table.insert(elements, { label = _U('pet_wear'), value = 'pet_wear' })
		table.insert(elements, { label = _U('taser_los'), value = 'taser' }) -- Taser beenholster
		table.insert(elements, { label = _U('casino_wear'), value = 'casino_wear' })
	elseif grade == 'hoofdagent' then
		table.insert(elements, { label = _U('undercover_wear'), value = 'undercover_wear' })
		table.insert(elements, { label = _U('police_wear'), value = 'nhkort_wear' })
		table.insert(elements, { label = _U('motor_wear'), value = 'motor_wear' })
		--table.insert(elements, {label = _U('motorunmarked_wear'), value = 'motorunmarked_wear'})
		table.insert(elements, { label = _U('lang_wear'), value = 'nhlang_wear' })
		table.insert(elements, { label = _U('politievest_wear'), value = 'politievest_wear' })
		table.insert(elements, { label = _U('verkeerspolitie_wear'), value = 'vpvest_wear' })
		table.insert(elements, { label = _U('bullet_wear'), value = 'bullet_wear' }) -- Kogelwerend Vest
		table.insert(elements, { label = _U('kogelwerendweg_wear'), value = 'kogelwerendweg_wear' }) -- Kogelwerend Vest Weg
		table.insert(elements, { label = _U('traffic_wear'), value = 'traffic_wear' })
		table.insert(elements, { label = _U('pet_wear'), value = 'pet_wear' })
		table.insert(elements, { label = _U('holster_tas'), value = 'holster_tas' }) -- Been holster met tasje
		table.insert(elements, { label = _U('taser_los'), value = 'taser' }) -- Taser beenholster
		table.insert(elements, { label = 'IBT', value = 'ibt_wear' })
		table.insert(elements, { label = _U('be_wear'), value = 'be_wear' }) -- BE
		table.insert(elements, { label = _U('casino_wear'), value = 'casino_wear' })
		table.insert(elements, { label = _U('undercover_wear'), value = 'undercover_wear' })
	elseif grade == 'brigadier' then
		table.insert(elements, { label = _U('police_wear'), value = 'nhkort_wear' }) -- Noodhulp kort
		table.insert(elements, { label = _U('lang_wear'), value = 'nhlang_wear' }) -- Noodhulp lang
		--table.insert(elements, {label = _U('hond_wear1'), value = 'hond_wear1'})  -- Hondengeleider 1
		--table.insert(elements, {label = _U('hond_wear2'), value = 'hond_wear2'})  -- Hondengeleider 2
		--table.insert(elements, {label = _U('undercoverkort_wear'), value = 'undercoverkort_wear'})  -- Undercover kort
		--table.insert(elements, {label = _U('undercover_wear'), value = 'undercover_wear'})  -- Undercover lang
		table.insert(elements, { label = _U('motor_wear'), value = 'motor_wear' }) -- Motor marked
		--table.insert(elements, {label = _U('motorunmarked_wear'), value = 'motorunmarked_wear'})  -- Motor unmarked
		--table.insert(elements, {label = _U('bewakingseenheid_wear'), value = 'bewakingseenheid_wear'})  -- BE
		table.insert(elements, { label = 'IBT', value = 'ibt_wear' }) -- IBT
		table.insert(elements, { label = _U('politievest_wear'), value = 'politievest_wear' }) -- Noodhulp Steekvest
		table.insert(elements, { label = _U('traffic_wear'), value = 'traffic_wear' }) -- Horeca Steekvest
		--table.insert(elements, {label = _U('undercovervest_wear'), value = 'undercovervest_wear'})  -- Undercover Steekvest
		--table.insert(elements, {label = _U('wijkagentvest_wear'), value = 'wijkagentvest_wear'})  -- Wijkagent Steekvest
		table.insert(elements, { label = _U('hondengeleidervest_wear'), value = 'hondengeleidervest_wear' }) -- Hondergeleider Steekvest
		table.insert(elements, { label = _U('verkeerspolitie_wear'), value = 'vpvest_wear' })
		table.insert(elements, { label = _U('bullet_wear'), value = 'bullet_wear' }) -- Kogelwerend Vest
		table.insert(elements, { label = _U('kogelwerendweg_wear'), value = 'kogelwerendweg_wear' }) -- Kogelwerend Vest Weg
		table.insert(elements, { label = _U('veiligheidshesje_wear'), value = 'veiligheidshesje_wear' }) -- Veiligheids Hesje
		table.insert(elements, { label = _U('gilet_wear'), value = 'gilet_wear' }) -- OVD Hesje
		table.insert(elements, { label = _U('taser_los'), value = 'taser' }) -- Taser beenholster
		table.insert(elements, { label = _U('holster_tas'), value = 'holster_tas' }) -- Been holster met tasje
		table.insert(elements, { label = _U('pet_wear'), value = 'pet_wear' }) -- Politie Pet
		table.insert(elements, { label = _U('dsitas'), value = 'dsitas' }) -- DSI TAS
		table.insert(elements, { label = _U('aot_wear'), value = 'aot_wear' }) -- AOT
		table.insert(elements, { label = _U('dsilicht_wear'), value = 'dsilicht_wear' }) -- DSI LICHT
		table.insert(elements, { label = _U('dsimiddel_wear'), value = 'dsimiddel_wear' }) -- DSI MIDDEL
		table.insert(elements, { label = _U('dsizwaar_wear'), value = 'dsizwaar_wear' }) -- DSI ZWAAR 
		table.insert(elements, { label = _U('dsitas'), value = 'dsitas' }) -- DSI ZWAAR 
		table.insert(elements, { label = _U('be_wear'), value = 'be_wear' }) -- BE
		table.insert(elements, { label = _U('casino_wear'), value = 'casino_wear' })
		table.insert(elements, { label = _U('undercover_wear'), value = 'undercover_wear' })
		table.insert(elements, { label = _U('justitie_wear'), value = 'justitie_wear' })

	elseif grade == 'inspecteur' then
		table.insert(elements, { label = _U('police_wear'), value = 'nhkort_wear' }) -- Noodhulp kort
		table.insert(elements, { label = _U('lang_wear'), value = 'nhlang_wear' }) -- Noodhulp lang
		--table.insert(elements, {label = _U('hond_wear1'), value = 'hond_wear1'})  -- Hondengeleider 1
		--table.insert(elements, {label = _U('hond_wear2'), value = 'hond_wear2'})  -- Hondengeleider 2
		--table.insert(elements, {label = _U('undercoverkort_wear'), value = 'undercoverkort_wear'})  -- Undercover kort
		--table.insert(elements, {label = _U('undercover_wear'), value = 'undercover_wear'})  -- Undercover lang
		table.insert(elements, { label = _U('motor_wear'), value = 'motor_wear' }) -- Motor marked
		--table.insert(elements, {label = _U('motorunmarked_wear'), value = 'motorunmarked_wear'})  -- Motor unmarked
		--table.insert(elements, {label = _U('bewakingseenheid_wear'), value = 'bewakingseenheid_wear'})  -- BE
		table.insert(elements, { label = 'IBT', value = 'ibt_wear' }) -- IBT
		table.insert(elements, { label = _U('politievest_wear'), value = 'politievest_wear' }) -- Noodhulp Steekvest
		table.insert(elements, { label = _U('traffic_wear'), value = 'traffic_wear' }) -- Horeca Steekvest
		--table.insert(elements, {label = _U('undercovervest_wear'), value = 'undercovervest_wear'})  -- Undercover Steekvest
		--table.insert(elements, {label = _U('wijkagentvest_wear'), value = 'wijkagentvest_wear'})  -- Wijkagent Steekvest
		table.insert(elements, { label = _U('hondengeleidervest_wear'), value = 'hondengeleidervest_wear' }) -- Hondergeleider Steekvest
		table.insert(elements, { label = _U('verkeerspolitie_wear'), value = 'vpvest_wear' })
		table.insert(elements, { label = _U('bullet_wear'), value = 'bullet_wear' }) -- Kogelwerend Vest
		table.insert(elements, { label = _U('kogelwerendweg_wear'), value = 'kogelwerendweg_wear' }) -- Kogelwerend Vest Weg
		table.insert(elements, { label = _U('veiligheidshesje_wear'), value = 'veiligheidshesje_wear' }) -- Veiligheids Hesje
		table.insert(elements, { label = _U('gilet_wear'), value = 'gilet_wear' }) -- OVD Hesje
		table.insert(elements, { label = _U('taser_los'), value = 'taser' }) -- Taser beenholster
		table.insert(elements, { label = _U('holster_tas'), value = 'holster_tas' }) -- Been holster met tasje
		table.insert(elements, { label = _U('pet_wear'), value = 'pet_wear' }) -- Politie Pet
		table.insert(elements, { label = _U('dsitas'), value = 'dsitas' }) -- DSI TAS
		table.insert(elements, { label = _U('aot_wear'), value = 'aot_wear' }) -- AOT
		table.insert(elements, { label = _U('dsilicht_wear'), value = 'dsilicht_wear' }) -- DSI LICHT
		table.insert(elements, { label = _U('dsimiddel_wear'), value = 'dsimiddel_wear' }) -- DSI MIDDEL
		table.insert(elements, { label = _U('dsizwaar_wear'), value = 'dsizwaar_wear' }) -- DSI ZWAAR 
		table.insert(elements, { label = _U('dsitas'), value = 'dsitas' }) -- DSI ZWAAR 
		table.insert(elements, { label = _U('be_wear'), value = 'be_wear' }) -- BE
		table.insert(elements, { label = _U('casino_wear'), value = 'casino_wear' })
		table.insert(elements, { label = _U('undercover_wear'), value = 'undercover_wear' })
		table.insert(elements, { label = _U('justitie_wear'), value = 'justitie_wear' })

	elseif grade == 'hoofdinspecteur' then
		table.insert(elements, { label = _U('police_wear'), value = 'nhkort_wear' }) -- Noodhulp kort
		table.insert(elements, { label = _U('lang_wear'), value = 'nhlang_wear' }) -- Noodhulp lang
		--table.insert(elements, {label = _U('hond_wear1'), value = 'hond_wear1'})  -- Hondengeleider 1
		--table.insert(elements, {label = _U('hond_wear2'), value = 'hond_wear2'})  -- Hondengeleider 2
		--table.insert(elements, {label = _U('undercoverkort_wear'), value = 'undercoverkort_wear'})  -- Undercover kort
		--table.insert(elements, {label = _U('undercover_wear'), value = 'undercover_wear'})  -- Undercover lang
		table.insert(elements, { label = _U('motor_wear'), value = 'motor_wear' }) -- Motor marked
		--table.insert(elements, {label = _U('motorunmarked_wear'), value = 'motorunmarked_wear'})  -- Motor unmarked
		--table.insert(elements, {label = _U('bewakingseenheid_wear'), value = 'bewakingseenheid_wear'})  -- BE
		table.insert(elements, { label = 'IBT', value = 'ibt_wear' }) -- IBT
		table.insert(elements, { label = _U('politievest_wear'), value = 'politievest_wear' }) -- Noodhulp Steekvest
		table.insert(elements, { label = _U('traffic_wear'), value = 'traffic_wear' }) -- Horeca Steekvest
		--table.insert(elements, {label = _U('undercovervest_wear'), value = 'undercovervest_wear'})  -- Undercover Steekvest
		--table.insert(elements, {label = _U('wijkagentvest_wear'), value = 'wijkagentvest_wear'})  -- Wijkagent Steekvest
		table.insert(elements, { label = _U('hondengeleidervest_wear'), value = 'hondengeleidervest_wear' }) -- Hondergeleider Steekvest
		table.insert(elements, { label = _U('verkeerspolitie_wear'), value = 'vpvest_wear' })
		table.insert(elements, { label = _U('bullet_wear'), value = 'bullet_wear' }) -- Kogelwerend Vest
		table.insert(elements, { label = _U('kogelwerendweg_wear'), value = 'kogelwerendweg_wear' }) -- Kogelwerend Vest Weg
		table.insert(elements, { label = _U('veiligheidshesje_wear'), value = 'veiligheidshesje_wear' }) -- Veiligheids Hesje
		table.insert(elements, { label = _U('gilet_wear'), value = 'gilet_wear' }) -- OVD Hesje
		table.insert(elements, { label = _U('taser_los'), value = 'taser' }) -- Taser beenholster
		table.insert(elements, { label = _U('holster_tas'), value = 'holster_tas' }) -- Been holster met tasje
		table.insert(elements, { label = _U('pet_wear'), value = 'pet_wear' }) -- Politie Pet
		table.insert(elements, { label = _U('dsitas'), value = 'dsitas' }) -- DSI TAS
		table.insert(elements, { label = _U('aot_wear'), value = 'aot_wear' }) -- AOT
		table.insert(elements, { label = _U('dsilicht_wear'), value = 'dsilicht_wear' }) -- DSI LICHT
		table.insert(elements, { label = _U('dsimiddel_wear'), value = 'dsimiddel_wear' }) -- DSI MIDDEL
		table.insert(elements, { label = _U('dsizwaar_wear'), value = 'dsizwaar_wear' }) -- DSI ZWAAR 
		table.insert(elements, { label = _U('dsitas'), value = 'dsitas' }) -- DSI ZWAAR 
		table.insert(elements, { label = _U('be_wear'), value = 'be_wear' }) -- BE
		table.insert(elements, { label = _U('casino_wear'), value = 'casino_wear' })
		table.insert(elements, { label = _U('undercover_wear'), value = 'undercover_wear' })
		table.insert(elements, { label = _U('justitie_wear'), value = 'justitie_wear' })

	elseif grade == 'boss' then
		table.insert(elements, { label = _U('police_wear'), value = 'nhkort_wear' }) -- Noodhulp kort
		table.insert(elements, { label = _U('lang_wear'), value = 'nhlang_wear' }) -- Noodhulp lang
		--table.insert(elements, {label = _U('hond_wear1'), value = 'hond_wear1'})  -- Hondengeleider 1
		--table.insert(elements, {label = _U('hond_wear2'), value = 'hond_wear2'})  -- Hondengeleider 2
		--table.insert(elements, {label = _U('undercoverkort_wear'), value = 'undercoverkort_wear'})  -- Undercover kort
		--table.insert(elements, {label = _U('undercover_wear'), value = 'undercover_wear'})  -- Undercover lang
		table.insert(elements, { label = _U('motor_wear'), value = 'motor_wear' }) -- Motor marked
		--table.insert(elements, {label = _U('motorunmarked_wear'), value = 'motorunmarked_wear'})  -- Motor unmarked
		--table.insert(elements, {label = _U('bewakingseenheid_wear'), value = 'bewakingseenheid_wear'})  -- BE
		table.insert(elements, { label = 'IBT', value = 'ibt_wear' }) -- IBT
		table.insert(elements, { label = _U('politievest_wear'), value = 'politievest_wear' }) -- Noodhulp Steekvest
		table.insert(elements, { label = _U('traffic_wear'), value = 'traffic_wear' }) -- Horeca Steekvest
		--table.insert(elements, {label = _U('undercovervest_wear'), value = 'undercovervest_wear'})  -- Undercover Steekvest
		--table.insert(elements, {label = _U('wijkagentvest_wear'), value = 'wijkagentvest_wear'})  -- Wijkagent Steekvest
		table.insert(elements, { label = _U('hondengeleidervest_wear'), value = 'hondengeleidervest_wear' }) -- Hondergeleider Steekvest
		table.insert(elements, { label = _U('verkeerspolitie_wear'), value = 'vpvest_wear' })
		table.insert(elements, { label = _U('bullet_wear'), value = 'bullet_wear' }) -- Kogelwerend Vest
		table.insert(elements, { label = _U('kogelwerendweg_wear'), value = 'kogelwerendweg_wear' }) -- Kogelwerend Vest Weg
		table.insert(elements, { label = _U('veiligheidshesje_wear'), value = 'veiligheidshesje_wear' }) -- Veiligheids Hesje
		table.insert(elements, { label = _U('gilet_wear'), value = 'gilet_wear' }) -- OVD Hesje
		table.insert(elements, { label = _U('taser_los'), value = 'taser' }) -- Taser beenholster
		table.insert(elements, { label = _U('holster_tas'), value = 'holster_tas' }) -- Been holster met tasje
		table.insert(elements, { label = _U('pet_wear'), value = 'pet_wear' }) -- Politie Pet
		table.insert(elements, { label = _U('dsitas'), value = 'dsitas' }) -- DSI TAS
		table.insert(elements, { label = _U('aot_wear'), value = 'aot_wear' }) -- AOT
		table.insert(elements, { label = _U('dsilicht_wear'), value = 'dsilicht_wear' }) -- DSI LICHT
		table.insert(elements, { label = _U('dsimiddel_wear'), value = 'dsimiddel_wear' }) -- DSI MIDDEL
		table.insert(elements, { label = _U('dsizwaar_wear'), value = 'dsizwaar_wear' }) -- DSI ZWAAR 
		table.insert(elements, { label = _U('be_wear'), value = 'be_wear' }) -- BE
		table.insert(elements, { label = _U('casino_wear'), value = 'casino_wear' })
		table.insert(elements, { label = _U('undercover_wear'), value = 'undercover_wear' })
		table.insert(elements, { label = _U('justitie_wear'), value = 'justitie_wear' })
	end



	if Config.EnableNonFreemodePeds then
		table.insert(elements, { label = 'Sheriff wear', value = 'freemode_ped', maleModel = 's_m_y_sheriff_01', femaleModel = 's_f_y_sheriff_01' })
		table.insert(elements, { label = 'Police wear', value = 'freemode_ped', maleModel = 's_m_y_cop_01', femaleModel = 's_f_y_cop_01' })
		table.insert(elements, { label = 'Swat wear', value = 'freemode_ped', maleModel = 's_m_y_swat_01', femaleModel = 's_m_y_swat_01' })
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cloakroom',
		{
			title    = _U('cloakroom'),
			align    = 'top-left',
			elements = elements,
		},
		function(data, menu)

			cleanPlayer(playerPed)

			if data.current.value == 'citizen_wear' then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
					RemoveAllPedWeapons(playerPed, true)
					exports["rp-radio"]:SetRadio(false)
					exports["rp-radio"]:RemovePlayerAccessToFrequencies(1, 2, 3, 4, 5, 7, 10)

					exports.ft_libs:DisableArea("esx_eden_garage_area_police_mecanodeletepoint")
					exports.ft_libs:DisableArea("esx_eden_garage_area_police_mecanospawnpoint")
					exports.ft_libs:DisableArea("esx_eden_garage_area_Bennys_mecanodeletepoint")
					exports.ft_libs:DisableArea("esx_eden_garage_area_Bennys_mecanospawnpoint")

				end)
			end

			if data.current.value == 'aspnhkort_wear' or
				data.current.value == 'casino_wear' or
				data.current.value == 'aot_wear' or
				data.current.value == 'dsilicht_wear' or
				data.current.value == 'dsimiddel_wear' or
				data.current.value == 'dsizwaar_wear' or
				data.current.value == 'aspnhlang_wear' or
				data.current.value == 'officer_wear' or
				data.current.value == 'sergeant_wear' or
				data.current.value == 'holster_tas' or
				data.current.value == 'taser' or
				data.current.value == 'intendent_wear' or
				data.current.value == 'lieutenant_wear' or
				data.current.value == 'chef_wear' or
				data.current.value == 'boss_wear' or
				data.current.value == 'bullet_wear' or
				data.current.value == 'nhkort_wear' or
				data.current.value == 'nhlang_wear' or
				data.current.value == 'gilet_wear' or
				data.current.value == 'pet_wear' or
				data.current.value == 'traffic_wear' or
				data.current.value == 'at_wear' or
				data.current.value == 'atvest_wear' or
				data.current.value == 'lang_wear' or
				data.current.value == 'politievest_wear' or
				data.current.value == 'undercovervest_wear' or
				data.current.value == 'motorunmarked_wear' or
				data.current.value == 'undercoverkort_wear' or
				data.current.value == 'wijkagentvest_wear' or
				data.current.value == 'hondengeleidervest_wear' or
				data.current.value == 'bewakingseenheid_wear' or
				data.current.value == 'ibt_wear' or
				data.current.value == 'vpvest_wear' or
				data.current.value == 'hond_wear1' or
				data.current.value == 'hond_wear2' or
				data.current.value == 'veiligheidshesje_wear' or
				data.current.value == 'motor_wear' or
				data.current.value == 'kogelwerendweg_wear' or
				data.current.value == 'be_wear' or
				data.current.value == 'justitie_wear' or
				data.current.value == 'undercover_wear' or
				data.current.value == 'dsitas'


			then
				setUniform(data.current.value, playerPed)
				exports["rp-radio"]:SetRadio(true)
				exports["rp-radio"]:GivePlayerAccessToFrequencies(1, 2, 3, 7, 10)

				exports.ft_libs:EnableArea("esx_eden_garage_area_police_mecanodeletepoint")
				exports.ft_libs:EnableArea("esx_eden_garage_area_police_mecanospawnpoint")
				exports.ft_libs:EnableArea("esx_eden_garage_area_Bennys_mecanodeletepoint")
				exports.ft_libs:EnableArea("esx_eden_garage_area_Bennys_mecanospawnpoint")


			end

			if data.current.value == 'sheriff_wear_freemode' or
				data.current.value == 'lieutenant_wear_freemode' or
				data.current.value == 'commandant_wear_freemode'
			then
				local model = nil
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					if skin.sex == 0 then
						model = GetHashKey(data.current.maleModel)
					else
						model = GetHashKey(data.current.femaleModel)
					end
				end)

				RequestModel(model)
				while not HasModelLoaded(model) do
					RequestModel(model)
					Citizen.Wait(7)
				end

				SetPlayerModel(PlayerId(), model)
				SetModelAsNoLongerNeeded(model)
			end

			CurrentAction     = 'menu_cloakroom'
			CurrentActionMsg  = _U('open_cloackroom')
			CurrentActionData = {}

		end,
		function(data, menu)
		menu.close()
		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	end
	)
end

function OpenArmoryMenu(station)

	if Config.EnableArmoryManagement then

		local elements = {
			--{label = _U('get_weapon'),     value = 'get_weapon'},
			{ label = _U('put_weapon'), value = 'put_weapon' },
			--{label = _U('remove_object'),  value = 'get_stock'},
			--{label = _U('deposit_object'), value = 'put_stock'}
		}

		if PlayerData.job.name == 'police' then
			table.insert(elements, { label = _U('buy_weapons'), value = 'buy_weapons' })
		end

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'armory',
			{
				title    = _U('armory'),
				align    = 'top-right',
				elements = elements,
			},
			function(data, menu)

				if data.current.value == 'get_weapon' then
					OpenGetWeaponMenu()
				end

				if data.current.value == 'put_weapon' then
					OpenPutWeaponMenu()
				end

				if data.current.value == 'buy_weapons' then
					OpenBuyWeaponsMenu(station)
				end

				if data.current.value == 'put_stock' then
					OpenPutStocksMenu()
				end

				if data.current.value == 'get_stock' then
					OpenGetStocksMenu()
				end

			end,
			function(data, menu)

			menu.close()

			CurrentAction     = 'menu_armory'
			CurrentActionMsg  = _U('open_armory')
			CurrentActionData = { station = station }
		end
		)

	else

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'armory',
			{
				title    = _U('armory'),
				align    = 'top-right',
				elements = elements,
			},
			function(data, menu)
				local weapon = data.current.value
				TriggerServerEvent('esx_policejob:giveWeapon', weapon, 1000, securityToken)
			end,
			function(data, menu)

			menu.close()

			CurrentAction     = 'menu_armory'
			CurrentActionMsg  = _U('open_armory')
			CurrentActionData = { station = station }

		end
		)

	end

end

function OpenKofferbakMenu()

	local playerPed = PlayerPedId()

	local elements = {
		--{ label = _U('reset'), value = 'reset' },
		{ label = "Politie Vest", value = 'politievest_wear' },
		{ label = "Horeca Vest", value = 'traffic_wear' },
		--{ label = "Wijkagent Vest", value = 'wijkagentvest_wear' },
		--{ label = "Hondengeleider Vest", value = 'hondengeleidervest_wear' },
		--{ label = "Undercover Vest", value = 'undercovervest_wear' },
		{ label = "Veiligheids Hesje", value = 'veiligheidshesje_wear' },
		{ label = "OVD Hesje", value = 'gilet_wear' },
		{ label = _U('bullet_wear'), value = 'bullet_wear' },
		{ label = _U('kogelwerendweg_wear'), value = 'kogelwerendweg_wear' },
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cloakroom',
		{
			title    = _U('cloakroom'),
			align    = 'top-right',
			elements = elements,
		},
		function(data, menu)

			cleanPlayer(playerPed)

			if data.current.value == 'citizen_wear' then
				RemoveAllPedWeapons(playerPed, true)
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end

			if -- data.current.value == 'reset' or
			data.current.value == 'politievest_wear' or
				data.current.value == 'traffic_wear' or
				data.current.value == 'wijkagentvest_wear' or
				data.current.value == 'hondengeleidervest_wear' or
				data.current.value == 'undercovervest_wear' or
				data.current.value == 'veiligheidshesje_wear' or
				data.current.value == 'gilet_wear' or
				data.current.value == 'bullet_wear' or
				data.current.value == 'kogelwerendweg_wear'

			then
				RequestAnimDict("clothingshirt")
				TaskPlayAnim(playerPed, "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
				exports['progressBars']:startUI(3100, "Vest aantrekken")
				Wait(3100)
				ClearPedTasks(playerPed)
				setUniform(data.current.value, playerPed)
			end

			if data.current.value == 'sheriff_wear_freemode' or
				data.current.value == 'lieutenant_wear_freemode' or
				data.current.value == 'commandant_wear_freemode'
			then
				local model = nil
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin) -- HELP
					if skin.sex == 0 then
						model = GetHashKey(data.current.maleModel)
					else
						model = GetHashKey(data.current.femaleModel)
					end
				end)

				RequestModel(model)
				while not HasModelLoaded(model) do
					RequestModel(model)
					Citizen.Wait(7)
				end

				SetPlayerModel(PlayerId(), model)
				SetModelAsNoLongerNeeded(model)
			end

			CurrentActionData = {}

		end,
		function(data, menu)
		menu.close()
		CurrentActionData = {}
	end
	)
end

function OpenVehicleSpawnerMenu(station, partNum)

	local vehicles = Config.PoliceStations[station].Vehicles

	ESX.UI.Menu.CloseAll()

	if Config.EnableSocietyOwnedVehicles then

		local elements = {}

		ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(garageVehicles)

			for i = 1, #garageVehicles, 1 do
				table.insert(elements, { label = GetDisplayNameFromVehicleModel(garageVehicles[i].model) .. ' [' .. garageVehicles[i].plate .. ']', value = garageVehicles[i] })
			end

			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'vehicle_spawner',
				{
					title    = _U('vehicle_menu'),
					align    = 'top-left',
					elements = elements,
				},
				function(data, menu)

					menu.close()

					local vehicleProps = data.current.value

					ESX.Game.SpawnVehicle(vehicleProps.model, vehicles[partNum].SpawnPoint, 270.0, function(vehicle)
						ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
						local playerPed = PlayerPedId()
						TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					end)

					TriggerServerEvent('esx_society:removeVehicleFromGarage', 'police', vehicleProps)

				end,
				function(data, menu)

				menu.close()

				CurrentAction     = 'menu_vehicle_spawner'
				CurrentActionMsg  = _U('vehicle_spawner')
				CurrentActionData = { station = station, partNum = partNum }

			end
			)

		end, 'police')

	else

		local elements = {}

		local sharedVehicles = Config.AuthorizedVehicles.Shared
		for i = 1, #sharedVehicles, 1 do
			table.insert(elements, { label = sharedVehicles[i].label, model = sharedVehicles[i].model })
		end

		local authorizedVehicles = Config.AuthorizedVehicles[PlayerData.job.grade_name]
		for i = 1, #authorizedVehicles, 1 do
			table.insert(elements, { label = authorizedVehicles[i].label, model = authorizedVehicles[i].model })
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'vehicle_spawner',
			{
				title    = _U('vehicle_menu'),
				align    = 'top-left',
				elements = elements,
			},
			function(data, menu)

				menu.close()

				local model = data.current.model

				local vehicle = GetClosestVehicle(vehicles[partNum].SpawnPoint.x, vehicles[partNum].SpawnPoint.y, vehicles[partNum].SpawnPoint.z, 3.0, 0, 71)

				if not DoesEntityExist(vehicle) then

					local playerPed = PlayerPedId()

					if Config.MaxInService == -1 then


						
						local playerPed = GetPlayerPed(-1)

						ESX.Game.SpawnVehicle(model, {
							x = vehicles[partNum].SpawnPoint.x,
							y = vehicles[partNum].SpawnPoint.y,
							z = vehicles[partNum].SpawnPoint.z
						}, vehicles[partNum].Heading, function(vehicle)
							TriggerEvent("carradio:disable")
							TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
							SetVehicleMaxMods(vehicle)
							SetVehicleNumberPlateText(vehicle, "POL" .. math.random(1000, 9999))
							exports['rp_Main']:spawnedPersonalVehicle(vehicle)
						end)
						local veh = GetVehiclePedIsIn(playerPed)
						local vehName = GetDisplayNameFromVehicleModel(GetEntityModel(veh))

					else

						ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)

							if canTakeService then

								ESX.Game.SpawnVehicle(model, {
									x = vehicles[partNum].SpawnPoint.x,
									y = vehicles[partNum].SpawnPoint.y,
									z = vehicles[partNum].SpawnPoint.z
								}, vehicles[partNum].Heading, function(vehicle)
									TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
									SetVehicleMaxMods(vehicle)
									SetVehicleNumberPlateText(vehicle, "POL" .. math.random(1000, 9999))
									exports['rp_Main']:spawnedPersonalVehicle(vehicle)
								end)

							else
								ESX.ShowNotification(_U('service_max', inServiceCount, maxInService) .. inServiceCount .. '/' .. maxInService)
							end

						end, 'police')

					end

				else
					ESX.ShowNotification(_U('vehicle_out'))
				end

			end,
			function(data, menu)

			menu.close()

			CurrentAction     = 'menu_vehicle_spawner'
			CurrentActionMsg  = _U('vehicle_spawner')
			CurrentActionData = { station = station, partNum = partNum }

		end
		)

	end

end

function OpenPoliceActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'police_actions',
		{
			title    = 'Politie',
			align    = 'top-right',
			elements = {
				{ label = _U('citizen_interaction'), value = 'citizen_interaction' },
				{ label = _U('vehicle_interaction'), value = 'vehicle_interaction' },
				{ label = _U('object_spawner'), value = 'object_spawner' },
				{ label = 'Gevangenis Menu', value = 'gevangenis' },
			}
		}, function(data, menu)

			if data.current.value == 'gevangenis' then
				TriggerEvent("esx-qalle-jail:openJailMenu")
			end

			if data.current.value == 'citizen_interaction' then
				local elements = {
					{ label = _U('id_card'), value = 'identity_card' },
					{ label = _U('search'), value = 'body_search' },
					{ label = _U('handcuff'), value = 'handcuff' },
					{ label = _U('uncuff'), value = 'uncuff' },
					{ label = _U('drag'), value = 'drag' },
					{ label = _U('put_in_vehicle'), value = 'put_in_vehicle' },
					{ label = _U('out_the_vehicle'), value = 'out_the_vehicle' },
					{ label = _U('fine'), value = 'fine' },
					{ label = "Taakstraf", value = 'communityservice' },
					{ label = 'Onbetaalde boetes', value = 'unpaid_bills' },
					{ label = _U('revive player'), value = 'revive' }
					--{label = 'Strafblad',			value = 'strafblad'}
				}

				if Config.EnableLicenses then
					table.insert(elements, { label = _U('license_check'), value = 'license' })
				end

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'citizen_interaction',
					{
						title    = _U('citizen_interaction'),
						align    = 'top-right',
						elements = elements
					}, function(data2, menu2)
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer ~= -1 and closestDistance <= 3.0 then
							local action = data2.current.value
							if action == 'revive' then
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)
								if health == 0 then
									local playerPed = GetPlayerPed(-1)
									Citizen.CreateThread(function()
										ESX.ShowNotification(_U('revive_inprogress'))
										TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
										exports['progressBars']:startUI(10000, "Persoon reanimeren")
										Wait(10050)
										ClearPedTasks(playerPed)
										if GetEntityHealth(closestPlayerPed) == 0 then
											TriggerServerEvent('esx_policejob:revive', GetPlayerServerId(closestPlayer), securityToken)
											ESX.ShowNotification(_U('revive_complete'))
										else
											ESX.ShowNotification(_U('isdead'))
										end
									end)
								end
							elseif action == 'unpaid_bills' then
								OpenUnpaidBillsMenu(closestPlayer)
							elseif action == 'identity_card' then
								OpenIdentityCardMenu(closestPlayer)
							elseif action == 'body_search' then
								TriggerServerEvent('esx_policejob:message', GetPlayerServerId(closestPlayer), _U('being_searched'))
								OpenBodySearchMenu(closestPlayer)
							elseif action == 'handcuff' then
								TriggerServerEvent('esx_ruski_areszt:startAreszt', GetPlayerServerId(closestPlayer))
								Wait(3000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))
							elseif action == 'uncuff' then
								playerheading = GetEntityHeading(GetPlayerPed(-1))
								playerlocation = GetEntityForwardVector(PlayerPedId())
								playerCoords = GetEntityCoords(GetPlayerPed(-1))
								TriggerServerEvent('esx_policejob:requestrelease', GetPlayerServerId(closestPlayer), playerheading, playerCoords, playerlocation)
								--TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))
							elseif action == 'drag' then
								TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
								Citizen.Wait(800)
								if DragStatus.draganim then
									StopAnimTask(GetPlayerPed(-1), 'switch@trevor@escorted_out', '001215_02_trvs_12_escorted_out_idle_guard2', 1.0)
									DragStatus.draganim = false
								else
									LoadAnimDict('switch@trevor@escorted_out')
									TaskPlayAnim(GetPlayerPed(-1), 'switch@trevor@escorted_out', '001215_02_trvs_12_escorted_out_idle_guard2', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
									DragStatus.draganim = true
								end
								--TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
							elseif action == 'put_in_vehicle' then
								TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
							elseif action == 'out_the_vehicle' then
								TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
							elseif action == 'fine' then
								OpenFineMenu(closestPlayer)
							elseif action == 'unpaid_bills' then
								OpenUnpaidBillsMenu(closestPlayer)
							elseif action == 'license' then
								ShowPlayerLicense(closestPlayer)
							elseif action == 'communityservice' then
								SendToCommunityService(GetPlayerServerId(closestPlayer))
							end

						else
							ESX.ShowNotification(_U('no_players_nearby'))
						end
					end, function(data2, menu2)
					menu2.close()
				end)
			elseif data.current.value == 'vehicle_interaction' then
				local elements  = {}
				local playerPed = PlayerPedId()
				local coords    = GetEntityCoords(playerPed)
				local vehicle   = ESX.Game.GetVehicleInDirection()
				local vehFront  = VehicleInFront()
				local x, y, z   = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
				local closecar  = GetClosestVehicle(x, y, z, 4.0, 0.5, 71)

				if DoesEntityExist(vehicle) then
					table.insert(elements, { label = _U('vehicle_info'), value = 'vehicle_infos' })
					table.insert(elements, { label = _U('pick_lock'), value = 'hijack_vehicle' })
					table.insert(elements, { label = _U('impound'), value = 'impound' })
				end

				table.insert(elements, { label = _U('fine_vehicle_owner'), value = 'fine_vehicle_owner' })
				if vehFront > 0 and closecar ~= nil and GetPedInVehicleSeat(closecar, -1) ~= GetPlayerPed(-1) then
					table.insert(elements, { label = _U('kofferbak'), value = 'kofferbak' })
				end

				table.insert(elements, { label = _U('search_database'), value = 'search_database' })

				table.insert(elements, { label = ('Kenteken Gezocht Melden'), value = 'Gezocht_Melden' })
				table.insert(elements, { label = ('Kenteken Gezocht Weghalen'), value = 'Gezocht_Verwijder' })


				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'vehicle_interaction',
					{
						title    = _U('vehicle_interaction'),
						align    = 'top-right',
						elements = elements
					}, function(data2, menu2)
						coords  = GetEntityCoords(playerPed)
						vehicle = ESX.Game.GetVehicleInDirection()
						action  = data2.current.value

						if action == 'search_database' then
							LookupVehicle()
						elseif action == 'fine_vehicle_owner' then
							FineByVehicle()
						elseif action == 'Gezocht_Melden' then
							TriggerEvent('esx_speedcamera:addkenteken')
						elseif action == 'Gezocht_Verwijder' then
							TriggerEvent('esx_speedcamera:Removekenteken')
						elseif DoesEntityExist(vehicle) then
							local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
							if action == 'vehicle_infos' then
								OpenVehicleInfosMenu(vehicleData)
							elseif action == 'kofferbak' then
								OpenKofferbakMenu()
							elseif action == 'hijack_vehicle' then
								if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
									TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
									Citizen.Wait(20000)
									ClearPedTasksImmediately(playerPed)

									SetVehicleDoorsLocked(vehicle, 1)
									SetVehicleDoorsLockedForAllPlayers(vehicle, false)
									ESX.ShowNotification(_U('vehicle_unlocked'))
								end
							elseif action == 'impound' then

								-- is the script busy?
								if CurrentTask.Busy then
									return
								end

								SetTextComponentFormat('STRING')
								AddTextComponentString(_U('impound_prompt'))
								DisplayHelpTextFromStringLabel(0, 0, 1, -1)

								TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

								CurrentTask.Busy = true
								CurrentTask.Task = ESX.SetTimeout(10000, function()
									ClearPedTasks(playerPed)
									ImpoundVehicle(vehicle)
									Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
								end)

								-- keep track of that vehicle!
								Citizen.CreateThread(function()
									while CurrentTask.Busy do
										Citizen.Wait(1000)

										vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
										if not DoesEntityExist(vehicle) and CurrentTask.Busy then
											ESX.ShowNotification(_U('impound_canceled_moved'))
											ESX.ClearTimeout(CurrentTask.Task)
											ClearPedTasks(playerPed)
											DeleteVehicle(vehicle)
											CurrentTask.Busy = false
											break
										end
									end
								end)
							end
						else
							ESX.ShowNotification(_U('no_vehicles_nearby'))
						end

					end, function(data2, menu2)
					menu2.close()
				end)

			elseif data.current.value == 'object_spawner' then
				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'citizen_interaction',
					{
						title = _U('traffic_interaction'),
						align = 'top-right',
						elements = {
							{ label = _U('cone'), value = 'prop_mp_cone_01' },
							{ label = _U('barrier'), value = 'prop_barrier_work06a' },
							{ label = 'Tent', value = 'prop_gazebo_02' },
							{ label = 'Lint', value = 'oes_politielint' }


						}
					}, function(data2, menu2)
						local model = data2.current.value
						local playerPed = GetPlayerPed(-1)
						local coords = GetEntityCoords(playerPed)
						local forward = GetEntityForwardVector(playerPed)
						local x, y, z = table.unpack(coords + forward * 1.0)

						-- if model == 'prop_roadcone02a' then
						-- 	z = z - 2.0
						-- end
						ESX.Game.SpawnObject(model, {
							x = x,
							y = y,
							z = z
						}, function(obj)
							SetEntityHeading(obj, GetEntityHeading(playerPed))
							PlaceObjectOnGroundProperly(obj)
							FreezeEntityPosition(obj, false)
						end)

					end, function(data2, menu2)
					menu2.close()
				end)
			end

		end, function(data, menu)
		menu.close()
	end)
end

function LoadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(10)
	end
end

function OpenUnpaidBillsMenu(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_billing:getTargetBills', function(bills)
		for k, bill in ipairs(bills) do
			table.insert(elements, {
				label = ('%s - <span style="color:red;">%s</span>'):format(bill.label, _U('armory_item', ESX.Math.GroupDigits(bill.amount))),
				billId = bill.id
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing', {
			title    = _U('unpaid_bills'),
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function SendToCommunityService(player)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Community Service Menu', {
		title = "Community Service Menu",
	}, function(data2, menu)
		local community_services_count = tonumber(data2.value)

		if community_services_count == nil then
			ESX.ShowNotification('Invalid services count.')
		else
			TriggerServerEvent("esx_communityservice:sendToCommunityService", player, community_services_count)
			menu.close()
		end
	end, function(data2, menu)
		menu.close()
	end)
end

function VehicleInFront()
	local pos = GetEntityCoords(GetPlayerPed(-1))
	local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
	local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, result = GetRaycastResult(rayHandle)
	return result
end

function OpenIdentityCardMenu(player)
	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
		local elements = {
			{ label = _U('name', data.name) },
			{ label = _U('job', ('%s - %s'):format(data.job, data.grade)) }
		}

		if Config.EnableESXIdentity then
			table.insert(elements, { label = _U('sex', _U(data.sex)) })
			table.insert(elements, { label = _U('dob', data.dob) })
			table.insert(elements, { label = _U('height', data.height) })
		end

		if data.drunk then
			table.insert(elements, { label = _U('bac', data.drunk) })
		end

		if data.licenses then
			table.insert(elements, { label = _U('license_label') })

			for i = 1, #data.licenses, 1 do
				table.insert(elements, { label = data.licenses[i].label })
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
			title    = _U('citizen_interaction'),
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenBodySearchMenu(player)
	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
		local elements = {}

		for i = 1, #data.accounts, 1 do
			if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
				table.insert(elements, {
					label    = _U('confiscate_dirty', ESX.Math.Round(data.accounts[i].money)),
					value    = 'black_money',
					itemType = 'item_account',
					amount   = data.accounts[i].money
				})

				break
			end
		end

		table.insert(elements, { label = _U('guns_label') })

		for i = 1, #data.weapons, 1 do
			table.insert(elements, {
				label    = _U('confiscate_weapon', ESX.GetWeaponLabel(data.weapons[i].name), data.weapons[i].ammo),
				value    = data.weapons[i].name,
				itemType = 'item_weapon',
				amount   = data.weapons[i].ammo
			})
		end

		table.insert(elements, { label = _U('inventory_label') })

		for i = 1, #data.inventory, 1 do
			if data.inventory[i].count > 0 then
				table.insert(elements, {
					label    = _U('confiscate_inv', data.inventory[i].count, data.inventory[i].label),
					value    = data.inventory[i].name,
					itemType = 'item_standard',
					amount   = data.inventory[i].count
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search', {
			title    = _U('search'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			if data.current.value then
				TriggerServerEvent('esx_policejob:confiscatePlayerItem', GetPlayerServerId(player), data.current.itemType, data.current.value, data.current.amount)
				OpenBodySearchMenu(player)
			end
		end, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function FineByVehicle()
	local kenteken = nil
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'fineby_vehicle',
		{
			title = _U('fine_database_title'),
		}, function(data, menu)
			local length = string.len(data.value)
			if data.value == nil or length < 2 or length > 13 then
				ESX.ShowNotification(_U('fine_database_error_invalid'))
			else
				local kenteken = data.value
				ESX.TriggerServerCallback('esx_policejob:fineCarOwner', function(state)
					local resState, resText, resId = table.unpack(state)
					if state then

						menu.close()
						ESX.TriggerServerCallback('esx_policejob:getFineList', function(fines)

							local elements = {}

							for i = 1, #fines, 1 do
								table.insert(elements, {
									label     = fines[i].label .. ' <span style="color: green;">€' .. fines[i].amount .. '</span>',
									value     = fines[i].id,
									amount    = fines[i].amount,
									fineLabel = fines[i].label
								})
							end

							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category',
								{
									title    = _U('fine'),
									align    = 'top-right',
									elements = elements,
								}, function(data2, menu2)

									local label  = data2.current.fineLabel
									local amount = data2.current.amount
									local player = GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1)))

									TriggerServerEvent('esx_billing:sendBill', resId, 'society_police', _U('fine_total_plate', string.upper(kenteken), label), amount)

									ESX.SetTimeout(300, function()
										ESX.UI.Menu.CloseAll()
									end)

								end, function(data2, menu2)
								menu2.close()
							end)

						end, 0)
					else
						ESX.ShowNotification('Dit kenteken bestaat niet!')
					end
				end, kenteken)
			end
		end, function(data, menu)
		menu.close()
	end)
end

function OpenFineMenu(player)


	local elements = {
		{ label = _U('traffic_offense'), value = 0 },
		{ label = _U('minor_offense'), value = 1 },
		{ label = _U('average_offense'), value = 2 },
		{ label = _U('major_offense'), value = 3 },
	}

	if PlayerData.job.name == 'police' and PlayerData.job.grade_name == 'boss' or PlayerData.job.grade_name == 'inspecteur' or PlayerData.job.grade_name == 'hoofdinspecteur' then
		table.insert(elements, { label = ('Inbeslagname'), value = 'inbeslagname' })
	end

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'fine',
		{
			title    = _U('fine'),
			align    = 'top-left',
			elements = elements,
		},
		function(data, menu)

			if data.current.value == 'inbeslagname' then
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
					title = ('Boete Hoeveelheid')
				}, function(data, menu)
					local amount = tonumber(data.value)

					if amount == nil or amount < 0 then
						ESX.ShowNotification('Ongeldige hoeveelheid')
					else
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer == -1 or closestDistance > 3.0 then
							ESX.ShowNotification('Geen Spelers Dichtbij')
							menu.close()
						else
							menu.close()
							TriggerServerEvent('esx_billing:buutgeven', GetPlayerServerId(player), 'society_police', 'Inbeslagname Voertuig', amount)
							--TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', _U('mechanic'), amount)
						end
					end
				end, function(data, menu)
					menu.close()
				end)
			else
				OpenFineCategoryMenu(player, data.current.value)
			end

		end,
		function(data, menu)
		menu.close()
	end
	)

end

function OpenFineCategoryMenu(player, category)

	ESX.TriggerServerCallback('esx_policejob:getFineList', function(fines)

		local elements = {}

		for i = 1, #fines, 1 do
			table.insert(elements, {
				label     = fines[i].label .. ' <span style="color: green;">$' .. fines[i].amount .. '</span>',
				value     = fines[i].id,
				amount    = fines[i].amount,
				fineLabel = fines[i].label
			})
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'fine_category',
			{
				title    = _U('fine'),
				align    = 'top-left',
				elements = elements,
			},
			function(data, menu)

				local label  = data.current.fineLabel
				local amount = data.current.amount

				menu.close()

				if Config.EnablePlayerManagement then
					TriggerServerEvent('esx_billing:buutgeven', GetPlayerServerId(player), 'society_police', _U('fine_total', label), amount)
				else
					TriggerServerEvent('esx_billing:buutgeven', GetPlayerServerId(player), '', _U('fine_total', label), amount)
				end

				ESX.SetTimeout(300, function()
					OpenFineCategoryMenu(player, category)
				end)

			end,
			function(data, menu)
			menu.close()
		end
		)

	end, category)

end

function LookupVehicle()
	ESX.UI.Menu.Open(
		'dialog', GetCurrentResourceName(), 'lookup_vehicle',
		{
			title = _U('search_database_title'),
		}, function(data, menu)
			local length = string.len(data.value)
			if data.value == nil or length < 3 or length > 13 then
				ESX.ShowNotification(_U('search_database_error_invalid'))
			else
				ESX.TriggerServerCallback('esx_policejob:getVehicleFromPlate', function(owner, found)
					if found then
						ESX.ShowNotification(_U('search_database_found', owner))
					else
						ESX.ShowNotification(_U('search_database_error_not_found'))
					end
				end, data.value)
				menu.close()
			end
		end, function(data, menu)
		menu.close()
	end
	)
end

function OpenUnpaidBillsMenu(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_billing:getTargetBills', function(bills)
		for i = 1, #bills, 1 do
			table.insert(elements, { label = bills[i].label .. ' - <span style="color: red;">$' .. bills[i].amount .. '</span>', value = bills[i].id })
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing',
			{
				title    = _U('unpaid_bills'),
				align    = 'bottom-right',
				elements = elements
			}, function(data, menu)

			end, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function ShowPlayerLicense(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(playerData)
		if playerData.licenses then
			for i = 1, #playerData.licenses, 1 do
				if playerData.licenses[i].label and playerData.licenses[i].type then
					table.insert(elements, {
						label = playerData.licenses[i].label,
						type = playerData.licenses[i].type
					})
				end
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license', {
			title    = _U('license_revoke'),
			align    = 'top-left',
			elements = elements,
		}, function(data, menu)
			ESX.ShowNotification(_U('licence_you_revoked', data.current.label, playerData.name))
			TriggerServerEvent('esx_policejob:message', GetPlayerServerId(player), _U('license_revoked', data.current.label))

			TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), data.current.type)

			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))
end

function OpenVehicleInfosMenu(vehicleData)

	ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(infos)

		local elements = {}

		table.insert(elements, { label = _U('plate', infos.plate), value = nil })

		if infos.owner == nil then
			table.insert(elements, { label = _U('owner_unknown'), value = nil })
		else
			table.insert(elements, { label = _U('owner', infos.owner), value = nil })
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'vehicle_infos',
			{
				title    = _U('vehicle_info'),
				align    = 'top-left',
				elements = elements,
			},
			nil,
			function(data, menu)
			menu.close()
		end
		)

	end, vehicleData.plate)

end

function OpenGetWeaponMenu()

	ESX.TriggerServerCallback('esx_policejob:getArmoryWeapons', function(weapons)

		local elements = {}

		for i = 1, #weapons, 1 do
			if weapons[i].count > 0 then
				table.insert(elements, {
					label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name),
					value = weapons[i].name
				})
			end
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'armory_get_weapon',
			{
				title    = _U('get_weapon_menu'),
				align    = 'top-left',
				elements = elements,
			},
			function(data, menu)

				menu.close()

				ESX.TriggerServerCallback('esx_policejob:removeArmoryWeapon', function()
					OpenGetWeaponMenu()
				end, data.current.value)

			end,
			function(data, menu)
			menu.close()
		end
		)

	end)

end

function OpenPutWeaponMenu()

	local elements   = {}
	local playerPed  = PlayerPedId()
	local weaponList = ESX.GetWeaponList()

	for i = 1, #weaponList, 1 do

		local weaponHash = GetHashKey(weaponList[i].name)

		if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			--local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
			table.insert(elements, { label = weaponList[i].label, value = weaponList[i].name })
		end

	end

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'armory_put_weapon',
		{
			title    = _U('put_weapon_menu'),
			align    = 'top-left',
			elements = elements,
		},
		function(data, menu)

			menu.close()

			ESX.TriggerServerCallback('esx_policejob:addArmoryWeapon', function()
				OpenPutWeaponMenu()
			end, data.current.value, true)

		end,
		function(data, menu)
		menu.close()
	end
	)

end

function OpenBuyWeaponsMenu()

	local elements = {}
	local playerPed = PlayerPedId()
	PlayerData = ESX.GetPlayerData()

	for k, v in ipairs(Config.AuthorizedWeapons[PlayerData.job.grade_name]) do
		local weaponNum, weapon = ESX.GetWeapon(v.weapon)
		local components, label = {}

		local hasWeapon = HasPedGotWeapon(playerPed, GetHashKey(v.weapon), false)

		if v.components then
			for i = 1, #v.components do
				if v.components[i] then

					local component = weapon.components[i]
					local hasComponent = HasPedGotWeaponComponent(playerPed, GetHashKey(v.weapon), component.hash)

					if hasComponent then
						label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('armory_owned'))
					else
						if v.components[i] > 0 then
							label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('armory_item', ESX.Math.GroupDigits(v.components[i])))
						else
							label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('armory_free'))
						end
					end

					table.insert(components, {
						label = label,
						componentLabel = component.label,
						hash = component.hash,
						name = component.name,
						price = v.components[i],
						hasComponent = hasComponent,
						componentNum = i
					})
				end
			end
		end

		if hasWeapon and v.components then
			label = ('%s: <span style="color:green;">></span>'):format(weapon.label)
		elseif hasWeapon and not v.components then
			label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_owned'))
		else
			if v.price > 0 then
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_item', ESX.Math.GroupDigits(v.price)))
			else
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_free'))
			end
		end

		table.insert(elements, {
			label = label,
			weaponLabel = weapon.label,
			name = weapon.name,
			components = components,
			price = v.price,
			hasWeapon = hasWeapon
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons', {
		title    = _U('armory_weapontitle'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)

		if data.current.hasWeapon then
			if #data.current.components > 0 then
				OpenWeaponComponentShop(data.current.components, data.current.name, menu)
			end
		else
			ESX.TriggerServerCallback('esx_policejob:buyWeapon', function(bought)
				if bought then
					if data.current.price > 0 then
						ESX.ShowNotification(_U('armory_bought', data.current.weaponLabel, ESX.Math.GroupDigits(data.current.price)))
					end

					menu.close()

					OpenBuyWeaponsMenu()
				else
					ESX.ShowNotification(_U('armory_money'))
				end
			end, data.current.name, 1)
		end

	end, function(data, menu)
		menu.close()
	end)

end

function OpenWeaponComponentShop(components, weaponName, parentShop)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons_components', {
		title    = _U('armory_componenttitle'),
		align    = 'top-right',
		elements = components
	}, function(data, menu)

		if data.current.hasComponent then
			ESX.ShowNotification(_U('armory_hascomponent'))
		else
			ESX.TriggerServerCallback('esx_policejob:buyWeapon', function(bought)
				if bought then
					if data.current.price > 0 then
						ESX.ShowNotification(_U('armory_bought', data.current.componentLabel, ESX.Math.GroupDigits(data.current.price)))
					end

					menu.close()
					parentShop.close()

					OpenBuyWeaponsMenu()
				else
					ESX.ShowNotification(_U('armory_money'))
				end
			end, weaponName, 2, data.current.componentNum)
		end

	end, function(data, menu)
		menu.close()
	end)
end

function OpenGetStocksMenu()

	ESX.TriggerServerCallback('esx_policejob:getStockItems', function(items)


		local elements = {}

		for i = 1, #items, 1 do
			table.insert(elements, { label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name })
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'stocks_menu',
			{
				title    = _U('police_stock'),
				elements = elements
			},
			function(data, menu)

				local itemName = data.current.value

				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
					{
						title = _U('quantity')
					},
					function(data2, menu2)

						local count = tonumber(data2.value)

						if count == nil then
							ESX.ShowNotification(_U('quantity_invalid'))
						else
							menu2.close()
							menu.close()
							OpenGetStocksMenu()

							TriggerServerEvent('esx_policejob:getStockItem', itemName, count)
						end

					end,
					function(data2, menu2)
					menu2.close()
				end
				)

			end,
			function(data, menu)
			menu.close()
		end
		)

	end)

end

function OpenPutStocksMenu()

	ESX.TriggerServerCallback('esx_policejob:getPlayerInventory', function(inventory)

		local elements = {}

		for i = 1, #inventory.items, 1 do

			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, { label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name })
			end

		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'stocks_menu',
			{
				title    = _U('inventory'),
				elements = elements
			},
			function(data, menu)

				local itemName = data.current.value

				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
					{
						title = _U('quantity')
					},
					function(data2, menu2)

						local count = tonumber(data2.value)

						if count == nil then
							ESX.ShowNotification(_U('quantity_invalid'))
						else
							menu2.close()
							menu.close()
							OpenPutStocksMenu()

							TriggerServerEvent('esx_policejob:putStockItems', itemName, count)
						end

					end,
					function(data2, menu2)
					menu2.close()
				end
				)

			end,
			function(data, menu)
			menu.close()
		end
		)

	end)

end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job

	Citizen.Wait(5000)
	TriggerServerEvent('esx_policejob:forceBlip')
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)

	local specialContact = {
		name       = 'Police',
		number     = 'police',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDFGQTJDRkI0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDFGQTJDRkM0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0MUZBMkNGOTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MUZBMkNGQTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PoW66EYAAAjGSURBVHjapJcLcFTVGcd/u3cfSXaTLEk2j80TCI8ECI9ABCyoiBqhBVQqVG2ppVKBQqUVgUl5OU7HKqNOHUHU0oHamZZWoGkVS6cWAR2JPJuAQBPy2ISEvLN57+v2u2E33e4k6Ngz85+9d++95/zP9/h/39GpqsqiRYsIGz8QZAq28/8PRfC+4HT4fMXFxeiH+GC54NeCbYLLATLpYe/ECx4VnBTsF0wWhM6lXY8VbBE0Ch4IzLcpfDFD2P1TgrdC7nMCZLRxQ9AkiAkQCn77DcH3BC2COoFRkCSIG2JzLwqiQi0RSmCD4JXbmNKh0+kc/X19tLtc9Ll9sk9ZS1yoU71YIk3xsbEx8QaDEc2ttxmaJSKC1ggSKBK8MKwTFQVXRzs3WzpJGjmZgvxcMpMtWIwqsjztvSrlzjYul56jp+46qSmJmMwR+P3+4aZ8TtCprRkk0DvUW7JjmV6lsqoKW/pU1q9YQOE4Nxkx4ladE7zd8ivuVmJQfXZKW5dx5EwPRw4fxNx2g5SUVLw+33AkzoRaQDP9SkFu6OKqz0uF8yaz7vsOL6ycQVLkcSg/BlWNsjuFoKE1knqDSl5aNnmPLmThrE0UvXqQqvJPyMrMGorEHwQfEha57/3P7mXS684GFjy8kreLppPUuBXfyd/ibeoS2kb0mWPANhJdYjb61AxUvx5PdT3+4y+Tb3mTd19ZSebE+VTXVGNQlHAC7w4VhH8TbA36vKq6ilnzlvPSunHw6Trc7XpZ14AyfgYeyz18crGN1Alz6e3qwNNQSv4dZox1h/BW9+O7eIaEsVv41Y4XeHJDG83Nl4mLTwzGhJYtx0PzNTjOB9KMTlc7Nkcem39YAGU7cbeBKVLMPGMVf296nMd2VbBq1wmizHoqqm/wrS1/Zf0+N19YN2PIu1fcIda4Vk66Zx/rVi+jo9eIX9wZGGcFXUMR6BHUa76/2ezioYcXMtpyAl91DSaTfDxlJbtLprHm2ecpObqPuTPzSNV9yKz4a4zJSuLo71/j8Q17ON69EmXiPIlNMe6FoyzOqWPW/MU03Lw5EFcyKghTrNDh7+/vw545mcJcWbTiGKpRdGPMXbx90sGmDaux6sXk+kimjU+BjnMkx3kYP34cXrFuZ+3nrHi6iDMt92JITcPjk3R3naRwZhpuNSqoD93DKaFVU7j2dhcF8+YzNlpErbIBTVh8toVccbaysPB+4pMcuPw25kwSsau7BIlmHpy3guaOPtISYyi/UkaJM5Lpc5agq5Xkcl6gIHkmqaMn0dtylcjIyPThCNyhaXyfR2W0I1our0v6qBii07ih5rDtGSOxNVdk1y4R2SR8jR/g7hQD9l1jUeY/WLJB5m39AlZN4GZyIQ1fFJNsEgt0duBIc5GRkcZF53mNwIzhXPDgQPoZIkiMkbTxtstDMVnmFA4cOsbz2/aKjSQjev4Mp9ZAg+hIpFhB3EH5Yal16+X+Kq3dGfxkzRY+KauBjBzREvGN0kNCTARu94AejBLMHorAQ7cEQMGs2cXvkWshYLDi6e9l728O8P1XW6hKeB2yv42q18tjj+iFTGoSi+X9jJM9RTxS9E+OHT0krhNiZqlbqraoT7RAU5bBGrEknEBhgJks7KXbLS8qERI0ErVqF/Y4K6NHZfLZB+/wzJvncacvFd91oXO3o/O40MfZKJOKu/rne+mRQByXM4lYreb1tUnkizVVA/0SpfpbWaCNBeEE5gb/UH19NLqEgDF+oNDQWcn41Cj0EXFEWqzkOIyYekslFkThsvMxpIyE2hIc6lXGZ6cPyK7Nnk5OipixRdxgUESAYmhq68VsGgy5CYKCUAJTg0+izApXne3CJFmUTwg4L3FProFxU+6krqmXu3MskkhSD2av41jLdzlnfFrSdCZxyqfMnppN6ZUa7pwt0h3fiK9DCt4IO9e7YqisvI7VYgmNv7mhBKKD/9psNi5dOMv5ZjukjsLdr0ffWsyTi6eSlfcA+dmiVyOXs+/sHNZu3M6PdxzgVO9GmDSHsSNqmTz/R6y6Xxqma4fwaS5Mn85n1ZE0Vl3CHBER3lUNEhiURpPJRFdTOcVnpUJnPIhR7cZXfoH5UYc5+E4RzRH3sfSnl9m2dSMjE+Tz9msse+o5dr7UwcQ5T3HwlWUkNuzG3dKFSTbsNs7m/Y8vExOlC29UWkMJlAxKoRQMR3IC7x85zOn6fHS50+U/2Untx2R1voinu5no+DQmz7yPXmMKZnsu0wrm0Oe3YhOVHdm8A09dBQYhTv4T7C+xUPrZh8Qn2MMr4qcDSRfoirWgKAvtgOpv1JI8Zi77X15G7L+fxeOUOiUFxZiULD5fSlNzNM62W+k1yq5gjajGX/ZHvOIyxd+Fkj+P092rWP/si0Qr7VisMaEWuCiYonXFwbAUTWWPYLV245NITnGkUXnpI9butLJn2y6iba+hlp7C09qBcvoN7FYL9mhxo1/y/LoEXK8Pv6qIC8WbBY/xr9YlPLf9dZT+OqKTUwfmDBm/GOw7ws4FWpuUP2gJEZvKqmocuXPZuWYJMzKuSsH+SNwh3bo0p6hao6HeEqwYEZ2M6aKWd3PwTCy7du/D0F1DsmzE6/WGLr5LsDF4LggnYBacCOboQLHQ3FFfR58SR+HCR1iQH8ukhA5s5o5AYZMwUqOp74nl8xvRHDlRTsnxYpJsUjtsceHt2C8Fm0MPJrphTkZvBc4It9RKLOFx91Pf0Igu0k7W2MmkOewS2QYJUJVWVz9VNbXUVVwkyuAmKTFJayrDo/4Jwe/CT0aGYTrWVYEeUfsgXssMRcpyenraQJa0VX9O3ZU+Ma1fax4xGxUsUVFkOUbcama1hf+7+LmA9juHWshwmwOE1iMmCFYEzg1jtIm1BaxW6wCGGoFdewPfvyE4ertTiv4rHC73B855dwp2a23bbd4tC1hvhOCbX7b4VyUQKhxrtSOaYKngasizvwi0RmOS4O1QZf2yYfiaR+73AvhTQEVf+rpn9/8IMAChKDrDzfsdIQAAAABJRU5ErkJggg=='
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)

end)

AddEventHandler('esx_policejob:hasEnteredMarker', function(station, part, partNum)

	if part == 'Cloakroom' then
		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	end


	if part == 'Armory' then
		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = _U('open_armory')
		CurrentActionData = { station = station }
	end

	if part == 'VehicleSpawner' then
		CurrentAction     = 'menu_vehicle_spawner'
		CurrentActionMsg  = _U('vehicle_spawner')
		CurrentActionData = { station = station, partNum = partNum }
	end

	if part == 'VehicleDeleter' then

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then

			local vehicle = GetVehiclePedIsIn(playerPed, false)

			if DoesEntityExist(vehicle) then
				CurrentAction     = 'delete_vehicle'
				CurrentActionMsg  = _U('store_vehicle')
				CurrentActionData = { vehicle = vehicle }
			end

		end

	end

	if part == 'BossActions' then
		CurrentAction     = 'menu_boss_actions'
		CurrentActionMsg  = _U('open_bossmenu')
		CurrentActionData = {}
	end

end)

AddEventHandler('esx_policejob:hasExitedMarker', function(station, part, partNum)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

AddEventHandler('esx_policejob:hasEnteredEntityZone', function(entity)

	local playerPed = PlayerPedId()

	if PlayerData.job ~= nil and PlayerData.job.name == 'police' and not IsPedInAnyVehicle(playerPed, false) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('remove_prop')
		CurrentActionData = { entity = entity }
	end

	if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then

			local vehicle = GetVehiclePedIsIn(playerPed)

			for i = 0, 7, 1 do
				SetVehicleTyreBurst(vehicle, i, true, 1000)
			end

		end

	end

end)

AddEventHandler('esx_policejob:hasExitedEntityZone', function(entity)

	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end

end)

RegisterNetEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function()
	IsHandcuffed    = not IsHandcuffed
	local playerPed = PlayerPedId()

	--[[ Citizen.CreateThread(function()
		if IsHandcuffed then

			RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(100)
			end

			TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, 'Cuff', 0.1)
			TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)
			FreezeEntityPosition(playerPed, false)

			if Config.EnableHandcuffTimer then
				if HandcuffTimer then
					ESX.ClearTimeout(HandcuffTimer)
				end

				if GetEntityModel(playerPed) == femaleHash then -- mp female
					prevFemaleVariation = GetPedDrawableVariation(playerPed, 7)
					SetPedComponentVariation(playerPed, 7, 25, 0, 0)

				elseif GetEntityModel(playerPed) == maleHash then -- mp male
					prevMaleVariation = GetPedDrawableVariation(playerPed, 7)
					SetPedComponentVariation(playerPed, 7, 41, 0, 0)
				end

				StartHandcuffTimer()
			end

		else

			if Config.EnableHandcuffTimer and HandcuffTimer then
				ESX.ClearTimeout(HandcuffTimer)
			end

			if GetEntityModel(playerPed) == femaleHash then -- mp female
				SetPedComponentVariation(playerPed, 7, prevFemaleVariation, 0, 0)
			elseif GetEntityModel(playerPed) == maleHash then -- mp male
				SetPedComponentVariation(playerPed, 7, prevMaleVariation, 0, 0)
			end

			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			FreezeEntityPosition(playerPed, false)
		end
	end)
 ]]
end)

AddEventHandler('esx_policejob:unrestrain', function()
	if IsHandcuffed then
		local playerPed = PlayerPedId()
		IsHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
	end
end)

RegisterNetEvent('esx_policejob:douncuffing')
AddEventHandler('esx_policejob:douncuffing', function()
	Citizen.Wait(250)
	LoadAnimDict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'a_uncuff', 8.0, -8, -1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('esx_policejob:getuncuffed')
AddEventHandler('esx_policejob:getuncuffed', function(playerheading, playercoords, playerlocation)

	local playerPed = PlayerPedId()

	local x, y, z = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	LoadAnimDict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'b_uncuff', 8.0, -8, -1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	IsHandcuffed = false
	IsShackles = false
	--	  TriggerEvent('esx_policejob:handcuff')
	ClearPedTasks(playerPed)

end)




RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(copID)
	if not IsHandcuffed then
		return
	end

	DragStatus.IsDragged = not DragStatus.IsDragged
	DragStatus.CopId     = tonumber(copID)

end)


Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do
		Citizen.Wait(1)

		if IsHandcuffed then
			playerPed = PlayerPedId()

			if DragStatus.IsDragged then

				targetPed = GetPlayerPed(GetPlayerFromServerId(DragStatus.CopId))

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, -0.06, 0.65, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

				if IsPedDeadOrDying(targetPed, true) then
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

			else
				DetachEntity(playerPed, true, false)
			end
		else
			Citizen.Wait(500)
		end
	end
end)


RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function()

	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

		local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then

			local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
			local freeSeat = nil

			for i = maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat ~= nil then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
			end

		end

	end

end)

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function(t)
	local ped = GetPlayerPed(t)
	ClearPedTasksImmediately(ped)
	plyPos = GetEntityCoords(PlayerPedId(), true)
	local xnew = plyPos.x + 2
	local ynew = plyPos.y + 2

	SetEntityCoords(PlayerPedId(), xnew, ynew, plyPos.z)
end)

-- Handcuff
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if IsHandcuffed then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288, true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true) -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true) -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Create blips
Citizen.CreateThread(function()

	for k, v in pairs(Config.PoliceStations) do
		local blip = AddBlipForCoord(v.Blip.Coords)

		SetBlipSprite(blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale(blip, v.Blip.Scale)
		SetBlipColour(blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('map_blip'))
		EndTextCommandSetBlipName(blip)
	end

end)

-- Create blips
Citizen.CreateThread(function()

	for k, v in pairs(Config.PoliceStations) do
		local blip2 = AddBlipForCoord(v.Blip2.Coords)

		SetBlipSprite(blip2, v.Blip2.Sprite)
		SetBlipDisplay(blip2, v.Blip2.Display)
		SetBlipScale(blip2, v.Blip2.Scale)
		SetBlipColour(blip2, v.Blip2.Colour)
		SetBlipAsShortRange(blip2, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('map_blip'))
		EndTextCommandSetBlipName(blip2)
	end

end)

-- Create blips
Citizen.CreateThread(function()

	for k, v in pairs(Config.PoliceStations) do
		local blip1 = AddBlipForCoord(v.blip1.Coords)

		SetBlipSprite(blip1, v.blip1.Sprite)
		SetBlipDisplay(blip1, v.blip1.Display)
		SetBlipScale(blip1, v.blip1.Scale)
		SetBlipColour(blip1, v.blip1.Colour)
		SetBlipAsShortRange(blip1, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('map_blip'))
		EndTextCommandSetBlipName(blip1)
	end

end)

-- Display markers
Citizen.CreateThread(function()
	while true do

		sleep = 1500

		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			sleep           = 5
			isPolitie       = true
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)

			for k, v in pairs(Config.PoliceStations) do

				for i = 1, #v.Cloakrooms, 1 do
					if GetDistanceBetweenCoords(coords, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, true) < Config.DrawDistance then
						DrawMarker(20, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
					end
				end

				for i = 1, #v.Armories, 1 do
					if GetDistanceBetweenCoords(coords, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, true) < Config.DrawDistance then
						DrawMarker(21, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
					end
				end

				for i = 1, #v.Vehicles, 1 do
					if GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, true) < Config.DrawDistance then
						DrawMarker(36, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
					end
				end

				for i = 1, #v.VehicleDeleters, 1 do
					if GetDistanceBetweenCoords(coords, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, true) < Config.DrawDistance then
						DrawMarker(Config.MarkerType, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
					end
				end

				if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.grade_name == 'boss' then

					for i = 1, #v.BossActions, 1 do
						if GetDistanceBetweenCoords(coords, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, true) < Config.DrawDistance then
							DrawMarker(22, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
						end
					end

				end

			end

		end
		Citizen.Wait(sleep)
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()

	while true do

		sleep = 1500

		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			sleep                = 5
			local playerPed      = PlayerPedId()
			local coords         = GetEntityCoords(playerPed)
			local isInMarker     = false
			local currentStation = nil
			local currentPart    = nil
			local currentPartNum = nil

			for k, v in pairs(Config.PoliceStations) do

				for i = 1, #v.Cloakrooms, 1 do
					if GetDistanceBetweenCoords(coords, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, true) < Config.MarkerSize.x then
						isInMarker     = true
						currentStation = k
						currentPart    = 'Cloakroom'
						currentPartNum = i
					end
				end



				for i = 1, #v.Armories, 1 do
					if GetDistanceBetweenCoords(coords, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, true) < Config.MarkerSize.x then
						isInMarker     = true
						currentStation = k
						currentPart    = 'Armory'
						currentPartNum = i
					end
				end

				for i = 1, #v.Vehicles, 1 do

					if GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, true) < Config.MarkerSize.x then
						isInMarker     = true
						currentStation = k
						currentPart    = 'VehicleSpawner'
						currentPartNum = i
					end

					if GetDistanceBetweenCoords(coords, v.Vehicles[i].SpawnPoint.x, v.Vehicles[i].SpawnPoint.y, v.Vehicles[i].SpawnPoint.z, true) < Config.MarkerSize.x then
						isInMarker     = true
						currentStation = k
						currentPart    = 'VehicleSpawnPoint'
						currentPartNum = i
					end

				end

				for i = 1, #v.VehicleDeleters, 1 do
					if GetDistanceBetweenCoords(coords, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, true) < Config.MarkerSize.x then
						isInMarker     = true
						currentStation = k
						currentPart    = 'VehicleDeleter'
						currentPartNum = i
					end
				end

				if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.grade_name == 'boss' then

					for i = 1, #v.BossActions, 1 do
						if GetDistanceBetweenCoords(coords, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, true) < Config.MarkerSize.x then
							isInMarker     = true
							currentStation = k
							currentPart    = 'BossActions'
							currentPartNum = i
						end
					end

				end

			end

			local hasExited = false

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then

				if (LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
					(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('esx_policejob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then

				HasAlreadyEnteredMarker = false

				TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
			end

		end
		Citizen.Wait(sleep)
	end
end)


--Props verwijderen
Citizen.CreateThread(function()

	local trackedEntities = {
		'prop_mp_cone_01',
		'prop_barrier_work06a',
		'prop_gazebo_02',
		'oes_politielint',
	}

	while true do
		sleep = 1500

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i = 1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance  = GetDistanceBetweenCoords(coords, objCoords, true)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('esx_policejob:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity then
				TriggerEvent('esx_policejob:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
		Citizen.Wait(sleep)
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(7)

		if CurrentAction ~= nil then
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'police' then

				if CurrentAction == 'menu_cloakroom' then
					OpenCloakroomMenu()
				elseif CurrentAction == 'menu_armory' then
					OpenArmoryMenu(CurrentActionData.station)
				elseif CurrentAction == 'menu_vehicle_spawner' then
					OpenVehicleSpawnerMenu(CurrentActionData.station, CurrentActionData.partNum)
				elseif CurrentAction == 'delete_vehicle' then
					if Config.EnableSocietyOwnedVehicles then
						local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
						TriggerServerEvent('esx_society:putVehicleInGarage', 'police', vehicleProps)
					end
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				elseif CurrentAction == 'menu_boss_actions' then
					ESX.UI.Menu.CloseAll()
					TriggerEvent('esx_society:openBossMenu', 'police', function(data, menu)
						menu.close()
						CurrentAction     = 'menu_boss_actions'
						CurrentActionMsg  = _U('open_bossmenu')
						CurrentActionData = {}
					end)
				elseif CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)
				end

				CurrentAction = nil
			end
		end -- CurrentAction end

		if IsControlJustReleased(0, Keys['F6']) and not isDead and PlayerData.job ~= nil and PlayerData.job.name == 'police' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') then
			OpenPoliceActionsMenu()
		end

		if IsControlJustReleased(0, Keys['E']) and CurrentTask.Busy then
			ESX.ShowNotification(_U('impound_canceled'))
			ESX.ClearTimeout(CurrentTask.Task)
			ClearPedTasks(PlayerPedId())

			CurrentTask.Busy = false
		end
	end
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
	TriggerEvent('esx_policejob:unrestrain')

	if not hasAlreadyJoined then
		TriggerServerEvent('esx_policejob:spawned')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_policejob:unrestrain')
	end
end)

-- handcuff timer, unrestrain the player after an certain amount of time
function StartHandcuffTimer()
	if Config.EnableHandcuffTimer and HandcuffTimer then
		ESX.ClearTimeout(HandcuffTimer)
	end

	HandcuffTimer = ESX.SetTimeout(Config.HandcuffTimer, function()
		ESX.ShowNotification(_U('unrestrained_timer'))
		TriggerEvent('esx_policejob:unrestrain')
	end)

	HandcuffTimer = nil
end

-- TODO
--   - return to garage if owned
--   - message owner that his vehicle has been impounded
function ImpoundVehicle(vehicle)
	--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
	ESX.Game.DeleteVehicle(vehicle)
	ESX.ShowNotification(_U('impound_successful'))
	CurrentTask.Busy = false
end

function paycheck(amount)
	TriggerServerEvent("esx_policejob:pay", amount)
end

function OpenFouileerMenu(player)
	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
		local elements = {}


		for i = 1, #data.accounts, 1 do
			if data.accounts[i].name == 'money' and data.accounts[i].money > 0 then
				table.insert(elements, {
					label    = _U('confiscate_dirty1', ESX.Math.Round(data.accounts[i].money)),
					value    = 'money',
					itemType = 'item_account',
					amount   = data.accounts[i].money
				})

				break
			end
		end

		for i = 1, #data.accounts, 1 do
			if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
				table.insert(elements, {
					label    = _U('confiscate_dirty1', ESX.Math.Round(data.accounts[i].money)),
					value    = 'black_money',
					itemType = 'item_account',
					amount   = data.accounts[i].money
				})

				break
			end
		end

		--		table.insert(elements, {label = _U('guns_label')})

		for i = 1, #data.weapons, 1 do
			table.insert(elements, {
				label    = _U('confiscate_weapon1', ESX.GetWeaponLabel(data.weapons[i].name), data.weapons[i].ammo),
				value    = data.weapons[i].name,
				itemType = 'item_weapon',
				amount   = data.weapons[i].ammo
			})
		end

		--		table.insert(elements, {label = _U('inventory_label')})

		for i = 1, #data.inventory, 1 do
			if data.inventory[i].count > 0 then
				table.insert(elements, {
					label    = _U('confiscate_inv1', data.inventory[i].count, data.inventory[i].label),
					value    = data.inventory[i].name,
					itemType = 'item_standard',
					amount   = data.inventory[i].count
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search', {
			title    = _U('search'),
			align    = 'top-right',
			elements = elements
		}, function(data, menu)
			if data.current.value then
				--				TriggerServerEvent('esx_policejob:confiscatePlayerItem', GetPlayerServerId(player), data.current.itemType, data.current.value, data.current.amount)
				--				SimpleNotify("Je kan voorwerpen afpak")
				OpenFouileerMenu(player)
			end
		end, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

local isRequestAnim = false
local requestedemote = ''


RegisterCommand('fouilleren', function(source, args, raw)
	target, distance = GetClosestPlayer()
	if (distance ~= -1 and distance < 3) then
		TriggerServerEvent("esx_policejob:ServerEmoteRequest", GetPlayerServerId(target))
		SimpleNotify('Fouileer Verzoek is verstuurd naar ID : ' .. GetPlayerServerId(target) .. "")
	else
		SimpleNotify('Er is niemand dichtbij')
	end
end, false)


RegisterNetEvent("esx_policejob:SyncPlayEmote")
AddEventHandler("esx_policejob:SyncPlayEmote", function(player)
	local SourcePlayerID = GetPlayerServerId()


	SimpleNotify("Je hebt het verzoek geaccepteerd")

end)


RegisterNetEvent("esx_policejob:SyncPlayEmoteSource")
AddEventHandler("esx_policejob:SyncPlayEmoteSource", function(player)
	local SourcePlayerID = GetPlayerServerId()

	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()


	if (distance ~= -1 and distance < 3) then
		OpenFouileerMenu(closestPlayer)
	else
		SimpleNotify('Er is ~r~niemand~w~ dichtbij')
	end
end)


RegisterNetEvent("esx_policejob:ClientEmoteRequestReceive")
AddEventHandler("esx_policejob:ClientEmoteRequestReceive", function()
	isRequestAnim = true

	PlaySound(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 0, 0, 1)
	SimpleNotify('Druk op ~g~Y~w~ om het fouileer verzoek te accepteren, Druk op ~r~H~w~ om het verzoek af te wijzen!')
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if IsControlJustPressed(1, 246) and isRequestAnim then
			target, distance = GetClosestPlayer()
			if (distance ~= -1 and distance < 3) then
				TriggerServerEvent("esx_policejob:ServerValidEmote", GetPlayerServerId(target))
				isRequestAnim = false
			else
				SimpleNotify('Er is niemand dichtbij')
			end
		elseif IsControlJustPressed(1, 182) and isRequestAnim then
			SimpleNotify('Verzoek ~r~afgewezen~w~')
			isRequestAnim = false
		end
	end
end)



function GetPlayerFromPed(ped)
	for _, player in ipairs(GetActivePlayers()) do
		if GetPlayerPed(player) == ped then
			return player
		end
	end
	return -1
end

function GetPedInFront()
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.3, 0.0)
	local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 10.0, 12, plyPed, 7)
	local _, _, _, _, ped2 = GetShapeTestResult(rayHandle)
	return ped2
end

function MearbysOnCommand(source, args, raw)
	local NearbysCommand = ""
	for a in pairsByKeys(DP.Shared) do
		NearbysCommand = NearbysCommand .. "" .. a .. ", "
	end
	EmoteChatMessage(NearbysCommand)
	EmoteChatMessage(Config.Languages[lang]['emotemenucmd'])
end

function SimpleNotify(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0, 1)
end

function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)

	for index, value in ipairs(players) do
		local target = GetPlayerPed(value)
		if (target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
			if (closestDistance == -1 or closestDistance > distance) then
				closestPlayer = value
				closestDistance = distance
			end
		end
	end
	return closestPlayer, closestDistance
end

function GetPlayers()
	local players = {}

	for i = 0, 255 do
		if NetworkIsPlayerActive(i) then
			table.insert(players, i)
		end
	end

	return players
end
