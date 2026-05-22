local env = (type(getgenv) == "function" and getgenv()) or _G
if env.LCLoaded then return end
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
  Loaded = false,
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
local function AddFunc(name, func)
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
LightCoding.AddCustomFunc = function(self, name, func, debug, debugtext)
  AddCustomFunc(name, func, debug, debugtext)
end
local function CallFunc(name, ...)
  if not LightCoding then return end
  if Functs and CustomFuncts then
    local func = Functs[name] or CustomFuncts[name]
    if not func then
      error("Function: " .. tostring(name), "Not Found")
      return nil
    end
    return func(...)
  end
end
local function GetFunc(Name)
  if not Name then return end
  local Func = Functs[Name] or CustomFuncts[Name]
  if Func then
    return Func
  else
    error("Function: ", tostring(Name), "Not Found")
  end
end
LightCoding.CallFunc = function(self, Name, ...)
  CallFunc(Name, ...)
end
LightCoding.GetFunc = function(self, Name)
  return GetFunc(Name)
end
AddFunc("getgenv", missing("function", (getgenv and getgenv())))
AddFunc("getfenv", missing("function", (getfenv and getfenv())))
AddFunc("getrenv", missing("function", (getrenv and getrenv())))
AddFunc("fireclickdetector", missing("function", fireclickdetector))
AddFunc("firetouchinterest", missing("function", firetouchinterest))
AddFunc("fireproximityprompt", missing("function", fireproximityprompt))
AddFunc("firesignal", missing("function", firesignal))
AddFunc("executor", missing("function", identifyexecutor or getexecutorname or (syn and syn.getexecutorname)))
AddFunc("clipboard", missing("function", setclipboard or toclipboard or set_clipboard or writeclipboard or (Clipboard and Clipboard.set)))
AddFunc("writefile", missing("function", writefile))
AddFunc("readfile", missing("function", readfile))
AddFunc("isfile", missing("function", isfile))
AddFunc("makefolder", missing("function", makefolder))
AddFunc("isfolder", missing("function", isfolder))
AddFunc("hookfunction", missing("function", hookfunction or detour_function))
AddFunc("hookmetamethod", missing("function", hookmetamethod))
AddFunc("getnamecallmethod", missing("function", getnamecallmethod or get_namecall_method))
AddFunc("checkcaller", missing("function", checkcaller, function() return false end))
AddFunc("newcclosure", missing("function", newcclosure))
AddFunc("readonly", missing("function", readonly))
AddFunc("setreadonly", missing("function", setreadonly or make_readonly))
AddFunc("makewritable", missing("function", makewritable or make_writable))
AddFunc("isreadonly", missing("function", isreadonly or is_readonly))
AddFunc("getrawmetatable", missing("function", getrawmetatable))
AddFunc("getgc", missing("function", getgc or get_gc_objects))
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
AddFunc("BlockRE", BlockRE)
local function UnBlockRE(obj)
  if Settings.BlockedRemotes[obj] then
    Settings.BlockedRemotes[obj] = nil
  end
end
AddFunc("UnBlockRE", UnBlockRE)
AddFunc("say", function(...)
  print(...)
end)

AddFunc("warnmsg", function(...)
  warn(...)
end)

AddFunc("service", function(Name)
  return game:GetService(Name)
end)
-- create (Instance)
AddFunc("create", function(Name)
  return Instance.new(Name)
end)
-- fireclickdetector
AddFunc("pfireclickd", function(obj)
    if not hrp then return end
    if obj:IsA("ClickDetector") then
      pcall(fireclickdetector, obj)
    end
end)
-- firetouchinterest
AddFunc("pfiretouchinterest", function(touch, obj)
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
AddFunc("pfireproximitypromt", function(obj)
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
Settings.Loaded = true
env.LCLoaded = true
return LightCoding
