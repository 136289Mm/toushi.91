local _0xP = game:GetService("Players")
local _0xR = game:GetService("RunService")
local _0xC = workspace.CurrentCamera
local _0xL = _0xP.LocalPlayer
local _0xHL_DB = {} -- 核心缓存表

-- ================== 顶级逻辑配置区 ==================
local _0xMaxDist = 1000          -- 最大雷达探测距离
local _0xCloseCombat = 50        -- 贴身危险距离
local _0xRadarColor = Color3.fromRGB(60, 0, 0)       -- 雷达常驻暗红
local _0xFiringColor1 = Color3.fromRGB(255, 20, 20)  -- 开火警告亮红
local _0xFiringColor2 = Color3.fromRGB(100, 0, 0)    -- 开火交替暗红
local _0xCloseColor1 = Color3.fromRGB(255, 255, 255) -- 贴脸警告纯白
local _0xCloseColor2 = Color3.fromRGB(255, 0, 0)     -- 贴脸交替亮红
-- ====================================================

-- 过滤队友与阵营检测
local function _0xIsEnemy(_0xPlr)
    if _0xPlr == _0xL or not _0xPlr.Character then return false end
    local _0xM, _0xT = _0xL.Team, _0xPlr.Team
    if not _0xM or not _0xT then return true end
    return _0xM ~= _0xT
end

-- 极速内存回收（防止卡顿与残留）
local function _0xPurge(_0xPlr)
    if _0xHL_DB[_0xPlr] then
        _0xHL_DB[_0xPlr]:Destroy()
        _0xHL_DB[_0xPlr] = nil
    end
end

_0xR.RenderStepped:Connect(function()
    -- 高频脉冲计算，用于蜘蛛感应闪烁
    local _0xTM = tick() * 18 
    local _0xMyChar = _0xL.Character
    local _0xMyRoot = _0xMyChar and _0xMyChar:FindFirstChild("HumanoidRootPart")
    if not _0xMyRoot then return end

    for _, _0xPlr in pairs(_0xP:GetPlayers()) do
        local _0xChar = _0xPlr.Character
        local _0xHum = _0xChar and _0xChar:FindFirstChild("Humanoid")
        local _0xRoot = _0xChar and _0xChar:FindFirstChild("HumanoidRootPart")
        
        if _0xIsEnemy(_0xPlr) and _0xChar and _0xHum and _0xHum.Health > 0 and _0xRoot then
            local _0xDist = (_0xMyRoot.Position - _0xRoot.Position).Magnitude
            
            -- 只有在最大探测距离内，才启用高亮
            if _0xDist <= _0xMaxDist then
                
                -- 如果模型重载或重生，瞬间销毁旧高亮重建
                if not _0xHL_DB[_0xPlr] or _0xHL_DB[_0xPlr].Adornee ~= _0xChar then
                    _0xPurge(_0xPlr)
                    local _0xNewHL = Instance.new("Highlight")
                    _0xNewHL.Adornee = _0xChar
                    _0xNewHL.FillTransparency = 1
                    _0xNewHL.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    _0xNewHL.OutlineTransparency = 0
                    _0xNewHL.Parent = _0xChar
                    _0xHL_DB[_0xPlr] = _0xNewHL
                end
                
                local _0xActiveHL = _0xHL_DB[_0xPlr]
                _0xActiveHL.Enabled = true
                
                local _0xPulse = math.sin(_0xTM)
                local _0xFiringState = false
                
                -- 【特性检测】：检测敌人是否正在开枪
                local _0xTool = _0xChar:FindFirstChildOfClass("Tool")
                if _0xTool then
                    if _0xTool:GetAttribute("IsFiring") or _0xTool:GetAttribute("Activated") then
                        _0xFiringState = true
                    end
                end
                
                -- 【状态机判定】
                if _0xDist <= _0xCloseCombat then
                    -- 1. 贴脸极其危险：红白高频交替报警
                    if _0xPulse > 0 then
                        _0xActiveHL.OutlineColor = _0xCloseColor1
                    else
                        _0xActiveHL.OutlineColor = _0xCloseColor2
                    end
                elseif _0xFiringState then
                    -- 2. 敌人正在开火：亮红暗红快速交替
                    if _0xPulse > 0 then
                        _0xActiveHL.OutlineColor = _0xFiringColor1
                    else
                        _0xActiveHL.OutlineColor = _0xFiringColor2
                    end
                else
                    -- 3. 平时安全状态：极暗的血红雷达锁定
                    _0xActiveHL.OutlineColor = _0xRadarColor
                end
            else
                -- 超出探测距离，禁用高亮不占性能
                if _0xHL_DB[_0xPlr] then
                    _0xHL_DB[_0xPlr].Enabled = false
                end
            end
        else
            -- 敌人死亡、离开、或变成队友，彻底清空内存
            _0xPurge(_0xPlr)
        end
    end
end)

-- 玩家离开服务器时的大清理
_0xP.PlayerRemoving:Connect(function(_0xPlr)
    _0xPurge(_0xPlr)
end)
