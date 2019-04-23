ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_computer:paydirty')
AddEventHandler('esx_computer:paydirty', function(hacks)
	local xPlayer = ESX.GetPlayerFromId(source)
	local amount  = math.random (10,200)
	local source = xPlayer.source
	xPlayer.addAccountMoney('black_money', amount)
	TriggerClientEvent('esx:showNotification', source, '~r~You managed to get into a few Fleeca Bank accounts and hacked $'..amount)
end)

RegisterServerEvent('esx_computer:payclean')
AddEventHandler('esx_computer:payclean', function(programming)
	local xPlayer = ESX.GetPlayerFromId(source)
	local amount2  = math.random (50,200)
	local source = xPlayer.source
	xPlayer.addAccountMoney('bank', amount2)
	TriggerClientEvent('esx:showNotification', source, '~g~You did some programming and recieved $'..amount2)
end)