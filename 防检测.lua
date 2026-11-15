local _0xP = game:GetService("Players")
local _0xR = game:GetService("RunService")
local _0xL = _0xP.LocalPlayer
local _0xG = _0xL:WaitForChild("PlayerGui")
local _0xSuccess, _0xErr = pcall(function()
    local _0xC = {}
    for _0xI = 1, 0x100 do
        _0xC[_0xI] = tostring(math.random(0x10000, 0xFFFFF)) .. "_" .. tostring(_0xI)
    end
    local function _0xF1(_0xV1, _0xV2)
        local _0xT1 = (_0xV1 * 0xECB1F) % 0x1EF3A6B
        local _0xT2 = (_0xV2 * 0x2FB1B87) % 0x5210079
        return _0xT1 + _0xT2, _0xT1, _0xT2
    end
    local function _0xF2(_0xObj)
        if _0xObj and _0xObj.Parent then
            pcall(function()
                local _0xH1 = math.random(0x1000000, 0x9999999)
                local _0xS = ""
                for _0xK = 1, 0x10 do
                    _0xS = _0xS .. string.char(math.random(0x41, 0x5A))
                end
                _0xObj.Name = "_0x" .. string.format("%X", _0xH1) .. "_" .. _0xS
            end)
        end
    end
    if hookmetamethod and hookfunction and checkcaller then
        pcall(function()
            local _0xOldNC
            _0xOldNC = hookmetamethod(game, "__namecall", function(self, ...)
                local _0xM = getnamecallmethod()
                _0xF1(math.random(1, 100), math.random(1, 100))
                if _0xM == "Kick" or _0xM == "GetClientId" or _0xM == "GetLogHistory" or _0xM == "GetObjects" then return nil end
                return _0xOldNC(self, ...)
            end)
        end)
        pcall(function()
            local _0xOldIdx
            _0xOldIdx = hookmetamethod(game, "__index", function(self, key)
                _0xF1(math.random(1, 10), math.random(1, 10))
                if key == "GetObjects" or key == "Kick" then return nil end
                return _0xOldIdx(self, key)
            end)
        end)
        pcall(function()
            if game.HttpGet then
                local _0xOldHttp
                _0xOldHttp = hookfunction(game.HttpGet, function(self, url, ...)
                    local _0xUrl = tostring(url)
                    if string.find(_0xUrl, "github") or string.find(_0xUrl, "githubusercontent") or string.find(_0xUrl, "raw") then
                        return _0xOldHttp(self, url, ...)
                    end
                    return _0xOldHttp(self, url, ...)
                end)
            end
        end)
    end
    _0xR.Heartbeat:Connect(function()
        for _0xJ = 1, 0x10 do _0xF1(_0xJ, _0xJ * 2) end
        for _, _0xV in pairs(_0xG:GetChildren()) do
            if _0xV:IsA("ScreenGui") and string.sub(_0xV.Name, 1, 3) ~= "_0x" then
                if _0xV.Name == "SonicMenu" or _0xV.Name == "Highlight" or _0xV.Name == "DistESP" then _0xF2(_0xV) end
            end
        end
    end)
end)
_G.AntiBanStatus = _0xSuccess
