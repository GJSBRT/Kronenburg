-------------------------------------
------- Created by T1GER#9080 -------
-------------------------------------
Citizen.CreateThread(function()
	while securityToken == nil do
		Citizen.Wait(100)
	end
end)
Banks        = {}
Safes        = {}
vaultDoor    = nil
deskCashDoor = nil
Police       = 0
safeObj      = nil

-- Keypad [1] Hacking Thread:
keypad1 = false
local player = GetPlayerPed(-1)
local coords = vector3(0.0, 0.0, 0.0)
Citizen.CreateThread(function()
	while true do
		local player = GetPlayerPed(-1)
		coords = GetEntityCoords(player, true)
		Citizen.Wait(500)
	end
end)

Citizen.CreateThread(function()
	while true do
		local sleepLong = true
		Citizen.Wait(1)

		if usingCamera then
			local player = GetPlayerPed(-1)
			form = InstructionalButtons("instructional_buttons")

			local camRotation = GetCamRot(cameraID, 2)
			DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
			if IsControlPressed(0, Config.CamLeft) then -- arrow left
				SetCamRot(cameraID, camRotation.x, 0.0, (camRotation.z + 0.25), 2)
			end
			if IsControlPressed(0, Config.CamRight) then -- arrow right
				SetCamRot(cameraID, camRotation.x, 0.0, (camRotation.z - 0.25), 2)
			end
			if IsControlPressed(0, Config.CamUp) then -- arrow up
				SetCamRot(cameraID, (camRotation.x + 0.25), 0.0, camRotation.z, 2)
			end
			if IsControlPressed(0, Config.CamDown) then -- arrow down
				SetCamRot(cameraID, (camRotation.x - 0.25), 0.0, camRotation.z, 2)
			end
			if IsControlPressed(0, Config.CamExit) then -- backspace
				usingCamera = false
				Wait(500)
				ClearPedTasks(player)
				DeleteObject(tablet)
				SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)
			end
		end

		for k, v in pairs(Banks) do
			if (k ~= 8 and not v.inUse or (v.powerBox ~= nil and v.powerBox.disabled)) or k == 8 and v.inUse or (v.powerBox ~= nil and v.powerBox.disabled) then
				if v.keypads[1] ~= nil and not v.keypads[1].hacked then
					if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.keypads[1].pos[1], v.keypads[1].pos[2], v.keypads[1].pos[3], false) <= 1.0 and not keypad1 then
						sleepLong = false
						if Police >= v.minCops then
							if not isCop then
								if (k == 8 and v.safe ~= nil and not v.safe.cracked) or (k ~= 8 and v.safe == nil) then
									DrawText3Ds(v.keypads[1].pos[1], v.keypads[1].pos[2], v.keypads[1].pos[3], Lang['hack_keypad_1'])
									if IsControlJustPressed(0, Config.KeyHackTerminal) and not keypad1 then
										ESX.TriggerServerCallback('t1ger_bankrobbery:hackerDevice', function(gotDevice)
											if gotDevice then
												keypad1 = true
												TriggerServerEvent('t1ger_bankrobbery:inUseSV', true)
												HackKeyPad1(k, v)
											else
												ShowNotifyESX(Lang['no_hacking_dev'])
											end
										end)
									end
								else
									DrawText3Ds(v.keypads[1].pos[1], v.keypads[1].pos[2], v.keypads[1].pos[3], Lang['open_keypad_1'])
									if IsControlJustPressed(0, 47) and not keypad1 then
										ESX.TriggerServerCallback('t1ger_bankrobbery:accessCard', function(hasAccessCard)
											if hasAccessCard then
												keypad1 = true
												TriggerServerEvent('t1ger_bankrobbery:KeypadStateSV', "first", k, true)
												Wait(1000)
												keypad1 = false
											else
												ShowNotifyESX(Lang['no_access_card'])
											end
										end)
									end
								end
							end
						else
							DrawText3Ds(v.keypads[1].pos[1], v.keypads[1].pos[2], v.keypads[1].pos[3], Lang['bank_in_lockdown'])
						end
					end
				end
			end
			if k == 8 then

				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.door.pos[1], v.door.pos[2], v.door.pos[3], true) <= 6.0 then
					sleepLong = false
					local bankDoor = GetClosestObjectOfType(v.door.pos[1], v.door.pos[2], v.door.pos[3], 5.0, v.door.model, false, true, false)
					if bankDoor ~= nil and bankDoor ~= 0 then
						if not v.keypads[1].hacked then
							FreezeEntityPosition(bankDoor, true)
						else
							FreezeEntityPosition(bankDoor, false)
						end
					end
				end
			end
		end

		if sleepLong ~= false then Citizen.Wait(950) end
	end
end)

