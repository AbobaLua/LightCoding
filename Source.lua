local env = (type(getgenv) == "function" and getgenv()) or _G
if not game:IsLoaded() then game.Loaded:Wait() end
if env.LCLoaded then return "Light Coding Already Loaded!" end
local startTime = os.clock()
local function missing(t, f, fallback)
  if type(f) == t then return f end
  return fallback
end
local form
form = function(txt)
  return ("https://raw.githubusercontent.com/AbobaLua/LightCoding/Beta/Modules/" .. txt .. ".lua")
end
local LightCoding = {
  Info = {
    Name = "Light coding",
    Version = "1.22 Beta",
    Author = {
      Name = "AbobaLua",
      URL = "https://github.com/AbobaLua"
    },
    Repository = "https://github.com/AbobaLua/LightCoding",
    Description = "Simple Coding Library"
  },
  Settings = {
    Loaded = false,
    Debug = false,
    IsStudio = false,
    AliasMap = {},
    Events = {
      Listeners = {}
    },
    Modules = {
      LoadedModules = {},
      ["Extra"] = form("Extra"),
      ["Extra Functions"] = form("Extra-Exploit-Functios"),
      ["Net"] = form("Net"),
      ["Player"] = form("Player"),
      ["ESP"] = form("Esp"),
      ["GUI"] = form("Gui")
    }
  },
  Functs = {},
  CustomFuncts = {},
  Log = {},
}
-- For Work Stuff
local safeget = missing("function", cloneref, function(...) return ... end)
local Services = setmetatable({}, {
  __index = function(self, name)
    local success, cache = pcall(function()
      return safeget(game:GetService(name))
    end)
    if success then
      rawset(self, name, cache)
      return cache
    else
      warn("Invalid Service: " .. tostring(name))
    end
  end
})
local Players = Services.Players
local RunService = Services.RunService
local plr = safeget(Players.LocalPlayer)
local char = safeget(plr.Character) or safeget(plr.CharacterAdded:Wait())
local hrp = char and safeget(char:FindFirstChild("HumanoidRootPart"))
plr.CharacterAdded:Connect(function(character)
  char = character
  hrp = char:WaitForChild("HumanoidRootPart")
end)
local Info = LightCoding.Info
local Settings = LightCoding.Settings
local AliasMap = Settings.AliasMap
local Functs = LightCoding.Functs
local CustomFuncts = LightCoding.CustomFuncts
local Log = LightCoding.Log
local LogAmmount = 0
local function Initialization()
  local function form1(k, v) return string.format("--%s : %s", k, v) end
  local function form2(k, v) return string.format("  --%s : %s", k, v) end
  print("-----Light Coding-----")
  print(form1("Name", Info.Name))
  print(form1("Version", Info.Version))
  print(form1("Author", ""))
  print(form2("Author Name", Info.Author.Name))
  print(form2("Author URL", Info.Author.URL))
  print(form1("Repository", Info.Repository))
  print(form1("Description", Info.Description))
  RunService.Heartbeat:Connect(function()
    if env.LCDebug then
      Settings.Debug = true
    elseif not env.LCDebug then
      Settings.Debug = false
    end
    if RunService:IsStudio() then
      Settings.IsStudio = true
    else
      Settings.IsStudio = false
    end
  end)
  if LightCoding and Settings then
    Settings.Loaded = true
  end
  env.LCLoaded = true
  local loadTime = (os.clock() - startTime) * 1000
  print(string.format("Loaded in %.2f ms", loadTime))
end
local function console(...)
  if Settings and Settings.Debug then
    print("Light Coding Debug: ", ...)
  end
end
local function OutputLog(call, typelog, config)
  if not (Log and call and typelog and config and type(config) == "table") then return end
  if call == "Create" then
    local info = debug.getinfo(config[2])
    local args = {}
    if info and info.nparams then
      if info.nameparams then
        for i = 1, info.nparams do
          args[i] = info.nameparams[i] or "arg"..i
        end
      else
        for i = 1, info.nparams do
          args[i] = "arg"..i
        end
      end
    else
      if info.is_vararg or info.isvararg then
        args = {"..."}
      else 
        args = {}
      end
    end
    Log[call .. typelog .. LogAmmount] = {
      Name = config[1],
      Function = config[2],
      Args = args,
      IsCustom = config[3],
      CreateTime = os.date("%H:%M:%S")
    }
    LogAmmount = LogAmmount + 1
  elseif call == "Call" then
    Log[call .. typelog .. LogAmmount] = {
      Name = config[1],
      Function = config[2],
      Args = config[3],
      IsCustom = config[4],
      CallTime = os.date("%H:%M:%S")
    }
    LogAmmount = LogAmmount + 1
  end
