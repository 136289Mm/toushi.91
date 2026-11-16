local _0xP = game:GetService("Players")
local _0xR = game:GetService("RunService")
local _0xC = workspace.CurrentCamera
local _0xL = _0xP.LocalPlayer

local _0xD = {}

local function _0xIsEnemy(_0xPlr)
    if _0xPlr == _0xL or not _0xPlr.Character then return false end
    local _0xM, _0xT = _0xL.Team, _0xPlr.Team
    if not _0xM or not _0xT then return true end
    return _0xM ~= _0xT
end

_0xR.RenderStepped:Connect(function()
    -- 每一帧动态获取当前的真实摄像机（防止第一人称切第三人称导致坐标错乱）
    local _0xCurrentCam = workspace.CurrentCamera
    if not _0xCurrentCam then return end

    local _0xW, _0xH = _0xCurrentCam.ViewportSize.X, _0xCurrentCam.ViewportSize.Y
    local _0xStart = Vector2.new(_0xW / 2, _0xH) -- 射线起点永远在屏幕正下方

    for _, _0xPlr in pairs(_0xP:GetPlayers()) do
        local _0xChar = _0xPlr.Character
        local _0xHum = _0xChar and _0xChar:FindFirstChild("Humanoid")
        local _0xHead = _0xChar and _0xChar:FindFirstChild("Head")
        
        if _0xIsEnemy(_0xPlr) and _0xHum and _0xHum.Health > 0 and _0xHead then
            if not _0xD[_0xPlr] then
                _0xD[_0xPlr] = {
                    Glow = Drawing.new("Line"),
                    Core = Drawing.new("Line")
                }
                _0xD[_0xPlr].Glow.Thickness = 3
                _0xD[_0xPlr].Glow.Transparency = 0.5
                _0xD[_0xPlr].Core.Thickness = 1.5
                _0xD[_0xPlr].Core.Transparency = 0.1
            end
            
            local _0xData = _0xD[_0xPlr]
            
            -- 【核心】：直接获取头部在世界中的坐标，并投影到当前摄像机的 2D 屏幕上
            local _0xScreenPos, _0xOnScreen = _0xCurrentCam:WorldToViewportPoint(_0xHead.Position)
            
            -- 只要在屏幕上（不管多远），直接锁头
            if _0xOnScreen then
                _0xData.Glow.From = _0xStart
                _0xData.Glow.To = Vector2.new(_0xScreenPos.X, _0xScreenPos.Y)
                _0xData.Glow.Color = Color3.fromRGB(255, 30, 30)
                _0xData.Glow.Visible = true
                
                _0xData.Core.From = _0xStart
                _0xData.Core.To = Vector2.new(_0xScreenPos.X, _0xScreenPos.Y)
                _0xData.Core.Color = Color3.fromRGB(255, 255, 255)
                _0xData.Core.Visible = true
            else
                -- 如果不在屏幕上（比如在背后），直接隐藏，防止线跟着你乱跑
                _0xData.Glow.Visible = false
                _0xData.Core.Visible = false
            end
        else
            if _0xD[_0xPlr] then
                _0xD[_0xPlr].Glow:Remove()
                _0xD[_0xPlr].Core:Remove()
                _0xD[_0xPlr] = nil
            end
        end
    end
end)
