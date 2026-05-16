local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char and char:FindFirstChild("HumanoidRootPart")
plr.CharacterAdded:Connect(function(character)
  char = character
   hrp = char:WaitForChild("HumanoidRootPart")
end)
local LightCoding = { }
LightCoding.Info = {
  Name = "Light coding",
  Version = 1.1,
  Author = {
    Name = "AbobaLua",
    URL = "https://github.com/AbobaLua"
  },
  Repository = "https://github.com/AbobaLua/LightCoding",
  Description = "Simple Coding Library"
}
LightCoding.Settings = {
  Debug = false,
  IsStudio = false
}
LightCoding.Functs = { }
local Info = LightCoding.Info
local Settings = LightCoding.Settings
local Functs = LightCoding.Functs
if getgenv and getgenv().LCDebug == true then
  Settings.Debug = true
end
if game:GetService("RunService"):IsStudio() then
  Settings.IsStudio = true
else
  Settings.IsStudio = false
end
local function console(...)
  if Settings and Settings.Debug then
    print("Debug Output: ", ...)
  end
end
local function missing(t, f, fallback)
  if type(f) == t then return f end
  return fallback
end
local function addfunc(name, func)
  if not name then return end
  if not (LightCoding and Functs) then return end
  if func and type(func) == "function" then
    Functs[name] = func
  end
    if Settings.Debug then
      Functs[name] = function(...)
        console("Calling: " .. "function: " .. tostring(func), "name: " .. name)
        return func(...)
    end
    else
      Functs[name] = func
    end
end
addfunc("getgenv", missing("function", getgenv))
addfunc("executor", missing("function", identifyexecutor or getexecutorname or (syn and syn.getexecutorname)))
addfunc("clipboard", missing("function", setclipboard or toclipboard or set_clipboard or writeclipboard or (Clipboard and Clipboard.set)))
addfunc("writefile", missing("function", writefile))
addfunc("readfile", missing("function", readfile))
addfunc("isfile", missing("function", isfile))
addfunc("makefolder", missing("function", makefolder))
addfunc("isfolder", missing("function", isfolder))
addfunc("hookfunction", missing("function", hookfunction))
addfunc("hookmetamethod", missing("function", hookmetamethod))
addfunc("getnamecallmethod", missing("function", getnamecallmethod or get_namecall_method))
addfunc("checkcaller", missing("function", checkcaller, function() return false end))
addfunc("newcclosure", missing("function", newcclosure))
addfunc("readonly", missing("function", readonly))
addfunc("setreadonly", missing("function", setreadonly or make_readonly))
addfunc("makewritable", missing("function", makewritable or make_writable))
addfunc("isreadonly", missing("function", isreadonly or is_readonly))
addfunc("getgc", missing("function", getgc or get_gc_objects))
-- Main Functions
addfunc("say", function(...)
  print(...)
end)

addfunc("warnmsg", function(...)
  warn(...)
end)

addfunc("err", function(text, lvl)
  if lvl == nil then
    error(text)
  else
    error(text, lvl)
  end
end)

addfunc("service", function(Name)
  return game:GetService(Name)
end)
-- create (Instance)
addfunc("create", function(Name)
  return Instance.new(Name)
end)
-- fireclickdetector

addfunc("pfireclickd", function(obj)
    if not hrp then return end
    if path:IsA("ClickDetector") then
      pcall(fireclickdetector, obj)
    end
end
end)
-- firetouchinterest
addfunc("pfiretouchinterest", function(touch, obj)
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
-- fireproximitypromt
addfunc("pfireproximitypromt", function(obj)
  if not hrp then return end
    if obj:IsA("ProximityPrompt") then
      pcall(fireproximityprompt, obj)
    end
end)
if getgenv then
print("-----Light Coding-----")
print("--Name: " .. LightCoding.Info.Name)
print("--Version: " .. LightCoding.Info.Version)
print("--Author: ")
print("  --Auhor Name: " .. LightCoding.Info.Author.Name)
print("  --URL: " .. LightCoding.Info.Author.URL)
print("--Repository: " .. LightCoding.Info.Repository)
print("--Description: " .. LightCoding.Info.Description)
end
return LightCoding
