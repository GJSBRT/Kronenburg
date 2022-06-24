function DrawText3D(pos, text, d, dist)
  pos = vector3(pos.x,pos.y,pos.z)
  local camCoords = GetGameplayCamCoords()
  local distance = #(pos - camCoords)

  if not size then size = 1 end
  if not font then font = 1 end

  local scale = (size / distance) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  scale = scale * fov

  SetTextScale(0.0 * scale, 0.55 * scale)
  SetTextFont(font)
  SetTextColour(255, 255, 255, math.floor(math.max(0.0,255 / math.max(1.0, dist/(d / 10) )) ))
  SetTextDropshadow(0, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(true)

  SetDrawOrigin(pos, 0)
  BeginTextCommandDisplayText('STRING')
  AddTextComponentSubstringPlayerName(text)
  EndTextCommandDisplayText(0.0, 0.0)
  ClearDrawOrigin()
end

function CreateBlip(pos,sprite,color,text,scale,display,shortRange,highDetail)
  local blip = AddBlipForCoord(pos.x,pos.y,pos.z)
  SetBlipSprite               (blip, (sprite or 1))
  SetBlipColour               (blip, (color or 4))
  SetBlipScale                (blip, (scale or 1.0))
  SetBlipDisplay              (blip, (display or 3))
  SetBlipAsShortRange         (blip, (shortRange or false))
  SetBlipHighDetail           (blip, (highDetail or true))
  BeginTextCommandSetBlipName ("STRING")
  AddTextComponentString      ((text or "Blip "..tostring(blip)))
  EndTextCommandSetBlipName   (blip)
  return blip
end

function ShowAdvancedNotification(sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
  if saveToBrief == nil then saveToBrief = true end
  AddTextEntry('doors_advanced_notification', msg)
  BeginTextCommandThefeedPost('doors_advanced_notification')
  if hudColorIndex then ThefeedNextPostBackgroundColor(hudColorIndex) end
  EndTextCommandThefeedPostMessagetext(textureDict, textureDict, false, iconType, sender, subject)
  EndTextCommandThefeedPostTicker(flash or false, saveToBrief)
end

function ShowHelpNotification(msg, thisFrame, beep, duration)
  AddTextEntry('doors_help', msg)
  DisplayHelpTextThisFrame('doors_help', false)
end

function ShowNotification(msg)
  SetNotificationTextEntry('STRING')
  AddTextComponentSubstringPlayerName(msg)
  DrawNotification(false, true)
end

function V3SqrMagnitude(self)
  return self.x * self.x + self.y * self.y + self.z * self.z
end

function GetGroundZ(pos)
  local found,z = GetGroundZFor_3dCoord(pos.x,pos.y,pos.z)
  if not found then
    return GetGround(vector3(pos.x,pos.y,pos.z-1.0))
  else
    return vector3(pos.x,pos.y,z)
  end
end

function V3ClampMagnitude(self,max)
  if V3SqrMagnitude(self) > (max * max) then
    self = V3SetNormalize(self)
    self = V3Mul(self,max)
  end
  return self
end

function V3SetNormalize(self)
  local num = V3Magnitude(self)
  if num == 1 then
    return self
  elseif num > 1e-5 then
    self = V3Div(self,num)
  else
    self = vector3(0.0,0.0,0.0)
  end
  return self
end

function V3Mul(self,q)
  if type(q) == "number" then
    self = self * q
  else
    self = V3MulQuat(self,q)
  end
  return self
end

function V3Magnitude(self)
  return math.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
end

function V3Div(self,d)
  self = vector3(self.x / d,self.y / d,self.z / d)
  
  return self
end

function V3MulQuat(self,quat)    
  local num   = quat.x * 2
  local num2  = quat.y * 2
  local num3  = quat.z * 2
  local num4  = quat.x * num
  local num5  = quat.y * num2
  local num6  = quat.z * num3
  local num7  = quat.x * num2
  local num8  = quat.x * num3
  local num9  = quat.y * num3
  local num10 = quat.w * num
  local num11 = quat.w * num2
  local num12 = quat.w * num3
  
  local x = (((1 - (num5 + num6)) * self.x) + ((num7 - num12) * self.y)) + ((num8 + num11) * self.z)
  local y = (((num7 + num12) * self.x) + ((1 - (num4 + num6)) * self.y)) + ((num9 - num10) * self.z)
  local z = (((num8 - num11) * self.x) + ((num9 + num10) * self.y)) + ((1 - (num4 + num5)) * self.z)
  
  self = vector3(x, y, z) 
  return self
end

function V2Dist(v1, v2)
  if not v1 or not v2 or not v1.x or not v2.x or not v1.y or not v2.y then return 0; end
  return math.sqrt( ( (v1.x or 0) - (v2.x or 0) )*(  (v1.x or 0) - (v2.x or 0) )+( (v1.y or 0) - (v2.y or 0) )*( (v1.y or 0) - (v2.y or 0) ) )
end

function V3Dist(v1,v2)
  if not v1 or not v2 or not v1.x or not v2.x then return 0; end
  return math.sqrt(  ( (v1.x or 0) - (v2.x or 0) )*(  (v1.x or 0) - (v2.x or 0) )+( (v1.y or 0) - (v2.y or 0) )*( (v1.y or 0) - (v2.y or 0) )+( (v1.z or 0) - (v2.z or 0) )*( (v1.z or 0) - (v2.z or 0) )  )
end

Vdist = V3Dist