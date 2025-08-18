local QBCore = exports['qb-core']:GetCoreObject()

-- Rep System
local function GetPlayerCid(source)
    local cid = nil
    
    local player = QBCore.Functions.GetPlayer(source)
    cid = player.PlayerData.citizenid 
    return cid
end

lib.callback.register("sam-scavenging:server:getrep", function (source)
    
    local repRow = MySQL.single.await('SELECT `rep` FROM `scavenging_rep` WHERE `citizen_id` = ?', { GetPlayerCid(source) })

    if repRow then
        return repRow.rep
    else
        TriggerEvent("sam-scavenging:server:createRepEntry", source)
        return 0
    end
end)

RegisterNetEvent("sam-scavenging:server:setRep", function(rep)
    local src = source

    local repRow = MySQL.single.await('SELECT `rep` FROM `scavenging_rep` WHERE `citizen_id` = ?', { GetPlayerCid(source) })

    if repRow then
       MySQL.update.await("UPDATE `scavenging_rep` SET `rep` = ? WHERE `citizen_id` = ?", { rep, GetPlayerCid(src)})
    else
        TriggerEvent("sam-scavenging:server:createRepEntry", src)
        
    end
    
end)

RegisterNetEvent("sam-scavenging:server:createRepEntry", function(source)
    MySQL.insert.await('INSERT INTO `scavenging_rep` (citizen_id) VALUES (?)', {GetPlayerCid(source) })
    
end)