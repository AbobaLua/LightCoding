local LightCoding = { }
-- say (print)
function say(text)
  print(text)
end
LightCoding.say = say
-- warnmsg (warn)
function warnmsg(text)
  warn(text)
end
LightCoding.warnmsg = warnmsg
-- err (error)
function err(text, lvl)
  if lvl == nil then
    error(text)
  else
    error(text, lvl)
  end
end
LightCoding.err = err

-- service (GetService)
function service(NameService)
  local service = game:GetService(NameService)
  return service
end
LightCoding.service = service
-- create (Instance)
function create(NameObject)
  local obj = Instance.new(NameObject)
  return obj
end
LightCoding.create = create
-- fireclickdetector
function pfireclickd(path)
  local plr = game.Players.LocalPlayer
  local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if path:IsA("ClickDetector") then
        local success, err = pcall(function()
            fireclickdetector(path)
        end)      
        if not success then return nil end
    end
end
LightCoding.pfireclickd = pfireclickd
-- firetouchinterest
function pfiretouchinterest(touch, obj)
    local plr = game.Players.LocalPlayer
    local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if touch == plr then
      if not hrp then return end
        if obj:IsA("BasePart") then
            local success, err = pcall(function()
                firetouchinterest(hrp, obj, 0)
            end)
            if not success then return nil end
        end
        return
    end
    if obj:IsA("BasePart") then
        local success, err = pcall(function()
            firetouchinterest(touch, obj, 0)
        end)
        if not success then return nil end
    end
end
LightCoding.pfiretouchinterest = pfiretouchinterest
-- fireproximitypromt
function pfireproxpromt(obj)
  local plr = game.Players.LocalPlayer
  local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
  if not hrp then return end
    if obj:IsA("ProximityPrompt") then
      local succes, err = pcall(function()
      fireproximityprompt(obj)
      end)
    if not succes then return nil end
  end
end
LightCoding.pfireproxpromt = pfireproxpromt
return LightCoding