-- Keypad [2] Hacking Thread:
keypad2 = false
Citizen.CreateThread(function()
	while true do
		local sleepLong = true
		Citizen.Wait(1)
		for k, v in pairs(Banks) do
			if v.inUse then
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.keypads[2].pos[1], v.keypads[2].pos[2], v.keypads[2].pos[3], false) <= 1.0 and not keypad2 then
					sleepLong = false
					if not v.keypads[2].hacked and v.keypads[1].hacked then
						if not isCop then
							if (k == 8 and v.safe ~= nil and not v.safe.cracked) or (k ~= 8 and v.safe == nil) then
								DrawText3Ds(v.keypads[2].pos[1], v.keypads[2].pos[2], v.keypads[2].pos[3], Lang['hack_keypad_2'])
								if IsControlJustPressed(0, Config.KeyHackVault) and not keypad2 then
									ESX.TriggerServerCallback('t1ger_bankrobbery:hackerDevice', function(gotDevice)
										if gotDevice then
											keypad2 = true
											HackKeyPad2(k, v)
										else
											ShowNotifyESX(Lang['no_hacking_dev'])
										end
									end)
								end
							else
								DrawText3Ds(v.keypads[2].pos[1], v.keypads[2].pos[2], v.keypads[2].pos[3], Lang['open_keypad_2'])
								if IsControlJustPressed(0, 47) and not keypad2 then
									ESX.TriggerServerCallback('t1ger_bankrobbery:accessCard', function(hasAccessCard)
										if hasAccessCard then
											keypad2 = true
											TriggerServerEvent('t1ger_bankrobbery:KeypadStateSV', "second", k, true)
											Wait(1000)
											keypad2 = false
										else
											ShowNotifyESX(Lang['no_access_card'])
										end
									end)
								end
							end
						end
					end
				end
			end
			if k ~= 8 then
				if v.door ~= nil and v.keypads[2] ~= nil then
					if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.door.pos[1], v.door.pos[2], v.door.pos[3], true) <= 6.0 then
						sleepLong = false
						local cellDoor = GetClosestObjectOfType(v.door.pos[1], v.door.pos[2], v.door.pos[3], 5.0, v.door.model, false, true, false)
						if cellDoor ~= nil and cellDoor ~= 0 then
							if not v.keypads[2].hacked then
								FreezeEntityPosition(cellDoor, true)
							else
								FreezeEntityPosition(cellDoor, false)
							end
						end
					end
				end
			end
		end


		if sleepLong ~= false then Citizen.Wait(950) end
	end
end)

-- First Door Hacking (STARTER) // MHACKING
function HackKeyPad1(k, v)
	if v.keypads[1] ~= nil then
		if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.keypads[1].pos[1], v.keypads[1].pos[2], v.keypads[1].pos[3], false) <= 1.0 then
			SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)
			Citizen.Wait(200)
			FreezeEntityPosition(player, true)
			TaskStartScenarioInPlace(player, 'WORLD_HUMAN_STAND_MOBILE', -1, true)
			Citizen.Wait(2000)
			if Config.mHacking then
				TriggerEvent("mhacking:show")
				TriggerEvent("mhacking:start", 3, 25, KeyPad1Complete)
			else
				keypad1 = false
				-- Add your own minigame here and make a callback to KeyPad1Complete function.
			end
		end
	end
end

-- CALLBACK FOR FIRST KEYPAD:
function KeyPad1Complete(success)
	TriggerEvent('mhacking:hide')
	if success then
		if math.random(1, 100) <= Config.ChanceHackerDeviceBack then
			ShowNotifyESX(Lang['hacker_dev_corrupted'])
		else
			local item = Config.HackItem
			TriggerServerEvent('t1ger_bankrobbery:giveItem', item, securityToken)
		end
		for k, v in pairs(Banks) do
			if GetDistanceBetweenCoords(coords, v.keypads[1].pos[1], v.keypads[1].pos[2], v.keypads[1].pos[3], true) < 1.5 then
				TriggerServerEvent('t1ger_bankrobbery:KeypadStateSV', "first", k, true)
				Citizen.Wait(500)
				if not v.powerBox.disabled then
					NotifyPoliceFunction(v.name)
				else
					if v.powerBox.hackSuccess.enable then
						local newTime = robTime + (v.powerBox.hackSuccess.time * 1000)
						ShowNotifyESX(Lang['extra_free_time_added']:format(tonumber(newTime / 1000)))
						TriggerServerEvent('t1ger_bankrobbery:addRobTimeSV', newTime)
					end
				end
			end
		end
	else
		for k, v in pairs(Banks) do
			if GetDistanceBetweenCoords(coords, v.keypads[1].pos[1], v.keypads[1].pos[2], v.keypads[1].pos[3], true) < 1.5 then
				--TriggerServerEvent('t1ger_bankrobbery:inUseSV', false)
				TriggerServerEvent('t1ger_bankrobbery:KeypadStateSV', "first", k, false)
				Citizen.Wait(500)
				if not v.powerBox.disabled then
					NotifyPoliceFunction(v.name)
				else
					if robTime ~= nil then
						local newTime = (robTime + 2000) - robTime
						TriggerServerEvent('t1ger_bankrobbery:addRobTimeSV', newTime)
					end
				end
			end
		end
	end
	keypad1 = false
	ClearPedTasks(player)
	FreezeEntityPosition(player, false)
