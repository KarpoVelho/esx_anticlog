ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--developed by karpo#1943



RegisterNetEvent('karpo_anticlog:db')
AddEventHandler('karpo_anticlog:db', function(db)  
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Sync.execute("UPDATE users SET isDead=@isDead WHERE identifier=@identifier",{
		['@identifier'] = identifier, --hex hex hex
		['@isDead'] = db --settaa valuen ykköselle db ?!?!?!?!
	})    
end)

RegisterNetEvent('karpo_anticlog:synty')
AddEventHandler('karpo_anticlog:synty', function()
    local identifier = GetPlayerIdentifiers(source)[1]
    local _source = source
    MySQL.Async.fetchScalar('SELECT isDead FROM users WHERE identifier=@identifier',
	{
		['@identifier'] = identifier
	}, function(isDead)
        print(isDead)
		if isDead == 1 then
			TriggerClientEvent('karpo_anticlog:kuolehomo', _source)
		end
	end)
end)  
