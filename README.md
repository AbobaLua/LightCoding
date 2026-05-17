## Work in Progress(WIP)
---
## Light Coding
  Make your coding easier!
  - Loadstring :
  ```lua
  local LightCoding = loadstring(game:HttpGet("https://raw.githubusercontent.com/AbobaLua/LightCoding/main/Source.lua"))()
  ```
 ### Functions
  - Functions shorcut
  ```lua
  local callfunc = LightCoding.CallFunc
  ```
  - Callfunc(NameFunction, arguments)
  ```lua
  LightCoding.CallFunc("say", "hello")
  -- print hello to the console
  ```
  - say(text) - print text:
  ```lua
  callfunc("say", "hi")
  -- Print hello to the console
  ```
  
  - warnmsg(text) - warn message:
  ```lua
  callfunc("warnmsg", "Warning")
  -- Print ⚠️ Warning to the console
  ```
  
  - err(text) - error message: 
  ```lua
  callfunc("err", "Error")
  -- Print ❌ Error to the console
  ```
  
  - service(NameService) -- get service:
  ```lua
  callfunc("service", "Players")
  -- get Players Service
  ```
  
  - create(NameClass) - Creates an object with the class name:
  ```lua
  callfunc("create", "Part") -- Creates Part
  ```
  
  - pfireclickd(ClickDetector) - Fire ClickDetector:
  ```lua
callfunc("pfireclickd", workspace.ClickDetector)
  -- fire clickdetector in workspace
  ```
  
  - pfiretouchinterest(plr or obj, obj) - Fire TouchInterest - need object BasePart Class: 
  ```lua
callfunc("pfiretouchinterest", game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Part)
  -- Touch workspace.Part by using Player HumanoidRootPart
  ```

  - pfireproxpromt(ProximityPrompt) -- Fire Proximity Prompt
  ```lua
callfunc("pfireproxpromt", workspace.ProximityPrompt)
  -- fire proximity prompt in workspace
  ```
### Rename function
  - How to rename function: 
  ```lua
  local newClick = LightCoding.Functs.pfireclickd -- pfireclick - name function which you want to change, newClick new Name Functio
  -- newClick - new function name
  newClick(workpace.ClickDetector)
  ```
  - Or
  ```lua
  local newClick = callfunc("pfireclickd")
  newClick(workspace.ClickDetectoe)
  ```
### Delete Script
```lua
LightCoding:Delete()
```
