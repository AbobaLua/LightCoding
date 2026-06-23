## Work in Progress(WIP)
## The project is frozen for a week 📅 (I'll be back in 01.07)
---
## Light Coding
  Make your coding easier!
  ### Loadstring
  ```lua
  local LightCoding = loadstring(game:HttpGet("https://raw.githubusercontent.com/AbobaLua/LightCoding/main/Source.lua"))()
  ```

---

### Functions
  #### say() - print text
  ```lua
  LightCoding:CallFunc("say", "hi")
  -- Print hello to the console
  ```
  
   Or
  
  ```lua
  LightCoding.Functs.say("hi")
  ```
  #### warnmsg() - warn message
  ```lua
  LightCoding:CallFunc("warnmsg", "Warning")
  -- Print ⚠️ Warning to the console
  ```
  
  #### service() -- get service
  ```lua
  LightCoding:CallFunc("service", "Players")
  -- Get Players Service
  ```
  
  #### create() - Creates an object with the class name
  ```lua
  LightCoding:CallFunc("create", "Part")
  -- Create Part
  ```
  
  #### pfireclickd() - Fire ClickDetector
  ```lua
  LightCoding:CallFunc("pfireclickd", workspace.ClickDetector)
  -- Fire clickdetector in workspace
  ```
  
  #### pfiretouchinterest() - Fire TouchInterest - need object BasePart Class
  ```lua
  LightCoding:CallFunc("pfiretouchinterest", game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Part)
  -- Touch workspace.Part by using Player HumanoidRootPart
  ```

  #### pfireproxpromt() - Fire Proximity Prompt
  ```lua
  LightCoding:CallFunc("pfireproxpromt", workspace.ProximityPrompt)
  -- fire proximity prompt in workspace
  ```
  #### BlockRE() - Block Remote Event or Remote Function or UnreliableRemoteEvent or BindableRemote or BindableFunction
  ```lua
  LightCoding:CallFunc("BlockRE", game.workspace.RemoteEvent)
  ```
  #### UnBlockRE() - UnBlock Remote Event or Remote Function or UnreliableRemoteEvent or BindableRemote or BindableFunction if it was blocked
  ```lua
  LightCoding:CallFunc("UnBlockRE", game.workspace.RemoteEvent)
  ```
  
---

### Get function
  #### How to get a link to the function
  ```lua
  local newClick = LightCoding:GetFunc("pfireclickd")
  newClick(workpace.ClickDetector)
  -- pfireclick - Name function which you want to remame
  -- newClick - Link to the function
  ```

---

### Methods
  #### ClearLog() - Clear Log
  ```lua
  LightCoding:ClearLog()
  ```

---

### Custom things
  #### How To Create Custom Function, AddCustomFunc()
  Example of create custom function
  ```lua
  LightCoding:AddCustomFunc("Hi", function() print("Hi") end, true, "Debug Working!")
  -- "Hi" Name Function
  -- function() print("Hi") end - Your function
  -- true - Debug enabled or not (true or false)
  -- "Debug Working!" - Debug output Text
  ```
  #### How To Create Custom Method, AddCustomMethod()
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
  -- "Hello" - Name Method
  -- false - Will it transmit self (true or false)
  -- function() - Your custom function
  ```
  Other Example
  ```lua
  LightCoding:AddCustomMethod("SayName", true, function(self)
    print(self.Info.Name)
  end)
  LightCoding:SayName()
  ```

---

### Delete Script
  ```lua
  LightCoding:Delete()
  ```
