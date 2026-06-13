# ChangeLog for Light Coding

## [1.21 Beta] - Unrelated

## Added
- New Methods to LightCoding:
- New Method IsLoaded()
- New Method WaitForLoad()
- New Exploit Functions:
- New Function HookRE()
- New Function UnHookRE()
- New Function HookMethod()
- New Function UnHookMethod()
---

## [1.2 Version] - 2026-06-09
## Added
- Log Added
- New Exploit Functions: BlockRE, UnBlockRE, getrawmetatable, getfenv, fireclickdetector, firetouchinterest, fireproximitypromtp, firesignal, setfflag, getfflag, gethwid, clonoref, replicatesignal, gethiddenproperty, sethiddenproperty, gethui
- New Method: LightCoding:AddCustomFunc()
- New Method: LightCoding:AddCustomMethod()
- New Method: LightCoding:ClearLog()
- New Method: LightCoding:CallFunc()
- New Method: LightCoding:Delete()
- New Method: LightCoding:GetFunc()
- New Variable: LightCoding.Settings.Loaded or getgenv().LCLoaded or _G.LCLoaded

## Changed

- Now you can LightCoding:CallFunc("getgenv", "hi") no longer LightCoding.Functs.getgenv.hi
- No longer restart script with getgenv().LCDebug = true to enable Debug

## Removed

 - Remove err function

---

## [1.1 Version] - 2026-05-16
### Added

- New Exploit Functions: getgenv, executor, clipboard, writefile, readfile, isfile, makefolder, isfolder, hookfunction, hookmetamethod, getnamecallmethod, checkaller, newcclosure, readonly, setreadonly, makewriteable, isreadonly, getgc
- Added Debug
- New Sections Info, Settings
- Added new Automatic Debug

### Changed

- Now Function added on LightCoding.Functs no longer directly in LightCoding
- Simplified calling pcall no longer: local succes, err
- Now pfiretouchinterest needed Player or Character or HumanoidRootPart

---

##   [1.0 Version] - 2026-05-10

### Added
- First publication of the repository
- Basic Functions: say, warnmsg, err, service, create
- Exploit Functions: pfireclickd, pfiretouchinterest, pfireproximitypromt
