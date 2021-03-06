-- Variables
local firstSpawn = false
hasPermission = false

-- Events
AddEventHandler("onClientResourceStart", function(resourceName) -- When the resource is restarted, run this to get player permissions.
	if GetCurrentResourceName() == resourceName then
		if CCTV_Config.UseAces then
			TriggerServerEvent("LX_Security_Server:GetPermissions")
		end
		
		Utils.Notification("[~y~LX Security Loaded~w~]\n\nCreated By ~g~akaLucifer#0103~w~!")
	end
end)

AddEventHandler("playerSpawned", function() -- When you first spawn in, run this to get player permissions.
	if not firstSpawn then
		if CCTV_Config.UseAces then
			TriggerServerEvent("LX_Security_Server:GetPermissions")
		end

		firstSpawn = true
		Utils.Notification("[~y~LX Security Loaded~w~]\n\nCreated By ~g~akaLucifer#0103~w~!")
	end
end)

-- Threads
CreateThread(function()
	if CCTV_Config.UseAces then
		RegisterNetEvent("LX_Security_Client:SetPermission")
		AddEventHandler("LX_Security_Client:SetPermission", function(hasPerms) -- Set your permission on the client.
			hasPermission = hasPerms
		end)
	end
end)
