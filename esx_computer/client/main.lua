ESX = nil
local nearPC				 = false
local caught				 = 5
local PlayerData             = {}

PC = {
	[1] = 1333557690
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)


function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())  
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end

function loadAnimDict(dict)
	while(not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(1)
	end
end

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(10)
		if nearPC and PlayerData.job ~= nil and PlayerData.job.name == 'hacker' then
			DrawText3Ds(PCLoc['x'], PCLoc['y'], PCLoc['z'], "Press ~r~E ~w~to start hacking accounts on this computer.")										
		if IsControlJustReleased(0, 38) then
			local chance = math.random(0, 100)
			local playerPed = PlayerPedId()
			local coords	= GetEntityCoords(playerPed)				
			loadAnimDict("anim@amb@office@laptops@male@var_a@base@")
			TaskPlayAnim(GetPlayerPed(-1), "anim@amb@office@laptops@male@var_a@base@", "base", 1.0, 2, -1, 49, 0, 0, 0, 0)
			FreezeEntityPosition(GetPlayerPed(-1), true)
			Citizen.Wait(16000)
			ClearPedTasksImmediately(GetPlayerPed(-1))
			TriggerServerEvent('esx_computer:paydirty', hacks)				
			FreezeEntityPosition(GetPlayerPed(-1), false)
		if chance <= caught then
			TriggerServerEvent('esx_phone:send', "police", 'Fleeca Bank Security Breach Alert: Accounts Compromised! IP/Location of breach has been sent.' , {x = coords.x, y = coords.y, z = coords.z})
				end	
			end			
		end
	end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(10)
		if nearPC and PlayerData.job ~= nil and PlayerData.job.name ~= 'hacker' then
			DrawText3Ds(PCLoc['x'], PCLoc['y'], PCLoc['z'], "Press ~g~E ~w~to start programming on this computer.")										
		if IsControlJustReleased(0, 38) then			
			loadAnimDict("anim@amb@office@laptops@male@var_a@base@")
			TaskPlayAnim(GetPlayerPed(-1), "anim@amb@office@laptops@male@var_a@base@", "base", 1.0, 2, -1, 49, 0, 0, 0, 0)
			FreezeEntityPosition(GetPlayerPed(-1), true)
			Citizen.Wait(16000)
			ClearPedTasksImmediately(GetPlayerPed(-1))
			TriggerServerEvent('esx_computer:payclean', programming)
			FreezeEntityPosition(GetPlayerPed(-1), false)
			end			
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		nearPC = false
		local myCoords = GetEntityCoords(GetPlayerPed(-1))		 
		for i = 1, #PC do
			local closestPC = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 1.0, PC[i], false, false)		
				if closestPC ~= nil and closestPC ~= 0 then 
					local coords = GetEntityCoords(closestPC)
					nearPC = true
					PCLoc = {['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z + 0.7}
				end
			break
		end
	end
end)