local env = (type(getgenv) == "function" and getgenv()) or _G
if not game:IsLoaded() then game.Loaded:Wait() end
if env.LCLoaded then return "Light Coding Already Loaded!" end
local startTime = os.clock()
local function missing(t, f, fallback)
  if type(f) == t then return f end
  return fallback
end
local ModulFolder = "https://raw.githubusercontent.com/AbobaLua/LightCoding/Beta/Modules/"
local luaprefix = ".lua"
local LightCoding = {
  Info = {
    Name = "Light coding",
    Version = "1.21 Beta",
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
    Setup = {
      Hooks = {
        GlobalHookActivated = false,
        BlockRemoteInstall = false,
        HookRemoteInstall = false,
        SpeficHookInstall = false
      },
      RemoteList = {
        BlockedRemotes = {},
        HookedRemotes = {}
      },
      HooksSpecial = {
        HookedSpecial = {},
        HookedFunctions = {},
        HookedPropertyRead = {},
        HookedPropertyWrite = {}
      }
    },
    Modules = {
      LoadedModules = {},
      ["Extra"] = ModulFolder .. "Extra" .. luaprefix,
      ["Extra Functions"] = ModulFolder .. "Extra-Exploit-Functios" .. luaprefix
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
local Setup = Settings.Setup
local Hookses = Setup.Hooks
local BlockedRemotes = Setup.RemoteList.BlockedRemotes
local HookedRemotes = Setup.RemoteList.HookedRemotes
local HooksSpecial = Setup.HooksSpecial
local HookedSpecial = HooksSpecial.HookedSpecial
local HookedFunctions = HooksSpecial.HookedFunctions
local HookedPropertyRead = HookedSpecial.HookedPropertyRead
local HookedPropertyWrite = HookedSpecial.HookedPropertyWrite
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
  local loadTime = (os.clock() - startTime) * 1000  -- в миллисекундах
  print(string.format("Loaded in %.2f ms", loadTime))
end
local function console(...)
  if Settings and Settings.Debug then
    print("Light Coding Debug: ", ...)
  end
end
local function OutputLog(call, typelog, config)
  if not Log then return end
  if not call then return end
  if not typelog then return end
  if not config then return end
  if type(config) ~= "table" then return end
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
  args = {"..."}
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
local function AddFunc(name, func)
  if not name then return end
  if not (LightCoding and Functs) then return end
  if func and type(func) == "function" then
    Functs[name] = function(...)
      local args = {...}
      console("Calling: Function Name: " .. name .. tostring(func))
      OutputLog("Call", "Function", {name, func, args, false})
      return func(unpack(args))
    end
    OutputLog("Create", "Function", {name, func, false})
  end
end
local function AddCustomFunc(name, func, debug, debugtext)
  if not name then return end
  if not (LightCoding and CustomFuncts) then return end
  debug = debug or false
  if func and type(func) == "function" then
    CustomFuncts[name] = function(...)
      local args = {...}
      if debug then
        local text = tostring(debugtext)
        if text then
          console(text)
        end
      end
      OutputLog("Call", "Function", {name, func, args, true})
      return func(unpack(args))
    end
    OutputLog("Create", "Function", {name, func, true})
  end
end
local function AddMethod(Name, withself, func)
  if not Name then return end
  if not func then return end
  withself = withself or false
  if type(func) ~= "function" then return end
  if not LightCoding then return end
  if withself then
    LightCoding[Name] = function(self, ...)
      local args = {...}
      console("Calling Method: Name: " .. Name .. tostring(func))
      OutputLog("Call", "Method", {Name, func, args, false})
      return func(self, table.unpack(args))
    end
  else
    LightCoding[Name] = function(self, ...)
      local args = {...}
      console("Calling Method: Name: " .. Name .. tostring(func))
      OutputLog("Call", "Method", {Name, func, args, false})
      return func(table.unpack(args))
    end
  end
  OutputLog("Create", "Method", {Name, func, false})
end
local function AddCustomMethod(Name, withself, func)
  if not Name then return end
  if not func then return end
  withself = withself or false
  if type(func) ~= "function" then return end
  if not LightCoding then return end
  if withself then
    LightCoding[Name] = function(self, ...)
      local args = {...}
      console("Calling Method: Name: " .. Name .. tostring(func))
      OutputLog("Call", "Method", {Name, func, args, true})
      return func(self, table.unpack(args))
    end
  else
    LightCoding[Name] = function(self, ...)
      local args = {...}
      console("Calling Method: Name: " .. Name .. tostring(func))
      OutputLog("Call", "Method", {Name, func, args, true})
      return func(table.unpack(args))
    end
  end
  OutputLog("Create", "Method", {Name, func, true})
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
local ModuleAPI = {
  AddFunc = AddFunc,
  missing = missing
}
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
    return modulefunc(self, ModuleAPI)
  end)
  if not success then warn("Failed to load module :" .. name) return end
  cache[name] = result
  return result
end)
AddMethod("AddCustomMethod", false, AddCustomMethod)
AddMethod("AddCustomFunc", false, AddCustomFunc)
AddMethod("CallFunc", false, CallFunc)
AddMethod("GetFunc", false, GetFunc)
-- Main Functions
local function ControlHooks()
  Hookses.BlockRemoteInstall = next(BlockedRemotes) ~= nil
  Hookses.HookRemoteInstall = next(HookedRemotes) ~= nil
  Hookses.SpeficHookInstall = next(HookedSpecial) ~= nil
end
local function SetupRemotes()
  if Hookses.GlobalHookActivated then return end
  Hookses.GlobalHookActivated = true
  local old;
  old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local firemethod = ClassFire[self.ClassName]
    local class = ClassType[self.ClassName]
    if Hookses.BlockRemoteInstall and BlockedRemotes[self] and class and method == firemethod then
      return nil
    end
    local HookSpec = HookedSpecial[self]
    if Hookses.SpeficHookInstall and HookSpec and type(HookSpec) == "table" and HookSpec[method] then
      local CallBack = HookSpec[method]
      local newargs = CallBack({...})
      if type(newargs) == "table" then
        return old(self, table.unpack(newargs))
      else
        return
      end
    end
    local hookremote = HookedRemotes[self]
    if Hookses.HookRemoteInstall and hookremote and class and method == firemethod then
      local newargs = hookremote({...})
      if type(newargs) == "table" then
        return old(self, table.unpack(newargs))
      else
        return
      end
    end
    return old(self, ...)
  end))
  ControlHooks()
