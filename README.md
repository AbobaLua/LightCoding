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
  local CallFunc = LightCoding:CallFunc
  ```
  - CallFunc(NameFunction, arguments)
  ```lua
  LightCoding:CallFunc("say", "hello")
  -- print hello to the console
  ```
  - say(text) - print text:
  ```lua
  CallFunc("say", "hi")
  -- Print hello to the console
  ```
  
  - warnmsg(text) - warn message:
  ```lua
  CallFunc("warnmsg", "Warning")
  -- Print ⚠️ Warning to the console
  ```
  
  - service(NameService) -- get service:
  ```lua
  CallFunc("service", "Players")
  -- get Players Service
  ```
  
  - create(NameClass) - Creates an object with the class name:
  ```lua
  CallFunc("create", "Part") -- Creates Part
  ```
  
  - pfireclickd(ClickDetector) - Fire ClickDetector:
  ```lua
CallFunc("pfireclickd", workspace.ClickDetector)
  -- fire clickdetector in workspace
  ```
  
  - pfiretouchinterest(plr or obj, obj) - Fire TouchInterest - need object BasePart Class: 
  ```lua
CallFunc("pfiretouchinterest", game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Part)
  -- Touch workspace.Part by using Player HumanoidRootPart
  ```

  - pfireproxpromt(ProximityPrompt) -- Fire Proximity Prompt
  ```lua
CallFunc("pfireproxpromt", workspace.ProximityPrompt)
  -- fire proximity prompt in workspace
  ```
### Rename function
  - How to rename function: 
  ```lua
  local newClick = LightCoding:GetFunc("pfireclickd") -- pfireclick - name function which you want to remame, newClick new Name Function
  -- newClick - new function name
  newClick(workpace.ClickDetector)
  ```
### Delete Script
```lua
LightCoding:Delete()
```
