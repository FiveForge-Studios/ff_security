Utils = {}

function Utils.GenerateUUID()
  local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
  return string.gsub(template, '[xy]', function (c)
      local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
      return string.format('%x', v)
  end)
end

function Utils.RequestCamera(name, camera)
    if CCTV_Config.HideRadar then
        DisplayRadar(false)
    end

    if CCTV_Config.HideHUD then
        Utils.ToggleHUD(true)
    end

    camNumber = tonumber(camera)
    if inCam then
        inCam = false
        PlaySoundFrontend(-1, "HACKING_SUCCESS", false)
        Wait(250)
        ClearPedTasks(PlayerPedId())
    else
        if camNumber > 0 and camNumber < #CCTV_Config.Cameras + 1 then
            exports["xmenu"]:CloseMenu()
            PlaySoundFrontend(-1, "HACKING_SUCCESS", false)
            Utils.UseCamera(name, camNumber)
        end
    end
end

function Utils.ChangeCamera(name, camera)
    changedCamera = true
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cctvCam, false)
    camNumber = tonumber(camera)
    Utils.UseCamera(name, camera)
end

function Utils.UseCamera(locationName, cameraUsed)
    camFov = 110.0
    local location = nil
    for k, v in pairs(CCTV_Config.Cameras) do
        if locationName == v.name and cameraUsed == v.camera then
            location = v.location
            currentCamIndex = k
        end
    end

    if not inCam then
        cameraScaleform = RequestScaleformMovie("TRAFFIC_CAM") -- Traffic Cam UI Header
        while not HasScaleformMovieLoaded(cameraScaleform) do
            Citizen.Wait(0)
        end
        PushScaleformMovieFunction(cameraScaleform, "PLAY_CAM_MOVIE")
        PopScaleformMovieFunctionVoid()
        scaleformState = "LOADED_SCALEFORM"
    end
    
    cctvCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(cctvCam, location.x, location.y, location.z + 1.2)
    SetCamRot(cctvCam, -15.0,0.0, location.w)
    SetCamFov(cctvCam, camFov)
    RenderScriptCams(true, false, 0, 1, 0)
    SetFocusArea(location.x, location.y, location.z, 0.0, 0.0, 0.0)
    inCam = true
    if not changedCamera then
        Wait(3000) -- Wait until scaleform has loaded fully and you can use the camera
        scaleformState = "CAMERA_READY"
    end
end

function Utils.CloseCamera()
    DestroyCam(cctvCam, false)
    RenderScriptCams(false, false, 0, 1, 0)
    ClearFocus()
    ClearTimecycleModifier()
    SetScaleformMovieAsNoLongerNeeded(cameraScaleform)
    SetScaleformMovieAsNoLongerNeeded(controlsScaleform)
    SetNightvision(false)
    SetSeethrough(false)
    cctvCam = 0
    cameraScaleform = nil
    controlsScaleform = nil
    currentCamIndex = 0
    inCam = false
    scaleformState = "UNLOADED"
    changedCamera = false
end

function Utils.GetCamAmountByName(buildingName)
    local cameraCount = 0
    for k, v in pairs(CCTV_Config.Cameras) do
        if v.name == buildingName then
            cameraCount = cameraCount + 1
        end
    end
    return cameraCount
end

function Utils.CreateInstructions(passedScaleform, buttonsMessages)
    local tempScaleform = RequestScaleformMovie(passedScaleform)
    while not HasScaleformMovieLoaded(tempScaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(tempScaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(tempScaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    local buttonCount = 0
    for k, v in pairs(buttonsMessages) do
        PushScaleformMovieFunction(tempScaleform, "SET_DATA_SLOT")
        PushScaleformMovieFunctionParameterInt(buttonCount)
        Button(GetControlInstructionalButton(2, v.button, true))
        ButtonMessage(v.name)
        PopScaleformMovieFunctionVoid()
        buttonCount = buttonCount + 1
    end

    PushScaleformMovieFunction(tempScaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(tempScaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(70)
    PopScaleformMovieFunctionVoid()

    return tempScaleform
end

function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function Button(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

Utils.ToggleHUD = function(toggledHud)
    if toggledHud then
        -- toggle it here
    else
        -- turn it off here
    end
end

Utils.HasPermission = function()
    if CCTV_Config.UseAces then
        return hasPermission
    end

    return true
end

Utils.Notification = function(msg, flash, saveToBrief, hudColorIndex)
	local notify = GetCurrentResourceName()..':notification'
	AddTextEntry(notify, msg)
	BeginTextCommandThefeedPost(notify)
	if hudColorIndex then ThefeedNextPostBackgroundColor(hudColorIndex) end
	EndTextCommandThefeedPostTicker(flash or false, saveToBrief or true)

	msg, hudColorIndex, flash, saveToBrief, notify = nil, nil, nil, nil, nil
end