end

-- First Door Hacking // FINGERPRINT
function HackKeyPad2(k, v)
	if v.keypads[2] ~= nil then
		if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.keypads[2].pos[1], v.keypads[2].pos[2], v.keypads[2].pos[3], true) <= 1.0 then
			SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)
			Citizen.Wait(200)
			FreezeEntityPosition(player, true)
			TaskStartScenarioInPlace(player, 'WORLD_HUMAN_STAND_MOBILE', -1, true)
			Citizen.Wait(2000)
			if Config.utkFingerPrint then
				TriggerEvent("utk_fingerprint:Start", 3, 3, 2, FingerPrintCallback)
			else
				keypad2 = false
				-- Add your own minigame here and make a callback to FingerPrintCallback function.
			end
		end
	end
end

-- CALLBACK FOR SECOND DOOR HACKING:
function FingerPrintCallback(outcome, reason)
	local reason = "TEST TEST TEST"
	if outcome == true then -- reason will be nil if outcome is true
		if math.random(1, 100) <= Config.ChanceHackerDeviceBack then
			ShowNotifyESX(Lang['hacker_dev_corrupted'])
		else
			local item = Config.HackItem
			TriggerServerEvent('t1ger_bankrobbery:giveItem', item, securityToken)
		end
		for k, v in pairs(Banks) do
			if GetDistanceBetweenCoords(coords, v.keypads[2].pos[1], v.keypads[2].pos[2], v.keypads[2].pos[3], true) < 1.5 then
				TriggerServerEvent('t1ger_bankrobbery:KeypadStateSV', "second", k, true)
				Citizen.Wait(500)
				if v.powerBox.disabled then
					if v.powerBox.hackSuccess.enable then
						if robTime ~= nil then
							local newTime = robTime + (v.powerBox.hackSuccess.time * 1000)
							ShowNotifyESX(Lang['extra_free_time_added']:format(tonumber(newTime / 1000)))
							TriggerServerEvent('t1ger_bankrobbery:addRobTimeSV', newTime)
						end
					end
				end
			end
		end
	elseif outcome == false then
		for k, v in pairs(Banks) do
			if GetDistanceBetweenCoords(coords, v.keypads[2].pos[1], v.keypads[2].pos[2], v.keypads[2].pos[3], true) < 1.5 then
				TriggerServerEvent('t1ger_bankrobbery:KeypadStateSV', "second", k, false)
				Citizen.Wait(500)
				if v.powerBox.disabled then
					if robTime ~= nil then
						local newTime = (robTime + 2000) - robTime
						TriggerServerEvent('t1ger_bankrobbery:addRobTimeSV', newTime)
					end
				end
			end
		end
	end
	keypad2 = false
	ClearPedTasks(player)
	FreezeEntityPosition(player, false)
end

