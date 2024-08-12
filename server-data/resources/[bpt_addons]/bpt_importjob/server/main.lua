TriggerEvent("bpt_society:registerSociety", "import", "Import", "society_import", "society_import", "society_import", {
	type = "public",
})

if Config.MaxInService ~= -1 then
	TriggerEvent("esx_service:activateService", "import", Config.MaxInService)
end

ESX.RegisterServerCallback("bpt_importjob:SpawnVehicle", function(source, cb, model, props)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= "import" then
		print(("[^3WARNING^7] Player ^5%s^7 attempted to Exploit Vehicle Spawing!!"):format(source))
		return
	end
	local SpawnPoint = vector3(
		Config.Zones.VehicleSpawnPoint.Pos.x,
		Config.Zones.VehicleSpawnPoint.Pos.y,
		Config.Zones.VehicleSpawnPoint.Pos.z
	)
	ESX.OneSync.SpawnVehicle(joaat(model), SpawnPoint, Config.Zones.VehicleSpawnPoint.Heading, props, function()
		local vehicle = NetworkGetEntityFromNetworkId()
		while GetVehicleNumberPlateText(vehicle) ~= props.plate do
			Wait(0)
		end
		TaskWarpPedIntoVehicle(GetPlayerPed(source), vehicle, -1)
	end)
	cb()
end)

RegisterNetEvent("bpt_importjob:getStockItem")
AddEventHandler("bpt_importjob:getStockItem", function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == "import" then
		TriggerEvent("bpt_addoninventory:getSharedInventory", "society_import", function(inventory)
			local item = inventory.getItem(itemName)

			-- is there enough in the society?
			if count > 0 and item.count >= count then
				-- can the player carry the said amount of x item?
				if xPlayer.canCarryItem(itemName, count) then
					inventory.removeItem(itemName, count)
					xPlayer.addInventoryItem(itemName, count)
					xPlayer.showNotification(TranslateCap("have_withdrawn", count, item.label))
				else
					xPlayer.showNotification(TranslateCap("player_cannot_hold"))
				end
			else
				xPlayer.showNotification(TranslateCap("quantity_invalid"))
			end
		end)
	else
		print(("[^3WARNING^7] Player ^5%s^7 attempted ^5bpt_importjob:getStockItem^7 (cheating)"):format(source))
	end
end)

ESX.RegisterServerCallback("bpt_importjob:getStockItems", function(_, cb)
	TriggerEvent("bpt_addoninventory:getSharedInventory", "society_import", function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent("bpt_importjob:putStockItems")
AddEventHandler("bpt_importjob:putStockItems", function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	if xPlayer.job.name == "import" then
		TriggerEvent("bpt_addoninventory:getSharedInventory", "society_import", function(inventory)
			local item = inventory.getItem(itemName)

			if sourceItem.count >= count and count > 0 then
				xPlayer.removeInventoryItem(itemName, count)
				inventory.addItem(itemName, count)
				xPlayer.showNotification(TranslateCap("have_deposited", count, item.label))
			else
				xPlayer.showNotification(TranslateCap("quantity_invalid"))
			end
		end)
	else
		print(("[^3WARNING^7] Player ^5%s^7 attempted ^5bpt_importjob:putStockItems^7 (cheating)"):format(source))
	end
end)
