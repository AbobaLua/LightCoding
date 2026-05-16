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
  local Functs = LightCoding.Functs
  ```
  - say(text) - print text:
  ```lua
  Functs.say("hi")
  -- Print hello to the console
  ```
  
  - warnmsg(text) - warn message:
  ```lua
  Functs.warnmsg("Warning")
  -- Print ⚠️ Warning to the console
  ```
  
  - err(text) - error message: 
  ```lua
  Functs.err("Error")
  -- Print ❌ Error to the console
  ```
  
  - service(NameService) -- get service:
  ```lua
  Functs.service("Players")
  -- get Players Service
  ```
  
  - create(NameClass) - Creates an object with the class name:
  ```lua
  Functs.create("Part") -- Creates Part
  ```
  
  - pfireclickd(ClickDetector) - Fire ClickDetector:
  ```lua
Functs.pfireclickd(workspace.ClickDetector)
  -- fire clickdetector in workspace
  ```
  
  - pfiretouchinterest(plr or obj, obj) - Fire TouchInterest - need object BasePart Class: 
  ```lua
  Functs.pfiretouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Part)
  -- Fire TouchInterest in workspace.Part by using Player HumanoidRootPart
  ```

  - pfireproxpromt(ProximityPrompt) -- Fire Proximity Prompt
  ```lua
  Functs.pfireproxpromt(workspace.ProximityPrompt)
  -- fire proximity prompt in workspace
  ```
### Rename function
  - How to rename function: 
  ```lua
  local newClick = LightCoding.Functs.pfireclickd -- pfireclick - name function which you want to change
  -- newClick - new function name
  newClick(workpace.ClickDetector)
  ```
