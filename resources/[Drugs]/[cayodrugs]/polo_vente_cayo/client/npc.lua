npc = nil
local npcCooords = {coords = vector3(4836.26, -5177.27, 2.18)}

Citizen.CreateThread(function()
    RequestModel(GetHashKey("g_m_y_famdnf_01"))
	
    while not HasModelLoaded(GetHashKey("g_m_y_famdnf_01")) do
        Wait(1)
    end
	
	npc = CreatePed(4, GetHashKey("g_m_y_famdnf_01"), npcCooords.coords.x, npcCooords.coords.y, npcCooords.coords.z-1, 287.85, false, true)
	GetNPC(npc)
	
	FreezeEntityPosition(npc, true)	
	SetEntityHeading(npc, 287.85)
	SetEntityInvincible(npc, true)
	SetBlockingOfNonTemporaryEvents(npc, true)
	RequestAnimDict("mini@strip_club@idles@bouncer@base")
	while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
		Citizen.Wait(1000)
	end
		
	Citizen.Wait(200)	
	TaskPlayAnim(npc,"mini@strip_club@idles@bouncer@base","base",1.0, 1.0, -1, 9, 1.0, 0, 0, 0)
	GiveWeaponToPed(npc, GetHashKey("weapon_revolver_mk2"), math.random(20, 100), true, false)
	SetPedAmmo(npc, GetHashKey("weapon_revolver_mk2"), math.random(20, 100))
	SetCurrentPedWeapon(npc, GetHashKey("weapon_revolver_mk2"), true)
	SetPedAccuracy(npc, 100)
	SetPedInfiniteAmmo(npc, true, GetHashKey("weapon_revolver_mk2"))
	SetPedTalk(npc)
end)