end
local ClassFire = {RemoteEvent = "FireServer", RemoteFunction = "InvokeServer", UnreliableRemoteEvent = "FireServer", BindableRemote = "Fire", BindableFunction = "Invoke"}
local ClassType = {RemoteEvent = true, RemoteFunction = true, UnreliableRemoteEvent = true, BindableRemote = true, BindableFunction = true}
local function AddFunc(name, func, alias)
  if not (name and func and type(func) == "function" and Functs) then return end
  Functs[name] = function(...)
    local args = {...}
    console("Calling: Function Name: " .. name .. " " .. tostring(func))
    OutputLog("Call", "Function", {name, func, args, false})
    return func(table.unpack(args))
  end
  if alias and type(alias) == "table" then
    for _, nameali in ipairs(alias) do
      AliasMap[nameali] = Functs[name]
    end
  end
  OutputLog("Create", "Function", {name, func, false})
end
local function AddCustomFunc(name, func, alias, debug, debugtext)
  if not (name and func and CustomFuncts) then return end
  debug = debug or false
  if type(func) ~= "function" then return end
  CustomFuncts[name] = function(...)
    local args = {...}
    if debug then
      local text = tostring(debugtext)
      if text then
        console(text)
      end
    end
    OutputLog("Call", "Function", {name, func, args, true})
    return func(table.unpack(args))
  end
  if alias and type(alias) == "table" then
    for _, nameali in ipairs(alias) do
      AliasMap[nameali] = CustomFuncts[name]
    end
  end
  OutputLog("Create", "Function", {name, func, true})
end
local function AddMethod(Name, withself, func)
  if not (Name and func) then return end
  withself = withself or false
  if type(func) ~= "function" then return end
  if withself then
    LightCoding[Name] = function(self, ...)
      local args = {...}
      console("Calling Method: Name: " .. Name .. " " .. tostring(func))
      OutputLog("Call", "Method", {Name, func, args, false, false})
      return func(self, table.unpack(args))
    end
  else
    LightCoding[Name] = function(self, ...)
      local args = {...}
      console("Calling Method: Name: " .. Name .. " " .. tostring(func))
      OutputLog("Call", "Method", {Name, func, args, false, false})
      return func(table.unpack(args))
    end
  end
  OutputLog("Create", "Method", {Name, func, false, false})
end
local function AddCustomMethod(Name, withself, func)
  if not (Name and func) then return end
  withself = withself or false
  if type(func) ~= "function" then return end
  if withself then
    LightCoding[Name] = function(self, ...)
      local args = {...}
      console("Calling Method: Name: " .. Name .. " " .. tostring(func))
      OutputLog("Call", "Method", {Name, func, args, true, false})
      return func(self, table.unpack(args))
    end
  else
    LightCoding[Name] = function(self, ...)
      local args = {...}
      console("Calling Method: Name: " .. Name .. " " .. tostring(func))
      OutputLog("Call", "Method", {Name, func, args, true, false})
      return func(table.unpack(args))
    end
  end
  OutputLog("Create", "Method", {Name, func, true, false})
end
local function CallFunc(name, ...)
  if not (Functs and CustomFuncts) then return end
  local func = Functs[name] or CustomFuncts[name] or AliasMap[Name]
  if not func then
    error("Function: " .. tostring(name), " Not Found")
    return nil
  end
  return func(...)
end
local function GetFunc(Name)
  if not (Name and Functs and CustomFuncts) then return end
  local Func = Functs[Name] or CustomFuncts[Name] or AliasMap[Name]
  if Func then
    return Func
  else
    error("Function: ", tostring(Name), "Not Found")
  end
end
local function GetMethod(self, Name)
  if not Name then return end
  local method = self[Name]
  if type(method) ~= "function" then return end
  if not method then warn("Method: " .. method " Not Found!") return end
  return function(...)
    return method(self, ...)
  end
