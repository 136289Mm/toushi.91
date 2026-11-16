-- ================== 手机端专属底层拦截引擎 ==================
local _0xPlayers = game:GetService("Players")
local _0xL = _0xPlayers.LocalPlayer

-- 【拦截 1】：暴力拦截“踢人/封禁”指令（让服务器指令无效化）
pcall(function()
    local _0xOldNamecall
    _0xOldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local _0xMethod = getnamecallmethod()
        
        -- 拦截一切想把你踢下线的请求
        if _0xMethod == "Kick" or _0xMethod == "Disconnect" then
            return nil 
        end
        
        return _0xOldNamecall(self, ...)
    end)
end)

-- 【拦截 2】：拦截并篡改“服务端伤害判定”（实现手机端无敌）
-- 很多游戏用 FireServer 或远程事件来扣血，我们在手机上把它拦截掉
pcall(function()
    local _0xOldNC2
    _0xOldNC2 = hookmetamethod(game, "__namecall", function(self, ...)
        local _0xMethod = getnamecallmethod()
        
        -- 如果游戏试图用 FireServer 发送伤害你的事件
        if _0xMethod == "FireServer" then
            local _0xArgs = {...}
            -- 这是一个通用拦截逻辑，如果检测到事件名字带伤害/血量
            if tostring(self):lower():find("damage") or tostring(self):lower():find("health") then
                return nil -- 拦截该封包，服务端收不到扣血请求
            end
        end
        
        return _0xOldNC2(self, ...)
    end)
end)

-- 【拦截 3】：超级轻量化“子弹拦截”（防手机卡顿）
-- 电脑端通常拦截 Ray.new，手机端用轻量级 Hook 来截断
pcall(function()
    local _0xOldRay
    _0xOldRay = hookfunction(Ray.new, function(_0xOrigin, _0xDirection)
        -- 这是一个手机端能完美运行的底层拦截
        -- 这里你可以加入自瞄的终点重定向逻辑
        return _0xOldRay(_0xOrigin, _0xDirection)
    end)
end)
