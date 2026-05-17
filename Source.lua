local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char and char:FindFirstChild("HumanoidRootPart")
plr.CharacterAdded:Connect(function(character)
  char = character
   hrp = char:WaitForChild("HumanoidRootPart")
end)
local LightCoding = { }
LightCoding.Info = {
  Name = "Light coding",
  Version = "Unreleased",
  Author = {
    Name = "AbobaLua",
    URL = "https://github.com/AbobaLua"
  },
  Repository = "https://github.com/AbobaLua/LightCoding",
  Description = "Simple Coding Library"
}
LightCoding.Settings = {
  Debug = false,
  IsStudio = false,
  BlockedRemotes = { }
}
LightCoding.Functs = { }
LightCoding.CustomFuncts = { }
LightCoding.Delete = function(self)
  if self == LightCoding then
    for k in pairs(self) do
      self[k] = nil
    end
    setmetatable(self, nil)
    print("Bye LightCoding")
  end
end
local Info = LightCoding.Info
local Settings = LightCoding.Settings
local Functs = LightCoding.Functs
local CustomFuncts = LightCoding.CustomFuncts
local function console(...)
  if Settings and Settings.Debug then
    print("Light Coding Debug: ", ...)
  end
end
local function missing(t, f, fallback)
  if type(f) == t then return f end
  return fallback
end
local ClassFire = {RemoteEvent = "FireServer", RemoteFunction = "InvokeServer", UnreliableRemoteEvent = "FireServer", BindableRemote = "Fire", BindableFunction = "Invoke"}
local ClassType = {RemoteEvent = true, RemoteFunction = true, UnreliableRemoteEvent = true, BindableRemote = true, BindableFunction = true}
local function addfunc(name, func)
  if not name then return end
  if not (LightCoding and Functs) then return end
  if func and type(func) == "function" then
    Functs[name] = function(...)
      console("Calling: " .. "function: " .. tostring(func), "name: " .. name)
      return func(...)
    end
  end
end
local function AddCustomFunc(name, func, debug, debugtext)
  if not name then return end
  if not (LightCoding and CustomFuncts) then return end
  if func and type(func) == "function" then
    CustomFuncts[name] = function(...)
      if debug then
        local text = tosring(debugtext)
        console(text)
      end
      return func(...)
    end
  end
end
LightCoding.AddCustomFunc = AddCustomFunc
local function CallFunc(name, ...)
  if not LightCoding then return end
  if Functs and CustomFuncts then
    local func = Functs[name] or CustomFuncts[name]
    if func then
      return func(...)
    else
      Console("Function: " .. tostring(name), "Not Found")
      return nil
    end
  end
end
LightCoding.CallFunc = CallFunc
addfunc("getgenv", missing("function", getgenv and getgenv()))
addfunc("getfenv", missing("function", getfenv))
addfunc("fireclickdetector", missing("function", fireclickdetector))
addfunc("firetouchinterest", missing("function", firetouchinterest))
addfunc("fireproximityprompt", missing("function", fireproximityprompt))
addfunc("firesignal", missing("function", firesignal))
addfunc("executor", missing("function", identifyexecutor or getexecutorname or (syn and syn.getexecutorname)))
addfunc("clipboard", missing("function", setclipboard or toclipboard or set_clipboard or writeclipboard or (Clipboard and Clipboard.set)))
addfunc("writefile", missing("function", writefile))
addfunc("readfile", missing("function", readfile))
addfunc("isfile", missing("function", isfile))
addfunc("makefolder", missing("function", makefolder))
addfunc("isfolder", missing("function", isfolder))
addfunc("hookfunction", missing("function", hookfunction))
addfunc("hookmetamethod", missing("function", hookmetamethod))
addfunc("getnamecallmethod", missing("function", getnamecallmethod or get_namecall_method))
addfunc("checkcaller", missing("function", checkcaller, function() return false end))
addfunc("newcclosure", missing("function", newcclosure))
addfunc("readonly", missing("function", readonly))
addfunc("setreadonly", missing("function", setreadonly or make_readonly))
addfunc("makewritable", missing("function", makewritable or make_writable))
addfunc("isreadonly", missing("function", isreadonly or is_readonly))
addfunc("getrawmetatable", missing("function", getrawmetatable))
addfunc("getgc", missing("function", getgc or get_gc_objects))
-- Main Functions
local function BlockRE(obj)
  if not ClassType[obj.ClassName] then return end
  if not Settings.BlockedRemotes[obj] then
  local method = ClassFire[obj.ClassName]
  Settings.BlockedRemotes[obj] = true
    local old;
    old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
      if Settings.BlockedRemotes[obj] and getnamecallmethod() == method and self == obj then
        return nil
      end
      return old(self, ...)
    end))
  end
end
addfunc("BlockRE", BlockRE)
local function UnBlockRE(obj)
  if Settings.BlockedRemotes[obj] then
    Settings.BlockedRemotes[obj] = nil
  end
end
addfunc("UnBlockRE", UnBlockRE)
addfunc("say", function(...)
  print(...)
end)

addfunc("warnmsg", function(...)
  warn(...)
end)

addfunc("err", function(text)
  error("Error: " .. tostring(text))
end)

addfunc("service", function(Name)
  return game:GetService(Name)
end)
-- create (Instance)
addfunc("create", function(Name)
  return Instance.new(Name)
end)
-- fireclickdetector
addfunc("pfireclickd", function(obj)
    if not hrp then return end
    if obj:IsA("ClickDetector") then
      pcall(fireclickdetector, obj)
    end
end)
-- firetouchinterest
addfunc("pfiretouchinterest", function(touch, obj)
  if touch == plr or touch == char or touch == hrp then
    if not hrp then return end
    if obj:IsA("BasePart") then
      pcall(firetouchinterest, hrp, obj, 0)
    end
    return
  end
  if obj:IsA("BasePart") then
    pcall(firetouchinterest, touch, obj, 0)
  end
end)
-- fireproximitypromt
addfunc("pfireproximitypromt", function(obj)
  if not hrp then return end
    if obj:IsA("ProximityPrompt") then
      pcall(fireproximityprompt, obj)
    end
end)
game:GetService("RunService").Heartbeat:Connect(function()
  local env = (type(getgenv) == "function" and getgenv()) or _G
  if env.LCDebug then
    Settings.Debug = true
  elseif not env.LCDebug then
    Settings.Debug = false
  end
  if game:GetService("RunService"):IsStudio() then
    Settings.IsStudio = true
  else
    Settings.IsStudio = false
  end
end)
if getgenv then
  print("-----Light Coding-----")
  print("--Name: " .. LightCoding.Info.Name)
  print("--Version: " .. LightCoding.Info.Version)
  print("--Author: ")
  print("  --Auhor Name: " .. LightCoding.Info.Author.Name)
  print("  --URL: " .. LightCoding.Info.Author.URL)
  print("--Repository: " .. LightCoding.Info.Repository)
  print("--Description: " .. LightCoding.Info.Description)
end
return LightCoding
