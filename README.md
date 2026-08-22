## Work in Progress(WIP)
---
## Light Coding
Make your coding easier!
### Loadstring
```lua
local LightCoding = loadstring(game:HttpGet("https://raw.githubusercontent.com/AbobaLua/LightCoding/Beta/Source.lua"))()
```
---

### Methods
#### CallFunc() - Call Function
Arguments - Unlimited (1, Unlimited)  
First argument - name to call the function (required)  
Seconds arguments - arguments of the called function (optional or required)
```lua
LightCoding:CallFunc("say", "Hello")
```
#### GetFunc() - Get Function
Arguments - 1  
First Argument - Func for the get (required)  
```lua
local newsay = LightCoding:GetFunc("say")
newsay("Hello")
```
#### GetMethod() - Get Method
Arguments - 1  
First argument - Method for the get (required)  
```lua
local call = LightCoding:GetMethod("CallFunc")
call("say", "Hello")
```
#### IsLoaded() - Loading check
Arguments - 0 (None)  
Returns the loaded status of LightCoding (true/false)  
```lua
LightCoding:IsLoaded()
```
#### WaitForLoad() - Wait for load LightCoding
Arguments - 0 (None)  
Works like a regular WaitForChild()  
```lua
LightCoding:WaitForLoad()
```
#### LoadModule() - Load Module
Arguments - 1  
First argument - name of Module  
Modules: Extra, Extra Functions, Net, Player, ESP, GUI  
```lua
local Extra = LightCoding:LoadModule("Extra")
```
#### ClearLog() - Clear Log
Arguments - 0 (None)  
```lua
LightCoding:ClearLog()
```
#### Delete() - Delete Script
Arguments - 0 (None)  
```lua
LightCoding:Delete()
```
---

### Functions
#### say() - print text
Arguments - Unlimited (optional)  
```lua
LightCoding:CallFunc("say", "hi")
-- Print hello to the console
```
#### warnmsg() - warn message
Arguments - Unlimited (optional)  
```lua
LightCoding:CallFunc("warnmsg", "Warning")
-- Print ⚠️ Warning to the console
```
#### service() - get service
Arguments - 1  
First argument - Name of Service (required)  
```lua
LightCoding:CallFunc("service", "Players")
-- Get Players Service
```
#### create() - Creates an object with the class name
Arguments - 1  
First argument - NameClass of Creating obj  
```lua
LightCoding:CallFunc("create", "Part")
-- Create Part
```
#### pfireclickd() - Fire ClickDetector
Arguments - 1  
First argument - clickdetector for fire (required)  
```lua
LightCoding:CallFunc("pfireclickd", workspace.ClickDetector)
-- Fire clickdetector in workspace
```
#### pfiretouchinterest() - Fire TouchInterest
Need obj class - "BasePart"  
Arguments - 2  
First argument - obj to touch by second obj (required)  
Second argument - obj by touch the first obj (required)  
Advantages:
You can transfer a player or his character and it will also work
```lua
LightCoding:CallFunc("pfiretouchinterest", game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Part)
-- Touch workspace.Part by using Player HumanoidRootPart
```
#### pfireproximitypromt() - Fire Proximity Prompt
Arguments - 1  
First argument - pfireproximityprompt for proximityprompt (required)  
```lua
LightCoding:CallFunc("pfireproximitypromt", workspace.ProximityPrompt)
-- fire proximityprompt in workspace
```
---

### Modules

#### Net

#### BlockRE() - Block remote calls (already existed, but now compatible)