-- Manage vault & doors thread:
vaultInteract = false
Citizen.CreateThread(function()
	local PaletoDoor = false
	while true do
		local sleepLong = true
		Citizen.Wait(1)
		local player = GetPlayerPed(-1)
		local coords = GetEntityCoords(player, true)
		for k, v in pairs(Banks) do
			v.vault.pos[1] = v.vault.pos[1]
			v.vault.pos[2] = v.vault.pos[2]
			v.vault.pos[3] = v.vault.pos[3]
			if GetDistanceBetweenCoords(GetEntityCoords(player), -105.9, 6472.11, 31.9) > 50.0 then
				PaletoDoor = false
			end
			if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.vault.pos[1], v.vault.pos[2], v.vault.pos[3], true) <= 50.0 then
				sleepLong = false
				vaultDoor = GetClosestObjectOfType(coords.x, coords.y, coords.z, 50.0, v.vault.model, false, false, false)
				if vaultDoor ~= nil and vaultDoor ~= 0 then
					if k == 7 and not PaletoDoor then
						SetEntityHeading(vaultDoor, 45.0)
						PaletoDoor = true
					end
					FreezeEntityPosition(vaultDoor, true)
					if v.inUse and ((k ~= 8 and v.keypads[1].hacked) or (k == 8 and v.keypads[2].hacked and v.keypads[1].hacked)) then
						if Vdist(coords.x, coords.y, coords.z, v.vault.pos[1], v.vault.pos[2], v.vault.pos[3]) <= 1.0 then
							local vaultHeading = GetEntityHeading(vaultDoor)
							if not vaultInteract then
								if vaultHeading > v.vault.oHeadMin and vaultHeading < v.vault.oHeadMax then
									DrawText3Ds(v.vault.pos[1], v.vault.pos[2], v.vault.pos[3], Lang['close_vault_dr'])
								elseif vaultHeading > v.vault.cHeadMin and vaultHeading < v.vault.cHeadMax then
									if isCop then
										if k ~= 8 then
											DrawText3Ds(v.vault.pos[1], v.vault.pos[2], v.vault.pos[3], Lang['open_vault_dr_pol'])
										else
											DrawText3Ds(v.vault.pos[1], v.vault.pos[2], v.vault.pos[3], Lang['open_vault_dr'])
										end
									else
										DrawText3Ds(v.vault.pos[1], v.vault.pos[2], v.vault.pos[3], Lang['open_vault_dr'])
									end
								end
							end
							if IsControlJustPressed(0, Config.KeyOpenVaultDoor) and vaultHeading > v.vault.cHeadMin and vaultHeading < v.vault.cHeadMax then
								Citizen.Wait(0)
								vaultInteract = true
								if k == 7 then
									TriggerServerEvent('t1ger_bankrobbery:CloseVaultDoorSV', k, v, vaultHeading, 280)
								else
									if k == 8 then
										TriggerServerEvent('t1ger_bankrobbery:OpenVaultDoorSV', k, v, vaultHeading, 320)
									else
										TriggerServerEvent('t1ger_bankrobbery:OpenVaultDoorSV', k, v, vaultHeading, 280)
									end
								end
							end
							if IsControlJustPressed(0, Config.KeyCloseVaultDoor) and vaultHeading > v.vault.oHeadMin and vaultHeading < v.vault.oHeadMax then
								Citizen.Wait(0)
								vaultInteract = true
								if k == 7 then
									TriggerServerEvent('t1ger_bankrobbery:OpenVaultDoorSV', k, v, vaultHeading, 280)
								else
									if k == 8 then
										TriggerServerEvent('t1ger_bankrobbery:CloseVaultDoorSV', k, v, vaultHeading, 320)
									else
										TriggerServerEvent('t1ger_bankrobbery:CloseVaultDoorSV', k, v, vaultHeading, 280)
									end
								end
							end
							if isCop then
								if IsControlJustPressed(0, Config.KeySecureVaultDoor) and not vaultInteract then
									if k ~= 8 then
										if vaultHeading > v.vault.cHeadMin and vaultHeading < v.vault.cHeadMax then
											if k == 7 then
												vaultInteract = true
												RestoreBank(k, v)
											elseif k ~= 8 then
												vaultInteract = true
												RestoreBank(k, v)
											end
										else
											ShowNotifyESX(Lang['vault_dr_must_close'])
										end
									end
								end
							end
						end
					end
					if v.inUse and k == 8 then
						if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.deskDoor.pos[1], v.deskDoor.pos[2], v.deskDoor.pos[3], false) <= 1.5 and not vaultInteract then
							if isCop then
								if IsControlJustPressed(0, Config.KeySecureVaultDoor) and not vaultInteract then
									if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.vault.pos[1], v.vault.pos[2], v.vault.pos[3], true) <= 50.0 then
										local vaultHeading = GetEntityHeading(vaultDoor)
										if vaultHeading > v.vault.cHeadMin and vaultHeading < v.vault.cHeadMax then
											vaultInteract = true
											RestoreBank(k, v)
										else
											ShowNotifyESX(Lang['vault_dr_must_close'])
										end
									end
								end
							end
						end
					end
				end
			end
		end


		if sleepLong ~= false then Citizen.Wait(950) end
	end
end)

-- Drill Thread:
drillSafe = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3)
		for k, v in pairs(Safes) do
			if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.pos[1], v.pos[2], v.pos[3], true) <= 1.2 then
				if not v.robbed then
					if not v.failed then
						if not drillSafe then
							DrawText3Ds(v.pos[1], v.pos[2], v.pos[3], Lang['safe_not_drilled'])
							if IsControlJustPressed(0, 38) then

								ESX.TriggerServerCallback('t1ger_bankrobbery:drillItem', function(hasDrill)
									if hasDrill then
										TriggerEvent('t1ger_bankrobbery:drillCloseSafe')
										drillSafe = true
									else
										ShowNotifyESX(Lang['no_drill'])
									end
								end, Config.DrillItem)
							end
						end
					else
						DrawText3Ds(v.pos[1], v.pos[2], v.pos[3], Lang['safe_destroyed'])
					end
					if IsControlJustPressed(2, Config.DrillStopKey) then
						TriggerEvent("Drilling:Stop")
					end
				else
					DrawText3Ds(v.pos[1], v.pos[2], v.pos[3], Lang['safe_drilled'])
				end
			end
		end
	end
end)

