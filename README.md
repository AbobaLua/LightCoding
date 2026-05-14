## Work in Progress(WIP)
## Light Coding
  Make your coding easier!
  Loadstring :
  ```lua
  local LightCoding = loadstring(game:HttpGet("https://raw.githubusercontent.com/AbobaLua/LightCoding/main/Source.lua"))()
  ```
 ### Functions
  say(text) - print text example :
  ```lua
  LightCoding.say("hi")
  -- Print hello to the console
  ```
  
  warnmsg(text) - warn message example :
  ```lua
  LightCoding.warnmsg("Warning")
  -- Print ⚠️ Warning to the console
  ```
  
  err(text) - error message example : 
  ```lua
  LightCoding.err("Error")
  -- Print ❌ Error to the console
  ```
  
  service(NameService) -- get service example :
  ```lua
  LightCoding.service("Players")
  -- get Players Service
  ```
  
  create(NameClass) - Creates an object with the class name example :
  ```lua
  LightCoding.create("Part") -- Creates Part
  ```
  
  pfireclickd(ClickDetecto) - Fire ClickDetector example :
  ```lua
  LightCoding.pfireclickd(workspace.ClickDetector)
  -- fire click detector in workspace
  ```
  
  pfiretouchinterest(plr or obj, obj) - Fire TouchInterest - need object BasePart Class example : 
  ```lua
  LightCoding.pfiretouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Part)
  -- Fire TouchInterest in workspace.Part by using Player HumanoidRootPart
  ```

  pfireproxpromt(ProximityPrompt) -- Fire Proximity Prompt
  ```lua
  LightCoding.pfireproxpromt(workspace.ProximityPrompt)
  -- fire proximity prompt in workspace
  ```
### Rename function
  How to rename function example : 
  ```lua
  local newClick = LightCoding.pfireclickd -- pfireclick - name function which you want to change
  -- newClick - new function name
  newClick(workpace.ClickDetector)
  ```
