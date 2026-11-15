local _0xP = game:GetService("Players")
local _0xR = game:GetService("RunService")
local _0xC = workspace.CurrentCamera
local _0xL = _0xP.LocalPlayer
local _0xD = {}

-- ================== 射线终极配置区 ==================
-- 【起点位置】：可填 "Top" (顶部), "Center" (准星中心), "Bottom" (底部)
local _0xPosMode = "Bottom" 
local _0xMaxDist = 1000
-- ====================================================

local function _0xIsEnemy(_0xPlr)
    if _0xPlr == _0xL or not _0xPlr.Character then return false end
    local _0xM, _0xT = _0xL.Team, _0xPlr.Team
    if not _0xM or not _0xT then return true end
    return _0xM ~= _0xT
end

local function _0xClean(_0xPlr)
    if _0xD[_0xPlr] then
        for _, obj in pairs(_0xD[_0xPlr]) do
            if obj.Remove then obj:Remove() end
        end
        _0xD[_0xPlr] = nil
    end
end

_0xR.RenderStepped:Connect(function()
    local _0xTM = tick() * 15 -- 凶悍震颤频率
    local _0xMyChar = _0xL.Character
    local _0xMyRoot = _0xMyChar and _0xMyChar:FindFirstChild("HumanoidRootPart")
    if not _0xMyRoot then return end
    
    -- 【动态计算起点坐标】
    local _0xStart = Vector2.new(_0xC.ViewportSize.X / 2, _0xC.ViewportSize.Y)
    if _0xPosMode == "Top" then
        _0xStart = Vector2.new(_0xC.ViewportSize.X / 2, 0)
    elseif _0xPosMode == "Center" then
        _0xStart = Vector2.new(_0xC.ViewportSize.X / 2, _0xC.ViewportSize.Y / 2)
    end

    for _, _0xPlr in pairs(_0xP:GetPlayers()) do
        local _0xChar = _0xPlr.Character
        local _0xHum = _0xChar and _0xChar:FindFirstChild("Humanoid")
        local _0xHead = _0xChar and _0xChar:FindFirstChild("Head")
        local _0xRoot = _0xChar and _0xChar:FindFirstChild("HumanoidRootPart")
        
        if _0xIsEnemy(_0xPlr) and _0xChar and _0xHum and _0xHum.Health > 0 and _0xHead and _0xRoot then
            local _0xDist = (_0xMyRoot.Position - _0xRoot.Position).Magnitude
            
            if _0xDist <= _0xMaxDist then
                if not _0xD[_0xPlr] or _0xD[_0xPlr].Char ~= _0xChar then
                    _0xClean(_0xPlr)
                    _0xD[_0xPlr] = {
                        Char = _0xChar,
                        Glow = Drawing.new("Line"),
                        Core = Drawing.new("Line")
                    }
                    _0xD[_0xPlr].Glow.Thickness = 3
                    _0xD[_0xPlr].Glow.Transparency = 0.5
                    _0xD[_0xPlr].Core.Thickness = 1
                    _0xD[_0xPlr].Core.Transparency = 0.1
                end
                
                local _0xData = _0xD[_0xPlr]
                local _0xScreen, _0xOn = _0xC:WorldToViewportPoint(_0xHead.Position)
                
                if _0xOn then
                    -- 距离越近越凶
                    local _0xFerocity = math.clamp(1 - (_0xDist / _0xMaxDist), 0, 1)
                    local _0xShake = math.sin(_0xTM) * (2 + _0xFerocity * 4)
                    local _0xEnd = Vector2.new(_0xScreen.X + _0xShake, _0xScreen.Y + _0xShake)
                    
                    -- 凶悍蓝光配色
                    local _0xBaseBlue = Color3.fromRGB(0, 50, 255)
                    local _0xBrightBlue = Color3.fromRGB(0, 200, 255)
                    local _0xFinalColor = _0xBaseBlue:Lerp(_0xBrightBlue, _0xFerocity)
                    
                    -- 如果距离极近（150以内），直接变刺眼的白
                    if _0xDist < 150 then
                         _0xFinalColor = Color3.fromRGB(255, 255, 255)
                    end

                    _0xData.Glow.From = _0xStart
                    _0xData.Glow.To = _0xEnd
                    _0xData.Glow.Color = _0xFinalColor
                    _0xData.Glow.Visible = true
                    
                    _0xData.Core.From = _0xStart
                    _0xData.Core.To = Vector2.new(_0xScreen.X, _0xScreen.Y)
                    _0xData.Core.Color = Color3.fromRGB(255, 255, 255)
                    _0xData.Core.Visible = true
                else
                    _0xData.Glow.Visible = false
                    _0xData.Core.Visible = false
                end
            else
                if _0xD[_0xPlr] then
                    _0xD[_0xPlr].Glow.Visible = false
                    _0xD[_0xPlr].Core.Visible = false
                end
            end
        else
            _0xClean(_0xPlr)
        end
    end
end)

_0xP.PlayerRemoving:Connect(_0xClean)