-- Event to drill safe:
RegisterNetEvent('t1ger_bankrobbery:drillCloseSafe')
AddEventHandler('t1ger_bankrobbery:drillCloseSafe', function()
	local player   = GetPlayerPed(-1)
	local coords   = GetEntityCoords(player, true)
	local drilling = false
	local drillSound
	local attachedDrill
	local effect
	for k, v in pairs(Safes) do
		if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.pos[1], v.pos[2], v.pos[3], false) <= 1.2 then
			if not v.failed then
				if not v.robbed then
					local animDict = "anim@heists@fleeca_bank@drilling"
					local animLib = "drill_straight_idle"

					local closestPlayer, dist = ESX.Game.GetClosestPlayer()
					if closestPlayer ~= -1 and dist <= 1.0 then
						if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), animDict, animLib, 3) then
							return ShowNotifyESX(Lang['safe_drilled_by_ply'])
						end
					end

					drilling = true
					FreezeEntityPosition(player, true)
					SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)
					Citizen.Wait(100)

					RequestAnimDict(animDict)
					while not HasAnimDictLoaded(animDict) do
						Citizen.Wait(50)
					end

					local drillProp = GetHashKey('hei_prop_heist_drill')
					local boneIndex = GetPedBoneIndex(player, 28422)

					RequestModel(drillProp)
					while not HasModelLoaded(drillProp) do
						Citizen.Wait(100)
					end

					SetEntityCoords(player, v.AnimPos[1], v.AnimPos[2], v.AnimPos[3] - 0.95)
					SetEntityHeading(player, v.AnimHeading)
					TaskPlayAnimAdvanced(player, animDict, animLib, v.AnimPos[1], v.AnimPos[2], v.AnimPos[3], 0.0, 0.0, v.AnimHeading, 1.0, -1.0, -1, 2, 0, 0, 0)

					attachedDrill = CreateObject(drillProp, 1.0, 1.0, 1.0, 1, 1, 0)
					AttachEntityToEntity(attachedDrill, player, boneIndex, 0.0, 0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)

					SetEntityAsMissionEntity(attachedDrill, true, true)

					RequestAmbientAudioBank("DLC_HEIST_FLEECA_SOUNDSET", 0)
					RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL", 0)
					RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL_2", 0)
					drillSound = GetSoundId()
					Citizen.Wait(100)
					PlaySoundFromEntity(drillSound, "Drill", attachedDrill, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
					Citizen.Wait(100)

					local particleDictionary = "scr_fbi5a"
					local particleName = "scr_bio_grille_cutting"

					RequestNamedPtfxAsset(particleDictionary)
					while not HasNamedPtfxAssetLoaded(particleDictionary) do
						Citizen.Wait(0)
					end

					SetPtfxAssetNextCall(particleDictionary)
					effect = StartParticleFxLoopedOnEntity(particleName, attachedDrill, 0.0, -0.6, 0.0, 0.0, 0.0, 0.0, 2.0, 0, 0, 0)
					ShakeGameplayCam("ROAD_VIBRATION_SHAKE", 1.0)
					Citizen.Wait(100)

					TriggerEvent("Drilling:Start", function(drillStatus)

						if (drillStatus == 1) then
							Safes[k].robbed = true
							TriggerServerEvent('t1ger_bankrobbery:SafeDataSV', "robbed", k, true)
							TriggerServerEvent('t1ger_bankrobbery:safeReward')
							drillSafe = false
						elseif (drillStatus == 3) then
							ShowNotifyESX(Lang['drilling_paused'])
							local item = Config.DrillItem
							TriggerServerEvent('t1ger_bankrobbery:giveItem', item, securityToken)
							drillSafe = false
						elseif (drillStatus == 2) then
							Safes[k].failed = true
							TriggerServerEvent("t1ger_bankrobbery:SafeDataSV", "failed", k, true)
							ShowNotifyESX(Lang['you_destroyed_safe'])
							drillSafe = false
						end

						drilling = false
						ClearPedTasksImmediately(player)
						StopSound(drillSound)
						ReleaseSoundId(drillSound)
						DeleteObject(attachedDrill)
						DeleteEntity(attachedDrill)
						FreezeEntityPosition(player, false)
						StopParticleFxLooped(effect, 0)
						StopGameplayCamShaking(true)
					end)
				else
					ShowNotifyESX(Lang['safe_arealdy_robbed'])
				end
			else
				ShowNotifyESX(Lang['safe_destroyed_noti'])
			end
		end
	end
end)

-- CAMERA FEATURE:

usingCamera = false
cameraID = 0
tablet = nil

RegisterCommand("camera", function(source, args, rawCommand)
	local cameraNum = tonumber(args[1])
	if isCop then
		TriggerEvent('t1ger_bankrobbery:camera', cameraNum)
	else
		ShowNotifyESX(Lang['no_access_to_cam'])
	end
end, false)

