-- Get Closest Camera
function GetClosestCam(ped)
	local closest, closestDist
	if ped == nil then
		ped = PlayerPedId()
	end

    local pedCoords = GetEntityCoords(ped, false)

    for k, v in pairs(CCTV_Config.Cameras) do
        local camCoords = v.location
        local dist = GetDistanceBetweenCoords(pedCoords, camCoords, false) -- False means not to use the Z coord
		if not closestDist or dist < closestDist then
            closest = v.name
            closestDist = dist
        end
	end
	
    if closest then 
        return closest
    else
        return nil
    end
end