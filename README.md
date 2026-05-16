## Work in Progress(WIP)
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
  - say(text) - print text example :
  ```lua
  Functs.say("hi")
  -- Print hello to the console
  ```
  
  - warnmsg(text) - warn message example :
  ```lua
  Functs.warnmsg("Warning")
  -- Print ⚠️ Warning to the console
  ```
  
  - err(text) - error message example : 
  ```lua
  Functs.err("Error")
  -- Print ❌ Error to the console
  ```
  
  - service(NameService) -- get service example :
  ```lua
  Functs.service("Players")
  -- get Players Service
  ```
  
  - create(NameClass) - Creates an object with the class name example :
  ```lua
  Functs.create("Part") -- Creates Part
  ```
  
  - pfireclickd(ClickDetecto) - Fire ClickDetector example :
  ```lua
Functs.pfireclickd(workspace.ClickDetector)
  -- fire clickdetector in workspace
  ```
  
  - pfiretouchinterest(plr or obj, obj) - Fire TouchInterest - need object BasePart Class example : 
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
  - How to rename function example : 
  ```lua
  local newClick = LightCoding.Functs.pfireclickd -- pfireclick - name function which you want to change
  -- newClick - new function name
  newClick(workpace.ClickDetector)
  ```
