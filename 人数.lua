local _0xP = game:GetService("Players")
local _0xR = game:GetService("RunService")
local _0xC = workspace.CurrentCamera
local _0xL = _0xP.LocalPlayer

local _0xTextTop = Drawing.new("Text")
local _0xTextBot = Drawing.new("Text")
local _0xTextLeft = Drawing.new("Text")
local _0xTextRight = Drawing.new("Text")

for _, _0xTxt in pairs({_0xTextTop, _0xTextBot, _0xTextLeft, _0xTextRight}) do
    _0xTxt.Size = 18
    _0xTxt.Center = true
    _0xTxt.Outline = true
    _0xTxt.Font = 2
    _0xTxt.Visible = false
end

local function _0xIsEnemy(_0xPlr)
    if _0xPlr == _0xL or not _0xPlr.Character then return false end
    local _0xM, _0xT = _0xL.Team, _0xPlr.Team
    if not _0xM or not _0xT then return true end
    return _0xM ~= _0xT
end

_0xR.RenderStepped:Connect(function()
    local _0xMyRoot = _0xL.Character and _0xL.Character:FindFirstChild("HumanoidRootPart")
    if not _0xMyRoot then return end

    local _0xW, _0xH = _0xC.ViewportSize.X, _0xC.ViewportSize.Y
    local _0xCx, _0xCy = _0xW / 2, _0xH / 2

    local _0xF, _0xB, _0xL_, _0xR_ = 0, 0, 0, 0
    local _0xMinDF, _0xMinDB, _0xMinDL, _0xMinDR = 9999, 9999, 9999, 9999

    for _, _0xPlr in pairs(_0xP:GetPlayers()) do
        local _0xChar = _0xPlr.Character
        local _0xHum = _0xChar and _0xChar:FindFirstChild("Humanoid")
        local _0xRoot = _0xChar and _0xChar:FindFirstChild("HumanoidRootPart")
        
        if _0xIsEnemy(_0xPlr) and _0xHum and _0xHum.Health > 0 and _0xRoot then
            local _0xDist = (_0xMyRoot.Position - _0xRoot.Position).Magnitude
            if _0xDist <= 1000 then
                
                -- 使用绝对 2D 向量夹角计算
                local _0xDir = (_0xRoot.Position - _0xMyRoot.Position).Unit
                local _0xDot = _0xC.CFrame.LookVector:Dot(_0xDir)
                local _0xRightDot = _0xC.CFrame.RightVector:Dot(_0xDir)
                
                -- 计算弧度并转换为 0-360 度，彻底告别 45 度死角
                local _0xAngle = math.deg(math.atan2(_0xRightDot, _0xDot))
                if _0xAngle < 0 then _0xAngle = _0xAngle + 360 end
                
                -- 120度 完美分割：正前，正后，左半，右半
                if _0xAngle >= 300 or _0xAngle <= 60 then
                    _0xF = _0xF + 1
                    if _0xDist < _0xMinDF then _0xMinDF = _0xDist end
                elseif _0xAngle > 120 and _0xAngle < 240 then
                    _0xB = _0xB + 1
                    if _0xDist < _0xMinDB then _0xMinDB = _0xDist end
                elseif _0xAngle > 60 and _0xAngle <= 120 then
                    _0xR_ = _0xR_ + 1
                    if _0xDist < _0xMinDR then _0xMinDR = _0xDist end
                else -- 240 到 300
                    _0xL_ = _0xL_ + 1
                    if _0xDist < _0xMinDL then _0xMinDL = _0xDist end
                end
            end
        end
    end

    -- 排版定位
    _0xTextTop.Position = Vector2.new(_0xCx, 40)
    _0xTextBot.Position = Vector2.new(_0xCx, _0xH - 40)
    _0xTextLeft.Position = Vector2.new(80, _0xCy)
    _0xTextRight.Position = Vector2.new(_0xW - 80, _0xCy)

    local _0xColorNear = Color3.fromRGB(255, 30, 30)
    local _0xColorFar = Color3.fromRGB(255, 180, 50)
    local _0xColorSafe = Color3.fromRGB(0, 255, 255)

    -- 动态渲染
    if _0xF > 0 then
        _0xTextTop.Text = "▼ [ 前方: " .. _0xF .. " ] ▼"
        _0xTextTop.Color = _0xMinDF < 250 and _0xColorNear or _0xColorFar
        _0xTextTop.Visible = true
    else
        _0xTextTop.Visible = false
    end

    if _0xB > 0 then
        _0xTextBot.Text = "▲ [ 后方: " .. _0xB .. " ] ▲"
        _0xTextBot.Color = _0xMinDB < 250 and _0xColorNear or _0xColorFar
        _0xTextBot.Visible = true
    else
        _0xTextBot.Visible = false
    end

    if _0xL_ > 0 then
        _0xTextLeft.Text = "◀ [ 左: " .. _0xL_ .. " ]"
        _0xTextLeft.Color = _0xMinDL < 250 and _0xColorNear or _0xColorSafe
        _0xTextLeft.Visible = true
    else
        _0xTextLeft.Visible = false
    end

    if _0xR_ > 0 then
        _0xTextRight.Text = "[ 右: " .. _0xR_ .. " ] ▶"
        _0xTextRight.Color = _0xMinDR < 250 and _0xColorNear or _0xColorSafe
        _0xTextRight.Visible = true
    else
        _0xTextRight.Visible = false
    end
end)
