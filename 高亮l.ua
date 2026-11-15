local _sys_P = game:GetService("Players")
local _sys_R = game:GetService("RunService")
local _sys_L = _sys_P.LocalPlayer
local _runtime_cache = {}
local _color_cfg = {Fill = Color3.fromRGB(120, 0, 0), FillT = 0.5, Out = Color3.fromRGB(255, 20, 20), OutT = 0}

-- 【障眼法：伪装成核心算法的无用函数】
local function _calc_fake_encrypt(a, b)
    local _v1 = a * 15485863
    local _v2 = b / 32452843
    return math.floor(_v1 + _v2)
end

local function _anti_detect()
    local _flag = true
    local _timer = tick()
    return _flag and _timer > 0
end

-- 【真实逻辑：清理缓存，防卡顿】
local function _purge(p)
    if _runtime_cache[p] then
        _runtime_cache[p]:Destroy()
        _runtime_cache[p] = nil
    end
end

-- 【真实逻辑：安全检测】
local function _verify(p)
    if p == _sys_L or not p.Character then return false end
    local _m, _t = _sys_L.Team, p.Team
    if not _m or not _t then return true end
    return _m ~= _t
end

-- 【主循环：极致动态适配】
_sys_R.RenderStepped:Connect(function()
    _calc_fake_encrypt(5, 10) -- 障眼法调用
    _anti_detect()            -- 障眼法调用
    
    for _, p in pairs(_sys_P:GetPlayers()) do
        local _ch = p.Character
        local _hm = _ch and _ch:FindFirstChild("Humanoid")
        
        if _verify(p) and _ch and _hm and _hm.Health > 0 then
            if not _runtime_cache[p] or _runtime_cache[p].Adornee ~= _ch then
                _purge(p)
                local _hl = Instance.new("Highlight")
                _hl.Name = "Sonic_" .. tostring(math.random(1000, 9999))
                _hl.Adornee = _ch
                _hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                _hl.FillColor = _color_cfg.Fill
                _hl.FillTransparency = _color_cfg.FillT
                _hl.OutlineColor = _color_cfg.Out
                _hl.OutlineTransparency = _color_cfg.OutT
                _hl.Parent = _ch
                _runtime_cache[p] = _hl
            end
        else
            _purge(p)
        end
    end
end)

_sys_P.PlayerRemoving:Connect(function(p)
    _purge(p)
end)