end
local function BlockRE(remote)
  if not remote then return end
  if not ClassType[remote.ClassName] then return end
  if not BlockedRemotes[remote] then
    if HookedRemotes[remote] then
      return "Remote Already Hooked!"
    end
    BlockedRemotes[remote] = true
    SetupRemotes()
    ControlHooks()
  end
end
local function UnBlockRE(remote)
  if not remote then return end
  if BlockedRemotes[remote] then
    BlockedRemotes[remote] = nil
    ControlHooks()
  end
end
-- Hooks
local function HookRE(remote, callback)
  if not remote then return end
  if type(callback) ~= "function" then return end
  if not ClassType[remote.ClassName] then return end
  if not HookedRemotes[remote] then
    if BlockedRemotes[remote] then
      return "Remote Already Blocked"
    end
    HookedRemotes[remote] = callback
    SetupRemotes()
    ControlHooks()
  end
end
local function UnHookRE(remote)
  if not remote then return end
  if HookedRemotes[remote] then
    HookedRemotes[remote] = nil
    ControlHooks()
  end
end
local function HookMethod(obj, method, callback)
  if not obj or not method or type(method) ~= "string" or type(callback) ~= "function" then return end
  if not HookedSpecial[obj] then
    HookedSpecial[obj] = {}
  elseif HookedSpecial[obj][method] then
    return "Method Already Hooked!"
  end
  HookedSpecial[obj][method] = callback
  SetupRemotes()
  ControlHooks()
