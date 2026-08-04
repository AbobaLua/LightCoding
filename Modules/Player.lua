
return function(lib, api)
  local missing = api.missing
  local safeget = missing("function", cloneref, function(...) return ... end)
  local plr = safeget(Players.LocalPlayer)
  local char = safeget(plr.Character) or safeget(plr.CharacterAdded:Wait())
  local hrp = char and safeget(char:FindFirstChild("HumanoidRootPart"))
  local hum = char.Humanoid
  plr.CharacterAdded:Connect(function(character)
    char = character
    hrp = char:WaitForChild("HumanoidRootPart")
    hum = character.Humanoid
  end)
  return {
    GetPlayer = function(self)
      return safeget(Players.LocalPlayer)
    end,
    GetCharacter = function(self)
      return safeget(plr.character) or safeget(plr.CharacterAdded:Wait())
    end,
    GetHumanoid = function(self)
      return safeget(char.Humanoid)
    end,
    GetRootPart = function(self)
      return safeget(char:FindFirstChild("HumanoidRootPart"))
    end,
    GetNeardestPlayer = function(self)
      local closest = nil
      local closestDist = math.huge

      for i, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= player then
            local plrChar = plr.Character
            if plrChar then
                local plrRoot = plrChar:FindFirstChild("HumanoidRootPart")
                if plrRoot then
                    local dist = (plrRoot.Position - hrp.Position).Magnitude
                    if dist < closestDist then
                      closestDist = dist
                      closest = plr
                    end
                end
            end
        end
      end
      return closest
    end,
    SetSpeed = function(self, val : number)
      hum.WalkSpeed = val
    end,
    SetJumpPower = function(self, val : number)
      hum.JumpPower = val
    end,
    SetVelocity = function(self, x: number, y: number, z: number)
      hrp.Velocity = Vector3.new(x, y, z)
    end
    IsAlive = function(self)
      if hum.Health <= 0 then
        return false
      else
        return true
      end
    end,
    TeleportTo = function(self, pos : Position | CFrame)
      hum.Position = pos
    end,
  }
end