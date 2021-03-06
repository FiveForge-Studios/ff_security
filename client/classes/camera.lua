local CameraShakes = {
    Hand = "HAND_SHAKE",
    SmallExplosion = "SMALL_EXPLOSION_SHAKE",
    MediumExplosion = "MEDIUM_EXPLOSION_SHAKE",
    LargeExplosion = "LARGE_EXPLOSION_SHAKE",
    Jolt = "JOLT_SHAKE",
    Vibrate = "VIBRATE_SHAKE",
    RoadVibration = "ROAD_VIBRATION_SHAKE",
    Drunk = "DRUNK_SHAKE",
    SkyDiving = "SKY_DIVING_SHAKE",
    FamilyDrugTrip = "FAMILYS_DRUG_TRIP_SHAKE",
    DeathFail = "DEATH_FAIL_IN_EFFECT_SHAKE"
}

Camera = {}
Camera.__index = Camera
  
function Camera.New()
    local newCamera = {}
    setmetatable(newCamera, Camera)
  
    newCamera.Handle = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
  
    return newCamera
end
  
function Camera:IsActive()
    return IsCamActive(self.Handle)
end
  
function Camera:Render(render, ease, time)
    RenderScriptCams(render, ease, time, 1, 1)
end
  
function Camera:SetActive(bool)
    SetCamActive(self.Handle, bool)
end
  
function Camera:GetPosition()
    return GetCamCoord(self.Handle)
end
  
function Camera:SetPosition(pos)
    SetCamCoord(self.Handle, pos.x, pos.y, pos.z)
end
  
function Camera:GetRotation()
    return GetCamRot(self.Handle, 2)
end
  
function Camera:SetRotation(rot)
    SetCamRot(self.Handle, rot.x, rot.y, rot.z, 2)
end
  
function Camera:GetFOV()
    return GetCamFov(self.Handle)
end
  
function Camera:SetFOV(fov)
    SetCamFov(self.Handle, fov)
end
  
function Camera:GetNearClip()
    return GetCamNearClip(self.Handle)
end
  
function Camera:SetNearClip(clip)
    SetCamNearClip(self.Handle, clip)
end
  
function Camera:GetFarClip()
    return GetCamFarClip(self.Handle)
end
  
function Camera:SetFarClip(clip)
    SetCamFarClip(self.Handle, clip)
end
  
function Camera:SetNearDOF(dof)
    SetCamNearDof(self.Handle, dof)
end
  
function Camera:GetFarDOF()
    return GetCamFarDof(self.Handle)
end
  
function Camera:SetFarDOF(dof)
    SetCamFarDof(self.Handle, dof)
end
  
function Camera:SetDOFStrength(strength)
    SetCamDofStrength(self.Handle, strength)
end
  
function Camera:SetMotionBlur(strength)
    SetCamMotionBlurStrength(self.Handle, strength)
end
  
function Camera:Shake(shakeType, amplitude)
    local shake = CameraShakes[shakeType]
    if shake then
      ShakeCam(self.Handle, shake, amplitude)
  end
end
  
function Camera:StopShake()
    StopCamShaking(self.Handle, true)
end
  
function Camera:IsShaking()
    return IsCamShaking(self.Handle)
end
  
function Camera:SetShakeAmplitude(amplitude)
    SetCamShakeAmplitude(self.Handle, amplitude)
end
  
function Camera:PointAtEntity(entity, offset)
    PointCamAtEntity(self.Handle, entity, offset.x, offset.y, offset.z, true)
end
  
function Camera:PointAtBone(ped, bone, offset)
    PointCamAtPedBone(self.Handle, ped, GetPedBoneIndex(ped, bone), offset.x, offset.y, offset.z, true)
end
  
function Camera:StopPoint()
    StopCamPointing(self.Handle)
end
  
function Camera:InterpTo(to, duration, easePos, easeRot)
    SetCamActiveWithInterp(to, self.Handle, duration, easePos, easeRot)
end
  
function Camera:IsInterpolating()
    return IsCamInterpolating(self.Handle)
end
  
function Camera:AttachToEntity(entity, offset)
    AttachCamToEntity(self.Handle, entity, offset.x, offset.y, offset.z, true)
end
  
function Camera:AttachToBone(ped, bone, offset)
    AttachCamToPedBone(self.Handle, ped, GetPedBoneIndex(ped, bone), offset.x, offset.y, offset.z, true)
end
  
function Camera:Detach()
    DetachCam(self.Handle)
end
  
function Camera:Delete()
    DestroyCam(self.Handle, false)
    RenderScriptCams(false, true, 500, true, true)
    VehicleCamera = nil
    CreatedCamera = false
end
  
function Camera:Exists()
    DoesCamExist(self.Handle)
end