RegisterNetEvent('t1ger_bankrobbery:camera')
AddEventHandler('t1ger_bankrobbery:camera', function(cameraNum)
	local player = GetPlayerPed(-1)
	if usingCamera then
		usingCamera = false
		ClearPedTasks(player)
		DeleteObject(tablet)
		SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)
	else
		if cameraNum > 0 and cameraNum <= #Config.Camera then
			-- tablet emote:
			if not IsEntityPlayingAnim(player, "amb@world_human_seat_wall_tablet@female@base", "base", 3) then
				RequestAnimDict("amb@world_human_seat_wall_tablet@female@base")
				while not HasAnimDictLoaded("amb@world_human_seat_wall_tablet@female@base") do
					Citizen.Wait(10)
				end
				TaskPlayAnim(player, "amb@world_human_seat_wall_tablet@female@base", "base", 2.0, -2, -1, 49, 0, 0, 0, 0)
				object = CreateObject(GetHashKey("prop_cs_tablet"), 0, 0, 0, true, true, true)
				AttachEntityToEntity(object, player, GetPedBoneIndex(player, 57005), 0.17, 0.10, -0.13, 20.0, 180.0, 180.0, true, true, false, true, 1, true)
				tablet = object
				Wait(500)
			end
			Wait(500)
			TriggerEvent('t1ger_bankrobbery:openCameraView', cameraNum)
		else
			ShowNotifyESX(Lang['camera_not_exist'])
		end
	end
end)

function InstructionalButtons(scaleform)
	local scaleform = RequestScaleformMovie(scaleform)
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
	PushScaleformMovieFunctionParameterInt(200)
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(0)
	Button(GetControlInstructionalButton(2, 174, true))
	ButtonMessage("LINKS")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(1)
	Button(GetControlInstructionalButton(2, 175, true))
	ButtonMessage("RECHTS")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(2)
	Button(GetControlInstructionalButton(2, 172, true))
	ButtonMessage("OMHOOG")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(3)
	Button(GetControlInstructionalButton(2, 173, true))
	ButtonMessage("BENEDEN")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(4)
	Button(GetControlInstructionalButton(2, 178, true)) -- The button to display
	ButtonMessage("STOP") -- the message to display next to it
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(80)
	PopScaleformMovieFunctionVoid()

	return scaleform
end

-- ## Power Box ## --

robTime = nil
bankID = nil
RegisterNetEvent('t1ger_bankrobbery:powerBoxCL')
AddEventHandler('t1ger_bankrobbery:powerBoxCL', function(id, state, timer)
	if id ~= nil or state ~= nil then
		Banks[id].powerBox.disabled = state
	end
	robTime = timer
	bankID = id
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if robTime ~= nil then
			if robTime == 0 then
				local bankName = Banks[bankID].name
				SilentAlarmTrigger(bankName)
				robTime = nil
			else
				robTime = robTime - 1000
				print("time left: " .. robTime)
			end
		end
	end
end)

powerBoxInteract = false
Citizen.CreateThread(function()
	while true do
		local sleepLong = true
		Citizen.Wait(2)
		for k, v in pairs(Banks) do
			if v.powerBox ~= nil then
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.powerBox.pos[1], v.powerBox.pos[2], v.powerBox.pos[3], true) <= 1.0 then
					sleepLong = false
					if not v.powerBox.disabled then
						if not powerBoxInteract then
							DrawText3Ds(v.powerBox.pos[1], v.powerBox.pos[2], v.powerBox.pos[3], Lang['power_box_not_disabled'])
						end
						if IsControlJustPressed(0, 38) and not powerBoxInteract then
							ESX.TriggerServerCallback('t1ger_bankrobbery:hammerWireCutterItem', function(gotItem)
								if gotItem then
									powerBoxInteract = true
									disablePowerFunction(k, v)
								else
									ShowNotifyESX(Lang['no_hammerwirecutter'])
								end
							end)
						end
					else
						DrawText3Ds(v.powerBox.pos[1], v.powerBox.pos[2], v.powerBox.pos[3], Lang['power_box_disabled'])
					end
				end
			end
		end

		if sleepLong ~= false then Citizen.Wait(950) end
	end
end)

function disablePowerFunction(k, v)
	local player = GetPlayerPed(-1)
	SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)
	Citizen.Wait(500)
	SetEntityCoords(player, v.powerBox.animPos[1], v.powerBox.animPos[2], v.powerBox.animPos[3] - 0.975, false, false, false, false)
	SetEntityHeading(player, v.powerBox.animHeading)
	TaskStartScenarioInPlace(player, "WORLD_HUMAN_HAMMERING", 0, true)
	exports['progressBars']:startUI((4 * 1000), "OPENING POWER BOX")
	Citizen.Wait(4 * 1000)
	exports['progressBars']:closeUI()
	Wait(250)
	TaskStartScenarioInPlace(player, "prop_human_parking_meter", 0, true)
	exports['progressBars']:startUI((4 * 1000), "CUTTING WIRES")
	Citizen.Wait(4 * 1000)

	TriggerServerEvent('t1ger_bankrobbery:powerBoxSV', k, true, (v.powerBox.freeTime * 1000))
	TriggerServerEvent('t1ger_bankrobbery:inUseSV', true)

	ShowNotifyESX(Lang['notify_free_time']:format(tonumber(v.powerBox.freeTime)))
	ClearPedTasks(player)
	powerBoxInteract = false
