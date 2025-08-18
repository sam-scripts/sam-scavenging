local QBCore = exports['qb-core']:GetCoreObject()

-- Animation
local enterAnim = "missexile3"
    RequestAnimDict(enterAnim)
    while (not HasAnimDictLoaded(enterAnim)) do
    Citizen.Wait(1)
    end
    

-- Ped
CreateThread(function()
  local model = Config.Ped
  RequestModel(model)
  while not HasModelLoaded(model) do Wait(0) end
  local scavengePed = CreatePed(0, model, Config.PedCoords, true, false)

  FreezeEntityPosition(scavengePed, true)
	SetEntityInvincible(scavengePed, true)
	SetBlockingOfNonTemporaryEvents(scavengePed, true)
  TaskStartScenarioInPlace(scavengePed, "WORLD_HUMAN_SEAT_LEDGE", 0, true)

  exports['qb-target']:AddTargetEntity(scavengePed, {
    options = {
      {
        num = 1,
        type = "client",
        event = "npc:openDialog",
        label = "Talk to hobo...",
        targeticon = "fas fa-user",
        action = function(entity)
          openMenu()
        end,
        canInteract = function(entity, distance, data)
          return not IsPedAPlayer(entity)
        end,

      }
    },
    distance = 2.0
  })
end)

-- Scavenging Target
exports['qb-target']:AddTargetModel(Config.LootableItems, {
  options = {
    {
      num = 1,
      type = "client",
      label = "Scavenge...",
      targeticon = "fa fa-archive",
      action = function(entity)

      lootableEntity = entity
      if not NetworkGetEntityIsNetworked(lootableEntity) then
        NetworkRegisterEntityAsNetworked(lootableEntity)
    end

      local isLooted = Entity(lootableEntity).state.looted
      if isLooted == true then
        print("Already Looted")
        QBCore.Functions.Notify("This has already been searched!", "error", 5000)
      else
      print("Looting Entity ID: " .. lootableEntity)
      startScavenge() 
      TriggerEvent("sam-scavenging:client:setLootedState", lootableEntity)
      end
      end,
      canInteract = function(entity, distance, data)
        return true
      end,
    }
  },
  distance = 2.0
})

--/ Functions

-- Open Steve Menu
function openMenu()
  exports['qb-menu']:openMenu({
    { 
        header = "Scavenging Steve", 
        disabled = true,
        isMenuHeader = false,
        action = function()
           
        end
    },
    {
        header = "Experience:", 
        txt = lib.callback.await("sam-scavenging:server:getrep"),
        disabled = true
    },
    {
        header = "Steve, who are you?", 
        txt = "Ask steve a question",
        disabled = false,
        action = function ()
          QBCore.Functions.Notify("Steve says go search some trash and come back to him!")
        end
    }
       
}, false, false)
end

-- Start Scavenege Function
function startScavenge()
  QBCore.Functions.Progressbar('scavenging', 'Scavenging...', Config.ScavengeTime, false, true, {
    disableMovement = true,
    disableCarMovement = true,
    disableMouse = false,
    disableCombat = true
    }, 
    {
      animDict = "missexile3",
        anim = "ex03_dingy_search_case_base_michael",
        flags = 49,
      }, 
    {}, 
    {}, function()
        -- This code runs if the progress bar completes successfully
        print("Looted ID: " .. lootableEntity)
        TriggerEvent("sam-scavenging:client:giveRep")
    end, function()
        -- This code runs if the progress bar gets cancelled
end)
end

--/ Events

-- Loot State
RegisterNetEvent("sam-scavenging:client:setLootedState", function (entity)
  local lootObject = entity
  if not NetworkGetEntityIsNetworked(lootObject) then
        NetworkRegisterEntityAsNetworked(lootObject)
    end
  Entity(lootObject).state:set("looted", true, true)
  Citizen.Wait(Config.CooldownTime)
  Entity(lootObject).state:set("looted", false, true)
end)


RegisterNetEvent("sam-scavenging:client:giveRep", function ()
  local rep = lib.callback.await('sam-scavenging:server:getrep')
  local newRep = rep + math.random(0,10)

  TriggerServerEvent('sam-scavenging:server:setRep', newRep)
end)


-- debug commands
RegisterCommand('getscavengerep', function()
  local rep = lib.callback.await('sam-scavenging:server:getrep')

  print('Your scavenging reputation is: ' .. rep)

end, false)

RegisterCommand('setscavengerep', function(_, args)
  local newRep = tonumber(args[1])

  if newRep then
    TriggerServerEvent('sam-scavenging:server:setRep', newRep)
  else
    print('Input invalid...')
  end

end, false)