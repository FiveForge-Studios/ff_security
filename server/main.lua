-- Events
RegisterNetEvent("FF_Security_Server:GetPermissions")
AddEventHandler("FF_Security_Server:GetPermissions", function()
    local src = source
    TriggerClientEvent("FF_Security_Client:SetPermission", src, IsPlayerAceAllowed(src, "ff-security"))
end)