end

-- ## Safe Code ACCESS ## --

crackingSafe = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local safeCoords = GetEntityCoords(safeObj, true)
		for k, v in pairs(Banks) do
			if v.inUse then
				if v.powerBox.disabled then
					if v.safe ~= nil then
						if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, safeCoords.x, safeCoords.y, safeCoords.z, true) <= 1.0 then
							if not v.safe.cracked then
								DrawText3Ds(safeCoords.x + 0.1, safeCoords.y + 0.35, safeCoords.z, Lang['open_pacific_safe'])
								if IsControlJustPressed(0, 38) and not crackingSafe then
									crackingSafe = true
									crackPacificSafe(k, v)
								end
							else
								DrawText3Ds(safeCoords.x + 0.1, safeCoords.y + 0.35, safeCoords.z, Lang['pacific_safe_cracked'])
							end
						end
					end
				end
			end
		end
	end
end)

function crackPacificSafe(k, v)
	local player = GetPlayerPed(-1)
	local coords = GetEntityCoords(player, true)
	local safeCoords = GetEntityCoords(safeObj, true)

	-- Safe Crack Animation
	local animDict = "mini@safe_cracking"
	local animName = "dial_turn_anti_fast_3"
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(10)
	end
	SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)
	Citizen.Wait(500)
	SetEntityCoords(player, 263.93, 208.21, 110.29 - 0.95)
	Wait(100)
	FreezeEntityPosition(player, true)
	SetEntityHeading(player, GetEntityHeading(safeObj))
	TaskPlayAnim(player, animDict, animName, 1.0, 1.0, -1, 2, 0, 0, 0)
	exports['progressBars']:startUI((5 * 1000), "OPENING SAFE")
	Citizen.Wait(5 * 1000)
	TriggerServerEvent('t1ger_bankrobbery:pacificSafeSV', k, true)
	TriggerServerEvent('t1ger_bankrobbery:giveItem', Config.AccessCard, securityToken)
	ShowNotifyESX(Lang['found_access_card'])
	ClearPedTasks(player)
	FreezeEntityPosition(player, false)
	Wait(500)
	crackingSafe = false
end

-- ## Rob Petty Cash From Desks ## --

-- Desk Door Thread:
deskDoorLockpicking = false
deskDoorInteract = false
Citizen.CreateThread(function()
	while true do
		local sleepLong = true
		Citizen.Wait(1)
		local player = GetPlayerPed(-1)
		local coords = GetEntityCoords(player, true)
		for k, v in pairs(Banks) do
			if (k ~= 8 and v.inUse) or (k == 8 and (not v.inUse or v.inUse and v.powerBox.disabled)) then
				if v.deskDoor ~= nil then
					sleepLong = false
					if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.deskDoor.pos[1], v.deskDoor.pos[2], v.deskDoor.pos[3], false) <= 1.0 and not deskDoorLockpicking then
						local cashDoor = GetClosestObjectOfType(v.deskDoor.pos[1], v.deskDoor.pos[2], v.deskDoor.pos[3], 5.0, v.deskDoor.model, false, true, false)
						if not v.deskDoor.lockpicked then
							if not isCop then
								DrawText3Ds(v.deskDoor.pos[1], v.deskDoor.pos[2], v.deskDoor.pos[3], Lang['lockpick_desk_door'])
								if IsControlJustPressed(0, 38) and not deskDoorLockpicking then
									ESX.TriggerServerCallback('t1ger_bankrobbery:lockpickItem', function(gotLockpick)
										if gotLockpick then
											deskDoorLockpicking = true
											lockpickDeskDoor(k, v, cashDoor)
										else
											ShowNotifyESX(Lang['no_lockpick'])
										end
									end)
								end
							end
						end
					end
				end
			end
			if v.deskDoor ~= nil then
				sleepLong = false
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.deskDoor.pos[1], v.deskDoor.pos[2], v.deskDoor.pos[3], true) <= 6.0 then
					deskCashDoor = GetClosestObjectOfType(v.deskDoor.pos[1], v.deskDoor.pos[2], v.deskDoor.pos[3], 5.0, v.deskDoor.model, false, true, false)
					local deskDoorHeading = GetEntityHeading(deskCashDoor)
					if deskCashDoor ~= nil and deskCashDoor ~= 0 then
						FreezeEntityPosition(deskCashDoor, true)
						if v.deskDoor.lockpicked then
							if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.deskDoor.pos[1], v.deskDoor.pos[2], v.deskDoor.pos[3], true) <= 1.5 then
								if deskDoorHeading > v.deskDoor.oHeadMin and deskDoorHeading < v.deskDoor.oHeadMax then
									if isCop and k == 8 then
										DrawText3Ds(v.deskDoor.pos[1], v.deskDoor.pos[2], v.deskDoor.pos[3], Lang['close_desk_door_pol'])
									else
										DrawText3Ds(v.deskDoor.pos[1], v.deskDoor.pos[2], v.deskDoor.pos[3], Lang['close_desk_door'])
									end
									if IsControlJustPressed(0, 38) and not deskDoorInteract then
										if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.deskDoor.pos[1], v.deskDoor.pos[2], v.deskDoor.pos[3], true) <= 1.0 then
											deskDoorInteract = true
											Wait(200)
											if k ~= 8 then
												TriggerServerEvent('t1ger_bankrobbery:CloseDeskDoorSV', k, v, deskDoorHeading, 200)
											else
												TriggerServerEvent('t1ger_bankrobbery:OpenDeskDoorSV', k, v, deskDoorHeading, 200)
											end
										else
											ShowNotifyESX(Lang['get_closer_to_door'])
										end
									end
								elseif deskDoorHeading > v.deskDoor.cHeadMin and deskDoorHeading < v.deskDoor.cHeadMax then
									if isCop and k == 8 then
										DrawText3Ds(v.deskDoor.pos[1], v.deskDoor.pos[2], v.deskDoor.pos[3], Lang['open_desk_door_pol'])
									else
										DrawText3Ds(v.deskDoor.pos[1], v.deskDoor.pos[2], v.deskDoor.pos[3], Lang['open_desk_door'])
									end
									if IsControlJustPressed(0, 38) and not deskDoorInteract then
										if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.deskDoor.pos[1], v.deskDoor.pos[2], v.deskDoor.pos[3], true) <= 1.0 then
											deskDoorInteract = true
											Wait(200)
											if k ~= 8 then
												TriggerServerEvent('t1ger_bankrobbery:OpenDeskDoorSV', k, v, deskDoorHeading, 200)
											else
												TriggerServerEvent('t1ger_bankrobbery:CloseDeskDoorSV', k, v, deskDoorHeading, 200)
											end
										else
											ShowNotifyESX(Lang['get_closer_to_door'])
										end
									end
								end
							end
						end
					end
				end
			end
		end

		if sleepLong ~= false then Citizen.Wait(950) end
	end
