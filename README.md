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
  #### GetFunc() - Get Function
   Arguments - 1
   First Argument - Func for the get (required)
  ```lua
  local newsay = LightCoding:GetFunc("say")
  newsay("Hello")
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
  #### service() -- get service
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
  #### BlockRE() - Block remote calls (already existed, but now compatible)
   Arguments - 1
   First argument - remote for block (required)
  ```lua
  LightCoding:CallFunc("BlockRE", game.workspace.RemoteEvent)
  ```
  #### UnBlockRE() - UnBlock remote
   Arguments - 1
   First argument - remote for unblock (required)
  ```lua
  LightCoding:CallFunc("UnBlockRE", game.workspace.RemoteEvent)
  ```
  #### HookRE() - Intercept RemoteEvent/RemoteFunction or other Event calls
   Allows you to intercept "FireServer" (RemoteEvent) or InvokeServer (RemoteFunction) or other calls.
   You can view or modify arguments, or block the call entirely.
   Arguments - 2
   First argument - remote for hook (required)
   Second argument - new function for remote (required)
    First function argument - table of arguments remote (required)
   Warning:
    If you don't return any arguments, the call will block
    ```lua
    LightCoding:CallFunc("HookRE", game.workspace.RemoteEvent, function(args)
      print("Hooked!") -- Is will Blocked and print "Hooked!" when they call
    end)
    ```
    The correct path so that remove is not blocked
    ```lua
    LightCoding:CallFunc("HookRE", game.workspace.RemoteEvent, function(args)
      print("Hooked!")
      return args
    end)
    ```
  Example:
  ```lua
  LightCoding:CallFunc("HookRE", game.workspace.RemoteEvent, function(args)
    print("Hooked!")
    return args
  end)
  ```
  Other Examples:
  1: Hook of argument number one
  ```lua
  LightCoding:CallFunc("HookRE", game.workspace.RemoteEvent, function(args)
    args[1] = 10
    return args
  end)
  ```
  2: Prints and returns the previous arguments
  ```lua
  LightCoding:CallFunc("HookRE", game.workspace.RemoteEvent, function(args)
    print("Hooked with args: ", unpack(args))
    return args
  end)
  ```
  #### UnHookRE() - UnHook Remote
   Arguments - 1
   First argument - remote for unhook (required)
  ```lua
  LightCoding:CallFunc("UnHookRE", game.workspace.RemoteEvent)
  ```
  #### HookMethod() - Hook object method
   Arguments - 3
   First argument - object for hook (required)
   Second argument - method for hook (required)
   Third argument - new function to object method (required)
    First function argument - table of arguments object method
    Warning:
     If you don't return any arguments, the call will block
  Example:
   ```lua
   LightCoding:CallFunc("HookMethod", game.workspace.Part, "Destroy", function(args)
     print("Attempt to Destroy Part")
     return args
   end)
   ```
  Example 2:
   ```lua
   LightCoding:CallFunc("HookMethod", game.workspace.Part, "Clone", function(args)
     print("Attempt to Clone Part: Blocking")
     return nil
   end)
   ```
  #### Note: HookMethod can hook multiple methods on an object
  #### UnHookMethod() - UnHook object method
   Arguments - 2
   First argument - object for UnHook
   Second argument - method for unhook
  ```lua
  LightCoding:CallFunc("UnHookMethod", game.workspace.Part, "Destroy")
  ```
  #### Note: A remote cannot be hooked and blocked at the same time
  If you try to hook a blocked remote, it will return warning line
  
---

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
  end, true, "Debug Working!")
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
