local health = 0
local armor = 0
local food = 0
local thirst = 0
local posi = "bottom"

ESX = exports["es_extended"]:getSharedObject()

AddEventHandler("playerSpawned", function() -- Enable hud only after player spawn
    CreateThread(function()
        while true do
            Wait(0)
            if IsEntityDead(PlayerPedId()) then
                health = 0
            else
                health = math.ceil(GetEntityHealth(PlayerPedId()) - 100)
            end
            armor = math.ceil(GetPedArmour(PlayerPedId()))
            TriggerEvent("bpt_status:getStatus", "hunger", function(status)
                food = status.getPercent()
            end)
            TriggerEvent("bpt_status:getStatus", "thirst", function(status)
                thirst = status.getPercent()
            end)
            SendNUIMessage({
                posi = posi,
                show = IsPauseMenuActive(), -- Disable hud if settings menu is active
                health = health,
                armor = armor,
                food = food,
                thirst = thirst,
            })
        end
    end)
end)
