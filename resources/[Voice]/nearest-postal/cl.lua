local raw = LoadResourceFile(GetCurrentResourceName(), GetResourceMetadata(GetCurrentResourceName(), 'postal_file'))
local postals = json.decode(raw)

for i=1, #postals do
	postals[i].coords = vector2(postals[i].x, postals[i].y)
	postals[i].x, postals[i].y = nil, nil
end

local nearest = nil
pBlip = nil

postals2 = nil
Citizen.CreateThread(function()
    postals2 = LoadResourceFile(GetCurrentResourceName(), GetResourceMetadata(GetCurrentResourceName(), 'postal_file'))
    postals2 = json.decode(postals2)
    for i, postal in ipairs(postals2) do postals2[i] = { vec(postal.x, postal.y), code = postal.code } end
end)

function GetClosestPostalCode(coords)
	_coords = vector2(coords.x, coords.y)
	local ndm = -1 -- nearest distance magnitude
	local ni = -1 -- nearest index
	for i, p in ipairs(postals) do
		local distance = #(_coords - postals[i].coords) -- distance magnitude
		if ndm == -1 or distance < ndm then
			ni = i
			ndm = distance
		end
	end
	return ni, ndm
end

-- -- thread for nearest and blip
-- Citizen.CreateThread(function()
-- 	while true do
-- 		local ni, ndm = GetClosestPostalCode(GetEntityCoords(PlayerPedId()))

-- 		--setting the nearest
-- 		if ni ~= -1 then
-- 			local nd = math.sqrt(ndm) -- nearest distance
-- 			nearest = {i = ni, d = nd}
-- 		end

-- 		Wait(1000)
-- 	end
-- end)

-- -- text display thread
-- Citizen.CreateThread(function()
-- 	while true do
-- 		if nearest and not IsHudHidden() then
-- 			local text = config.text.format:format(postals[nearest.i].code, nearest.d)
-- 			SetTextScale(0.42, 0.42)
-- 			SetTextFont(4)
-- 			SetTextOutline()
-- 			BeginTextCommandDisplayText('STRING')
-- 			AddTextComponentSubstringPlayerName(text)
-- 			EndTextCommandDisplayText(config.text.posX, config.text.posY)
-- 		end
-- 		Wait(0)
-- 	end
-- end)

exports("getPostalCode", function(coords)
	coords = coords or GetEntityCoords(PlayerPedId())
	local ni = GetClosestPostalCode(coords)
	return postals[ni].code
end)

TriggerEvent('chat:addSuggestion', '/postal', 'Zet de gps naar een specifieke postcode',
             { { name = 'Postcode', help = 'De postcode waar jij heen wilt' } })

RegisterCommand('postal', function(_, args)
    if #args < 1 then
        if pBlip then
            RemoveBlip(pBlip.hndl)
            pBlip = nil
            TriggerEvent('chat:addMessage', {
                color = { 255, 0, 0 },
                args = {
                    'TomTom ',
                    config.blip.deleteText
                }
            })
        end
        return
    end

    local userPostal = string.upper(args[1])
    local foundPostal

    for _, p in ipairs(postals2) do
        if string.upper(p.code) == userPostal then
            foundPostal = p
            break
        end
    end

    if foundPostal then
        if pBlip then RemoveBlip(pBlip.hndl) end
        local blip = AddBlipForCoord(foundPostal[1][1], foundPostal[1][2], 0.0)
        pBlip = { hndl = blip, p = foundPostal }
        SetBlipRoute(blip, true)
        SetBlipSprite(blip, config.blip.sprite)
        SetBlipColour(blip, config.blip.color)
        SetBlipRouteColour(blip, config.blip.color)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(string.format(config.blip.blipText, pBlip.p.code))
        EndTextCommandSetBlipName(blip)

        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0 },
            args = {
                'TomTom ',
                string.format(config.blip.drawRouteText, foundPostal.code)
            }
        })
    else
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0 },
            args = {
                'TomTom ',
                string.format(config.blip.notExistText, args[1])
            }
        })
    end
end)
--[[Development shit]]
local dev = false
if dev then
	local devLocal = json.decode(raw)
	local next = 0

	RegisterCommand('setnext', function(src, args, raw)
		local n = tonumber(args[1])
		if n ~= nil then
			next = n
			print('next ' .. next)
			return
		end
		print('invalid ' .. n)
	end)

	RegisterCommand('next', function(src, args, raw)
		for i, d in ipairs(devLocal) do
			if d.code == tostring(next) then
				print('duplicate ' .. next)
				return
			end
		end
		local coords = GetEntityCoords(PlayerPedId())
		table.insert(devLocal, {code = tostring(next), x = coords.x, y = coords.y})
		print('insert ' .. next)
		next = next + 1
	end)

	RegisterCommand('rl', function(src, args, raw)
		if #devLocal > 0 then
			local data = table.remove(devLocal, #devLocal)
			print('remove ' .. data.code)
			print('next ' .. next)
			next = next - 1
		else
			print('invalid')
		end
	end)

	RegisterCommand('remove', function(src, args, raw)
		if #args < 1 then
			print('invalid')
		else
			for i, d in ipairs(devLocal) do
				if d.code == args[1] then
					table.remove(devLocal, i)
					print('remove ' .. d.code)
					return
				end
			end
			print('invalid')
		end
	end)

	RegisterCommand('json', function(src, args, raw)
		print(json.encode(devLocal))
	end)
end
raw = nil