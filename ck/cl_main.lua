
--developed by karpo#1943
local ekaspawni = true

RegisterNetEvent('teksti') --pidetään ilman esx joten tehään oma event tälle paskalle
AddEventHandler('teksti', function(teksti)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(teksti)
    DrawNotification(true, false)
end)


AddEventHandler('esx:onPlayerDeath', function() --jos delaat nii laittaa dbsee valueen 1 jota käytetään myöhemmin clogin checkkaamisessa 
	TriggerServerEvent('karpo_anticlog:db', 1)
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function() --kun pelaaja loadaa ekaa kertaa inee
    TriggerServerEvent('karpo_anticlog:synty')--checkkaa databasesta onko pelaaja kuollut vai ei
    exports.spawnmanager:setAutoSpawn(false) -- yoinkattu ambulancejobist, ei respawnaa pediä instana
end)

AddEventHandler('playerSpawned', function() --jos pelaaja spawnaa esim revivellä tai sairaalaan
    if not ekaspawni then --checkkaa onko tämä spawni pelaajan ensimmäinen
       TriggerServerEvent('karpo_anticlog:db', 0)
    end
    ekaspawni = false--settaa falselle jotta ens kerralla kun tämä runnaa, niin voidaan triggeröidä server event ettei ukko kuole instana
end)

RegisterNetEvent('karpo_anticlog:kuolehomo')
AddEventHandler('karpo_anticlog:kuolehomo', function() --self explanatory
    Wait(5000)
	SetEntityHealth(PlayerPedId(), 0)
	TriggerEvent('teksti','~r~Älä clogaa saatana!!!')
end)
