local _0x1 = game:GetService("Players")
local _0x2 = _0x1.LocalPlayer

-- 假环境变量填充
local _0x3 = {0x12, 0x8F, 0x3A, 0xBC, 0xD4, 0x6E, 0x91, 0x5C}
local _0x4 = {}
for _0x5 = 1, 0x20 do
    _0x4[_0x5] = tostring(math.random(0x100, 0xFFF)) .. "_x"
end

local function _0x6(_0x7, _0x8)
    local _0x9 = (_0x7 * 0xECB1F) % 0x1EF3A6B
    local _0xA = (_0x8 * 0x2FB1B87) % 0x5210079
    return _0x9 + _0xA
end

-- 全局开关
_G.TeamCheck = true

-- ================== 核心功能：智能队友检测 ==================
_G.IsEnemy = function(_0xB)
    if _0xB == _0x2 or not _0xB.Character then return false end
    if not _G.TeamCheck then return true end
    
    local _0xC = _0x2.Team
    local _0xD = _0xB.Team
    
    -- 如果没有队伍，直接当敌人
    if not _0xC or not _0xD then
        _0x6(1, 1) -- 障眼法空转
        return true
    end
    
    return _0xC ~= _0xD
end

-- ================== 障眼法 + 防崩装甲 ==================
local _0xE = false
pcall(function()
    -- 1. 防篡改检查（防注入分析）
    local _0xF = getfenv and getfenv() or _ENV
    if _0xF.string ~= string or _0xF.math ~= math then
        _0xE = true
    end
    
    -- 2. 防 Studio 分析（如果在 Studio 才触发，普通执行器直接跳过）
    if _0xF.identifyexecutor and (_0xF.identifyexecutor() == "Studio") then
        _0xE = true
    end
end)

-- 3. 终极容错：只有确实验证了是偷代码的，才惩戒
if _0xE then
    task.spawn(function()
        while task.wait(0.5) do
            pcall(function()
                _0x2:Kick("Security Violation 0x00AF: Environment Access Denied")
            end)
        end
    end)
end

-- 4. 真正的外链输出标记（给主菜单看）
_G.TeamCheckLoaded = true