end
local ModuleAPI = {
  missing = missing,
  Console = console,
  SafeGet = safeget,
  Services = Services,
  Player = plr,
  Character = char,
  HumanoidRootPart = hrp
}
function ModuleAPI.Subscribe(event, callback)
  if not Settings.Events.Listeners[event] then
    Settings.Events.Listeners[event] = {}
  end
  table.insert(Settings.Events.Listeners[event], callback)
end
function ModuleAPI.Unsubscribe(event, callback)
  local list = Settings.Events.Listeners[event]
  if not list then return end
  for i, cb in ipairs(list) do
    if cb == callback then
      table.remove(list, i)
      break
    end
  end
end
function ModuleAPI.Publish(event, ...)
  local list = Settings.Events.Listeners[event]
  if not list then return end
  for _, callback in ipairs(list) do
    local success, err = pcall(callback, ...)
    if not success then
      warn("Event error: " .. tostring(err))
    end
  end
end
-- Methods
AddMethod("IsLoaded", true, function(self)
  return self.Settings.Loaded
end)
AddMethod("WaitForLoad", true, function(self)
  while not self.Settings.Loaded do
    RunService.Heartbeat:Wait()
  end
  return true
end)
AddMethod("Delete", true, function(self)
  for k in pairs(self) do
    self[k] = nil
  end
  env.LCLoaded = false
  setmetatable(self, nil)
  print("Bye LightCoding")
end)
AddMethod("ClearLog", true, function(self)
  for i, v in pairs(self.Log) do
    self.Log[i] = nil
  end
end)
AddMethod("LoadModule", true, function(self, name)
  if not name or name == "LoadedModules" then return end
  local modulelink = self.Settings.Modules[name]
  if not modulelink then return end
  local cache = self.Settings.Modules.LoadedModules
  if cache[name] then return cache[name] end
  local success, result = pcall(function()
    local code = game:HttpGet(modulelink)
    local modulefunc = loadstring(code)
    if not modulefunc then
      error("loadstring return nil")
    end
    return modulefunc(self, ModuleAPI)
  end)
  if not success then
    if env.LCDebug then
      warn("LoadModule: failed to load '" .. name .. "' – " .. tostring(result))
      warn("Stack trace: " .. debug.traceback())
      warn("Failed to load module: " .. name)
    end
    return
  end
  cache[name] = result
  return result
end)
AddMethod("AddCustomMethod", false, AddCustomMethod)
AddMethod("AddCustomFunc", false, AddCustomFunc)
AddMethod("CallFunc", false, CallFunc)
AddMethod("GetFunc", false, GetFunc)
AddMethod("GetMethod", true, GetMethod)
-- Main Functions
local function DeepCopy(t)
  if type(t) ~= "table" then return t end
  local copy = {}
  for k, v in pairs(t) do
    copy[DeepCopy(k)] = DeepCopy(v)
  end
  return copy
end
AddFunc("DeepCopy", DeepCopy)
local function Merge(t1, t2)
  local result = DeepCopy(t1)
  for k, v in pairs(t2) do
    if type(v) == "table" and type(result[k]) == "table" then
      result[k] = Merge(result[k], v)
    else
      result[k] = v
    end
  end
  return result
end
AddFunc("Merge", Merge)
local function FindInTable(t, mode, value)
  if not mode or mode ~= "string" or not value then return end
  if type(t) ~= "table" then return end
  if mode == "Value" then
    for k, v in pairs(t) do
      if v == value then return k end
    end
  elseif mode == "Key" then
    for k, v in pairs(t) do
      if k == value then return v end
    end
  end
  return nil
end
AddFunc("FindInTable", FindInTable)
AddFunc("say", function(...)
  print(...)
end)
AddFunc("warnmsg", function(...)
  warn(...)
end)
AddFunc("service", function(Name)
  if not Name then return end
  return safeget(game:GetService(Name))
end)
AddFunc("create", function(Name)
  if not Name then return end
  return Instance.new(Name)
end)
AddFunc("pfireclickd", function(obj)
  if not obj or not hrp then return end
  if obj:IsA("ClickDetector") then
    pcall(fireclickdetector, obj)
  end
end)
AddFunc("pfiretouchinterest", function(touch, obj)
  if not obj or not touch then return end
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
AddFunc("pfireproximitypromt", function(obj)
  if not hrp or not obj then return end
  if obj:IsA("ProximityPrompt") then
    pcall(fireproximityprompt, obj)
  end
end)
Initialization()
return LightCoding