end)

function lockpickDeskDoor(k, v, cashDoor)
	local player = GetPlayerPed(-1)
	local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
	local animName = "machinic_loop_mechandplayer"
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(10)
	end
	SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)
	Citizen.Wait(500)
	FreezeEntityPosition(player, true)
	SetEntityHeading(player, GetEntityHeading(cashDoor))
	TaskPlayAnim(player, animDict, animName, 3.0, 1.0, -1, 31, 0, 0, 0)
	exports['progressBars']:startUI((5 * 1000), "LOCKPICKING")
	Citizen.Wait(5 * 1000)
	TriggerServerEvent('t1ger_bankrobbery:deskDoorSV', k, true)
	if k == 8 and not v.powerBox.disabled then
		TriggerServerEvent('t1ger_bankrobbery:inUseSV', true)
		NotifyPoliceFunction(v.name)
	end
	ClearPedTasks(player)
	FreezeEntityPosition(player, false)
	Wait(500)
	deskDoorLockpicking = false
end

-- Steal Petty Cash Thread:
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		for k, v in pairs(Banks) do
			if v.inUse then
				if v.deskCash ~= nil then
					if v.deskDoor.lockpicked then
						for num, desk in pairs(v.deskCash) do
							if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, desk.pos[1], desk.pos[2], desk.pos[3], true) <= 1.0 then
								if not desk.robbed then
									DrawText3Ds(desk.pos[1], desk.pos[2], desk.pos[3], Lang['desk_cash_not_robbed'])
									if IsControlJustPressed(0, 38) then
										GrabCashAnim(k, desk, num)
									end
								else
									DrawText3Ds(desk.pos[1], desk.pos[2], desk.pos[3], Lang['desk_cash_robbed'])
								end
							end
						end
					end
				end
			end
		end
	end
end)

function GrabCashAnim(k, desk, num)
	local player = GetPlayerPed(-1)
	local animDict = "anim@heists@ornate_bank@grab_cash"
	local animName = "grab"
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(10)
	end
	local grabHeading = 0
	if k == 7 then
		grabHeading = 134.0
		SetEntityHeading(player, 134.0)
	elseif k == 8 then
		grabHeading = GetClosestObjectOfType(desk.pos[1], desk.pos[2], desk.pos[3], 3.0, -1605837712, false, true, false)
	else
		grabHeading = GetClosestObjectOfType(desk.pos[1], desk.pos[2], desk.pos[3], 3.0, -954257764, false, true, false)
		SetEntityHeading(player, GetEntityHeading(grabHeading))
	end
	TaskPlayAnim(player, animDict, animName, 1.0, -1.0, -1, 2, 0, 0, 0, 0)
	exports['progressBars']:startUI(7500, "ROBBING CASH")
	Citizen.Wait(7500)
	ClearPedTasks(player)
	TriggerServerEvent('t1ger_bankrobbery:deskCashSV', k, num, true)
end