end
local function UnHookMethod(obj, method)
  if not obj then return end
  if method then
    if HookedSpecial[obj] and HookedSpecial[obj][method] and type(HookedSpecial[obj]) == "table" then
      HookedSpecial[obj][method] = nil
      if next(HookedSpecial[obj]) == nil then
        HookedSpecial[obj] = nil
      end
      ControlHooks()
    end
  else
    HookedSpecial[obj] = nil
  end
end
local function HookFunction(targetfunc, newfunc)
  if not targetfunc or type(targetfunc) ~= "function" or not newfunc or type(newfunc) ~= "function" then return end
  if HookedFunctions[targetfunc] then
    return "Function Already Hooked!"
  end
  local original = targetfunc
  local success, hooked = pcall(hookfunction, targetfunc, newcclosure(newfunc))
  if not success then console("hookfunction Failed") return end
  HookedFunctions[targetfunc] = original
  return original
end
local function UnHookFunction(func)
  if not func or not HookedFunctions[func] then return end
  local original = HookedFunctions[func]
  local success = pcall(hookfunction, func, original)
  if not success then console("Failed to UnHook") return end
  HookedFunctions[func] = nil
end
local function HookPropertyRead(obj, callback)
  if not obj or type(callback) ~= "function" then return end
  if HookedPropertyRead[obj] then return "Property read already hooked on this object" end
  local mt = getrawmetatable(obj)
  if not mt then return "Metatable not found for object" end
  local original = mt.__index
  local hooked = newcclosure(function(self, key)
    local result = callback(self, key, original)
    if result ~= nil then return result end
    if original then
      if type(original) == "function" then
        return original(self, key)
      else
        return original[key]
      end
    end
    return nil
  end)
  mt.__index = hooked
  HookedPropertyRead[obj] = {original = original, hooked = hooked}
end
local function UnHookPropertyRead(obj)
  if not obj then return end
  local data = HookedPropertyRead[obj]
  if not data then return end
  local mt = getrawmetatable(obj)
  if mt then
    mt.__index = data.original
  end
  HookedPropertyRead[obj] = nil
end
local function HookPropertyWrite(obj, callback)
  if not obj or type(callback) ~= "function" then return end
  if HookedPropertyWrite[obj] then return "Property write already hooked on this object" end
  local mt = getrawmetatable(obj)
  if not mt then return "Metatable not found for object" end
  local original = mt.__newindex
  local hooked = newcclosure(function(self, key, value)
    local newValue = callback(self, key, value, original)
    if newValue == nil then return end
      if original then
        if type(original) == "function" then
          original(self, key, newValue)
        else
          original[key] = newValue
        end
      else
        rawset(self, key, newValue)
      end
  end)
  mt.__newindex = hooked
  HookedPropertyWrite[obj] = { original = original, hooked = hooked }
end
local function UnHookPropertyWrite(obj)
  if not obj then return end
  local data = HookedPropertyWrite[obj]
  if not data then return end
  local mt = getrawmetatable(obj)
  if mt then
    mt.__newindex = data.original
  end
  HookedPropertyWrite[obj] = nil
end
AddFunc("BlockRE", BlockRE)
AddFunc("UnBlockRE", UnBlockRE)
AddFunc("HookRE", HookRE)
AddFunc("UnHookRE", UnHookRE)
AddFunc("HookMethod", HookMethod)
AddFunc("UnHookMethod", UnHookMethod)
AddFunc("HookFunction", HookFunction)
AddFunc("UnHookFunction", UnHookFunction)
AddFunc("HookIndex", HookPropertyRead)
AddFunc("UnHookIndex", UnHookPropertyRead)
AddFunc("HookNewIndex", HookPropertyWrite)
AddFunc("UnHookNewIndex", UnHookPropertyWrite)
AddFunc("say", function(...)
  print(...)
end)
AddFunc("warnmsg", function(...)
  warn(...)
end)
AddFunc("service", function(Name)
  if not Name then return end
  return game:GetService(Name)
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
