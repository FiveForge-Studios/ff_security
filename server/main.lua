-- Events
RegisterNetEvent("LX_Security_Server:GetPermissions")
AddEventHandler("LX_Security_Server:GetPermissions", function()
    local src = source
    TriggerClientEvent("LX_Security_Client:SetPermission", src, IsPlayerAceAllowed(src, "lx-security"))
end)