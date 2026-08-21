return function(lib, api)
  local console = api.Console
  local Net = {
    Simple = {},
    Advanced = {},
    Utils = {},
    Configuration = {
      BlockMarker = "%%Block%%"
    },
  }
  local HooksState = {
    GlobalActivated = {
      HookNameCall = false,
      IndexHook = false,
      NewIndexHook = false
    },
    Installed = {
      BlockRemote = false,
      HookRemote = false,
      SpeficBlock = false,
      SpeficHook = false,
      BlockIndex = false,
      HookIndex = false,
      BlockNewIndex = false,
      HookNewIndex = false,
      HookIndexS = false,
      HookNewIndexS = false
    }
  }
  local Simple, Advanced, Utils, Configuration = Net.Simple, Net.Advanced, Net.Utils, Net.Configuration
  local HookInstall, GlobalActivate = HookState.Installed, HookState.GlobalActivated
  local BlockedRemotes, BlockedSpecial, BlockedFunctions, BlockedIndex, BlockedNewIndex = {}, {}, {}, {}, {}
  local HookedRemotes, HookedSpecial, HookedConnectSignal, HookedFunctions, HookedIndex, HookedNewIndex = {}, {}, {}, {}, {}, {}
  local HookedIndexS, HookedNewIndexS = {}, {}
  local function ControlHooks()
    local function check(t) 
      return next(t) ~= nil
    end
    HookInstall.BlockRemote = check(BlockedRemotes)
    HookInstall.HookRemote = check(HookedRemotes)
    HookInstall.SpeficBlock = check(BlockedSpecial)
    HookInstall.SpeficHook = check(HookedSpecial)
    HookInstall.BlockIndex = check(BlockedIndex)
    HookInstall.HookIndex = check(HookedIndex)
    HookInstall.BlockNewIndex = check(BlockedNewIndex)
    HookInstall.HookNewIndex = check(HookedNewIndex)
    HookInstall.HookIndexS = check(HookedIndexS)
    HookInstall.HookNewIndexS = check(HookedNewIndexS)
  end
  local ClassFire = {RemoteEvent = "FireServer", RemoteFunction = "InvokeServer", UnreliableRemoteEvent = "FireServer", BindableRemote = "Fire", BindableFunction = "Invoke"}
  local ClassType = {RemoteEvent = true, RemoteFunction = true, UnreliableRemoteEvent = true, BindableRemote = true, BindableFunction = true}
  local function SetupNameCall()
    if GlobalActivate.HookNameCall then return end
    GlobalActivate.HookNameCall = true
    local oldNamecall;
    oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
      local method = getnamecallmethod()
      local firemethod = ClassFire[self.ClassName]
      local class = ClassType[self.ClassName]
      if HookInstall.BlockRemote and BlockedRemotes[self] and class and method == firemethod then
        return nil
      end
      local BlockSpec = BlockedSpecial[self]
      if HookInstall.SpeficBlock and BlockSpec and BlockSpec[method] then
        return nil
      end
      local HookSpec = HookedSpecial[self]
      if HookInstall.SpeficHook and HookSpec and type(HookSpec) == "table" and HookSpec[method] then
        local CallBack = HookSpec[method]
        local newargs = CallBack({...})
        if type(newargs) == "string" and newargs == Configuration.BlockMarker then
          return
        elseif type(newargs) == "table" then
          return oldNamecall(self, table.unpack(newargs))
        end
      end
      local hookremote = HookedRemotes[self]
      if HookInstall.HookRemote and hookremote and class and method == firemethod then
        local newargs = hookremote({...})
        if type(newargs) == "string" and newargs == Configuration.BlockMarker then
          return
        elseif type(newargs) == "table" then
          return oldNamecall(self, table.unpack(newargs))
        end
      end
      return oldNamecall(self, ...)
    end))
  end
  local function SetupIndex()
    if GlobalActivate.IndexHook then return end
    GlobalActivate.IndexHook = true
    local oldIndex;
    oldIndex = hookmetamethod(game, "__index", newcclosure(function(self, property)
      if HookInstall.BlockIndex and BlockedIndex[self] then
        return nil
      end
      if HookInstall.HookIndex and HookedIndex[self] then
        local newval = HookedIndex[self](property)
        if newval == Configuration.BlockMarker then
          return nil
        elseif newval ~= nil then
          return newval
        end
      end
      if HookInstall.HookIndexS and HookedIndexS[self] and HookedIndexS[self][property] then
        return HookedIndexS[self][property]
      end
      return oldIndex(self, property)
    end))
  end
  local function SetupNewIndex()
    if GlobalActivate.NewIndexHook then return end
    GlobalActivate.NewIndexHook = true
    local oldNewIndex;
    oldNewIndex = hookmetamethod(game, "__newindex", newcclosure(function(self, property, newValue)
      if HookInstall.BlockNewIndex and BlockedNewIndex[self] then
        return nil
      end
      if HookInstall.HookNewIndex and HookedNewIndex[self] then
        local newval = HookedNewIndex[self](property, newValue)
        if newval == Configuration.BlockMarker then
          return nil
        elseif newval ~= nil then
          return oldNewIndex(self, property, newval)
        end
      end
      if HookInstall.HookNewIndexS and HookedNewIndexS[self] and HookedNewIndexS[self][property] then
        return oldNewIndex(self, property, HookedNewIndexS[self][property])
      end
      return oldNewIndex(self, property, newValue)
    end))
  end
  local function Simple.BlockRE(remote)
    if not remote then return end
    if not ClassType[remote.ClassName] then return end
    if not BlockedRemotes[remote] then
      if HookedRemotes[remote] then
        return "Remote Already Hooked!"
      end
      BlockedRemotes[remote] = true
      SetupNameCall()
      ControlHooks()
    end
  end
  local function Simple.UnBlockRE(remote)
    if not remote then return end
    if BlockedRemotes[remote] then
      BlockedRemotes[remote] = nil
      ControlHooks()
    end
  end
  function Advanced.HookRE(remote, callback)
    if not remote then return end
    if type(callback) ~= "function" then return end
    if not ClassType[remote.ClassName] then return end
    if not HookedRemotes[remote] then
      if BlockedRemotes[remote] then
        return "Remote Already Blocked"
      end
      HookedRemotes[remote] = callback
      SetupNameCall()
      ControlHooks()
    end
  end
  function Advanced.UnHookRE(remote)
    if not remote then return end
    if HookedRemotes[remote] then
      HookedRemotes[remote] = nil
      ControlHooks()
    end
  end
  function Simple.BlockMethod(obj, method)
    if not obj then return end
    if not method then return end
    if not BlockedSpecial then
      BlockedSpecial[obj] = {}
    elseif BlockedSpecial[obj][method] then
      return "Method Already Hooked!"
    end
    BlockedSpecial[obj][method] = true
    SetupNameCall()
    ControlHooks()
  end
  function Simple.UnBlockMethod(obj, method)
    if not obj then return end
    if method then
      if BlockedSpecial[obj] and BlockedSpecial[obj][method] then
        BlockedSpecial[obj][method] = nil
        if next(BlockedSpecial[obj]) == nil then
          BlockedSpecial[obj] = nil
        end
        ControlHooks()
      end
    else
      BlockedSpecial[obj] = nil
    end
  end 
  function Advanced.HookMethod(obj, method, callback)
    if not obj or not method or type(method) ~= "string" or type(callback) ~= "function" then return end
    if not HookedSpecial[obj] then
      HookedSpecial[obj] = {}
    elseif HookedSpecial[obj][method] then
      return "Method Already Hooked!"
    end
    HookedSpecial[obj][method] = callback
    SetupNameCall()
    ControlHooks()
  end
  function Advanced.UnHookMethod(obj, method)
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
  function Advanced.HookOnClientEvent(obj, callback)
    if not obj or not callback or type(callback) ~= "function" then return end
    local signal = obj.OnClientEvent
    if not signal then return "Invalid Object, Object no have OnClientEvent" end
    if not HookedConnectSignal[obj] then
      HookedConnectSignal[obj] = {}
    end
    for _, Connection in getconnections(signal) do  
      local old; old = hookfunction(Connection.Function, function(...)
        local args = {...}
        local result = callback(args)
        if result == Configuration.BlockMarker then
          return
        elseif type(result) == "table" then
          return old(table.unpack(result))
        end
        return old(table.unpack(args))
      end)
      HookedConnectSignal[obj][Connection] = old
    end
  end
  function Advanced.UnHookOnClientEvent(obj)
    if not obj or not HookedConnectSignal[obj] then return end
    local signal = obj.OnClientEvent
    if not signal then return "Invalid Object, Object no have OnClientEvent" end
    for _, conn in ipairs(getconnections(signal)) do
      local original = HookedConnectSignal[obj][conn]
      if original then
        if type(restorefunction) == "function" then
          restorefunction(original)
        elseif type(hookfunction) == "function" then
          hookfunction(conn.Function, original)
        else
          warn("Unable to restore: neither restorefunction nor hookfunction available")
        end
      end
    end
    HookedConnectSignal[obj] = nil
  end
  function Simple.BlockFunction(targetfunc)
    if not targetfunc or type(targetfunc) ~= "function" then return end
    if BlockedFunctions[targetfunc] then
      return "Function Already Blocked!"
    end
    local original = targetfunc
    local success, hooked = pcall(hookfunction, targetfunc, newcclosure(function()
      return nil
    end))
    if not success then console("hookfunction Failed") return end
    BlockedFunctions[targetfunc] = original
    return original
  end
  function Simple.UnBlockFunction(func)
    if not func or not BlockedFunctions[func] then return end
    local original = BlockedFunctions[func]
    if restorefunction then
      local success = pcall(restorefunction, func)
    else
      local success = pcall(hookfunction, func, original)
    end
    if not success then console("Failed to UnBlock") return end
    BlockedFunctions[func] = nil
  end
  function Advanced.HookFunction(targetfunc, newfunc)
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
  function Advanced.UnHookFunction(func)
    if not (func and HookedFunctions[func]) then return end
    local original = HookedFunctions[func]
    if restorefunction then
      local success = pcall(restorefunction, func)
    else
      local success = pcall(hookfunction, func, original)
    end
    if not success then console("Failed to UnHook") return end
    HookedFunctions[func] = nil
  end
  function Simple.BlockIndex(obj, property)
    if not obj or not property then return end
    if BlockedIndex[obj][property] then return "Index Property already Blocked on this object" end
    if not BlockedIndex[obj] then
      BlockedIndex[obj] = {}
    end
    BlockedIndex[obj][property] = true
    SetupIndex()
    ControlHooks()
  end
  function Simple.UnBlockIndex(obj, property)
    if not obj or not property or not BlockedIndex[obj] then return end
    if property and BlockedIndex[obj][property] then
      BlockedIndex[obj][property] = nil
    else
      BlockedIndex[obj] = nil
    end
    ControlHooks()
  end
  function Advanced.HookIndex(obj, callback)
    if not (obj and callback and type(callback) == "function") then return end
    if HookedIndex[obj] then return "Index already hooked on this object" end
    HookedIndex[obj] = callback
    SetupIndex()
    ControlHooks()
  end
  function Advanced.UnIndex(obj)
    if not obj then return end
    if not HookedIndex[obj] then return "" end
    HookedIndex[obj] = nil
    ControlHooks()
  end
  function Simple.HookIndex(obj, property, value)
    if not obj or not property or not value then return end
    if not HookedIndexS[obj] then HookedIndexS[obj] = {} end
    if HookedIndexS[obj][property] then return "Property already hooked on this object" end
    HookedIndexS[obj][property] = value
    SetupIndex()
    ControlHooks()
  end
  function Simple.UnHookIndex(obj, property)
    if not obj or not HookedIndexS[obj] then return end
    if property and HookedIndexS[obj][property] then
      HookedIndexS[obj][property] = nil
    else
      HookedIndexS[obj] = nil
    end
    ControlHooks()
  end
  function Simple.BlockNewIndex(obj, property)
    if not obj or not property then return end
    if not BlockedNewIndex[obj] then
      BlockedNewIndex[obj] = {}
    end
    if BlockedNewIndex[obj][property] then return "Property already blocked on this object" end
    BlockedNewIndex[obj][property] = true
    SetupNewIndex()
    ControlHooks()
  end
  function Simple.UnBlockNewIndex(obj, property)
    if not obj or not BlockedNewIndex[obj] then return end
    if property and BlockedNewIndex[obj][property] then
      BlockedNewIndex[obj][property] = nil
    else
      BlockedNewIndex[obj] = nil
    end
    ControlHooks()
  end
  function Advanced.HookNewIndex(obj, callback)
    if not obj or type(callback) ~= "function" then return end
    if HookedNewIndex[obj] then return "NewIndex already hooked on this object" end
    HookedNewIndex[obj] = callback
    SetupNewIndex()
    ControlHooks()
  end
  function Advanced.UnNewIndex(obj)
    if not obj then return end
    if not HookedNewIndex[obj] then return end
    HookedNewIndex[obj] = nil
    ControlHooks()
  end
  function Simple.HookNewIndex(obj, property, value)
    if not obj or not property or not value then return end 
    if not HookedNewIndexS[obj] then
      HookedNewIndexS[obj] = {}
    end
    if HookedNewIndexS[obj][property] then return "Property already hooked pn this object" end
    HookedNewIndexS[obj][property] = value
    SetupNewIndex()
    ControlHooks()
  end
  function Simple.UnHookNewIndex(obj, property)
    if not obj or not HookedNewIndexS[obj] then return end
    if property and HookedNewIndexS[obj][property] then
      HookedNewIndexS[obj][property] = nil
    else
      HookedNewIndexS[obj] = nil
    end
    ControlHooks()
  end
  function Net.Utils.ScanRemotes()
    local remotes = {}
    local function scan(container)
      for _, child in ipairs(container:GetChildren()) do
        local className = child.ClassName
        if ClassType[className] then
          table.insert(remotes, {
            Name = child.Name,
            Path = child:GetFullName(),
            Class = className,
            Ref = child
          })
        end
        scan(child)
      end
    end
    scan(game)
    return remotes
  end
  function Net.Utils.FireRemote(remote, ...)
    if not remote then return end
    local methodName = ClassFire[remote.ClassName]
    if not methodName then return warn("Unsupported remote class") end
    local method = remote[methodName]
    if not method then return warn("Method not found") end
    if methodName == "InvokeServer" or methodName == "Invoke" then
      return method(remote, ...)
    else
      method(remote, ...)
    end
  end
  function Utils.ClearAllHooks()
    for obj in pairs(HookedIndex) do Advanced.UnHookIndex(obj) end
    for obj in pairs(HookedNewIndex) do Advanced.UnHookNewIndex(obj) end
    for obj in pairs(HookedIndexS) do Simple.UnHookIndex(obj) end
    for obj in pairs(HookedNewIndexS) do Simple.UnHookNewIndex(obj) end
    for obj in pairs(HookedSpecial) do Advanced.UnHookMethod(obj) end
    for func in pairs(HookedFunctions) do Advanced.UnHookFunction(func) end
    for remote in pairs(HookedRemotes) do Advanced.UnHookRE(remote) end
    ControlHooks()
  end
  function Utils.ClearAllBlocks()
    for remote in pairs(BlockedRemotes) do Simple.UnBlockRE(remote) end
    for obj in pairs(BlockedSpecial) do Simple.UnBlockMethod(obj) end
    for func in pairs(BlockedFunctions) do Simple.UnBlockFunction(func) end
    for obj in pairs(BlockedIndex) do Simple.UnBlockIndex(obj) end
    for obj in pairs(BlockedNewIndex) do Simple.UnBlockNewIndex(obj) end
    ControlHooks()
  end
  function Net.Utils.ClearAll()
    Utils.ClearAllHooks()
    Utils.ClearAllBlocks()
  end
  return Net
end