Arguments - 1  
First argument - remote for block (required)  
```lua
local Net = LightCoding:LoadModule("Net")
Net.Simple.BlockRE(game.workspace.RemoteEvent)
```
#### BlockMarker - you can change marker for block
BlockMarker need to block call if you don't return BlockMarker or newargs will return original call  
Default Block Marker - "%%Block%%"  
Change the block marker:
```lua
Net.Configuration.BlockMarker = "%Block%"
```
#### UnBlockRE() - UnBlock remote
Arguments - 1  
First argument - remote for unblock (required)  
```lua
Net.Simple.UnBlockRE(game.workspace.RemoteEvent)
```
#### HookRE() - Intercept RemoteEvent/RemoteFunction or other Event calls
Allows you to intercept "FireServer" (RemoteEvent) or InvokeServer (RemoteFunction) or other calls.  
You can view or modify arguments, or block the call entirely.  
Arguments - 2  
First argument - remote for hook (required)  
Second argument - new function for remote (required)  
First function argument - table of arguments remote (required)  
Warning:
If you don't return any arguments, the call will original  
If you want to Block return BlockMarker - default: "%%Block%%"
```lua
Net.Advanced.HookRE(game.workspace.RemoteEvent, function(args)
  print("Hooked!") -- Is will Blocked and print "Hooked!" when they call
end)
```
The correct path so that remove is not blocked
```lua
Net.Advanced.HookRE(game.workspace.RemoteEvent, function(args)
  print("Hooked!")
  return args
end)
```
Example:
```lua
Net.Advanced.HookRE(game.workspace.RemoteEvent, function(args)
  print("Hooked!")
  return args
end)
```
Other Examples:  
1: Hook of argument number one
```lua
Net.Advanced.HookRE(game.workspace.RemoteEvent, function(args)
  args[1] = 10
  return args
end)
```
2: Prints and returns the previous arguments
```lua
Net.Advanced.HookRE(game.workspace.RemoteEvent, function(args)
  print("Hooked with args: ", unpack(args))
  return args
end)
```
#### UnHookRE() - UnHook Remote
Arguments - 1  
First argument - remote for unhook (required)  
```lua
Net.Advanced.UnHookRE(game.workspace.RemoteEvent)
```
#### BlockMethod() - Block Method
Arguments - 2  
First argument - object for block (required)  
Second - method for block (required)  
```lua
Net.Simple.BlockMethod(game.workspace.Part, "Destroy")
```
#### UnBlockMethod() - UnBlock method
Arguments - 2  
First argument - object for unblock (required)  
Second argument - method for unblock (optional)  
```lua
Net.Simple.UnBlockMethod(game.workspace.Part, "Destroy")
```
#### HookMethod() - Hook object method
Arguments - 3  
First argument - object for hook (required)  
Second argument - method for hook (required)  
Third argument - new function to object method (required)  
First function argument - table of arguments object method  
Warning:
If you don't return any arguments, the call will original  
If you want to Block return BlockMarker - default: "%%Block%%"  
Example:
```lua
Net.Advanced.HookMethod(game.workspace.Part, "Destroy", function(args)
  print("Attempt to Destroy Part")
  return args
end)
```
Example 2:
```lua
Net.Advanced.HookMethod(game.workspace.Part, "Clone", function(args)
  print("Attempt to Clone Part: Blocking")
  return nil
end)
```
#### Note: HookMethod can hook multiple methods on an object
#### UnHookMethod() - UnHook object method
Arguments - 2  
First argument - object for UnHook (required)  
Second argument - method for unhook (optional)  
```lua
Net.Advanced.UnHookMethod(game.workspace.Part, "Destroy")
```
#### Note: A remote cannot be hooked and blocked at the same time
If you try to hook a blocked remote, it will return warning line  
#### BlockFunction() - Block Function
Arguments - 1  
First argument - function for block (required)
```lua
local oldprint = Net.Simple.BlockFunction(print)
```
#### UnBlockFunction() - UnHook Function
Arguments - 1  
First Arguments - function for unhook (required)
```lua
Net.Simple.UnBlockFunction(print)
```
#### HookFunction() - Hook Function  
Arguments - 2  
First argument - function for Hook (required)  
Second argument - new function (required)  
Note: if you call HookFunction it return original function
```lua
local oldprint = Net.Advanced.HookFunction(print, function(...)
  print("Hoked with args: ", ...)
  oldprint(...)
end)
```
#### UnHookFunction() - UnHook Function
Arguments - 1  
First argument - function for unhook (required)
```lua
Net.Advanced.UnHookFunction(print)
```
#### BlockIndex() - Block Index - block property reads
Arguments - 2  
First argument - object index for block (required)  
Second argument - property for block (required)
```lua
Net.Simple.BlockIndex(game.workspace.Part, "Name")
```
#### UnBlockIndex() - UnBlock Index
Arguments - 2  
First argument - object index for unblock (required)  
Second argument - property for unblock (optional)
```lua
Net.UnSimple.BlockIndex(game.workspace.Part, "Name")
```
#### Simple.HookIndex() - Hook Index - intercept property reads
Arguments - 3  
First argument - object index for hook (required)  
Second argument - property for hook (required)  
Third argument - newvalue for hook (required)
```lua
Net.Simple.HookIndex(game.workspace.Part, "Name", "Hooked!")
```
#### Simple.UnHookIndex() - UnHook Index
Arguments - 2  
First argument - object index for unhook (required)  
Second argument - property for hook (optional)
```lua
Net.Simple.UnHookIndex(game.workspace.Part, "Name")
```
#### HookIndex() - Hook Index - intercept property reads
Arguments - 2 (+3)  
First argument - object index for hook (required)  
Second argument - new function (required)  
First function argument - object  
Second function argument - property(key)  
Third function argument - original object index  
Warning:
If you don't return any arguments, the call will block
```lua
Net.Advanced.HookIndex(game.workspace.Part, function(key, original)
  if key == "Name" then
    return "Hooked"
  end
  return original(self, key)
end)
```
#### UnHookIndex() - UnHook Index
Arguments - 1  
First argument - object index for unhook (required)  
```lua
Net.UnHookIndex(game.workspace.Part)
```
#### BlockNewIndex() - Block NewIndex - block property write
Arguments - 2  
First argument - object newindex for block (required)  
Second argument - property for block (required)
```lua
Net.Simple.BlockNewIndex(game.workspace.Part, "Name")
```
#### UnBlockNewIndex() - UnBlock Index
Arguments - 2  
First argument - object newindex for unblock (required)  
Second argument - property for unblock (optional)
```lua
Net.UnSimple.BlockNewIndex(game.workspace.Part, "Name")
```
#### Simple.HookNewIndex() - Hook NewIndex - intercept property write
Arguments - 3  
First argument - object newindex for hook (required)  
Second argument - property for hook (required)  
Third argument - newvalue for hook (required)
```lua
Net.Simple.HookNewIndex(game.workspace.Part, "Name", "Hooked!")
```
#### Simple.UnHookNewIndex - UnHook NewIndex
Arguments - 2  
First argument - object newindex for unhook (required)  
Second argument - property for hook (optional)
```lua
Net.Simple.UnHookNewIndex(game.workspace.Part, "Name")
```
#### HookNewIndex() - Hook NewIndex - intercept property write
Arguments - 2 (+4)  
First argument - object newindex for hook (required)  
Second argument - new function (required)  
First function argument - object  
Second function argument - property(key)  
Third function argument - value for property  
Fourth function argument - original object newindex  
Warning:
If you don't return any arguments, the call will block
```lua
Net.HookNewIndex(game.workspace.Part, function(self, key, value, original)
  if key == "Position" then
    return Vector3.new(10, 50, 10)
  end
  original(self, key, value)
end)
```
#### UnHookNewIndex() - UnHook NewIndex
Arguments - 1  
First argument - object newindex for unhook (required)  
```lua
Net.UnHookNewIndex(game.workspace.Part)
```

### Custom things
#### How To Create Custom Function, AddCustomFunc()
Arguments - 4  
First argument - name for custom function (required)  
Second argument - custom function (required)  
Third argument - debug enabled or not (true/false) (optional)  
Fourth argument - debugger text (optional)  
Example of create custom function  
```lua
LightCoding:AddCustomFunc("Hi", function()
print("Hi")
end, {"Hi2"}, true, "Debug Working!")
```
#### How To Create Custom Method, AddCustomMethod()
Arguments - 3  
First argument - name for custom method (required)  
Second argument - transmit self (you can use self instead of LightCoding in function) (true/false) (optional)  
Third argument - custom method function (required)  
##### What is a method?
This is when you use : instead of . in this library example
```lua
LightCoding:AddCustomFunc()
```
Example of create custom method
```lua
LightCoding:AddCustomMethod("Hello", false, function()
  print("Hello")
end)
LightCoding:Hello()
```
Other Example
```lua
LightCoding:AddCustomMethod("SayName", true, function(self)
  print(self.Info.Name)
end)
LightCoding:SayName()
```

---