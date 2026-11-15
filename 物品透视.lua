local _0xP = game:GetService("Players")
local _0xR = game:GetService("RunService")
local _0xC = workspace.CurrentCamera
local _0xL = _0xP.LocalPlayer
local _0xD = {}

-- 障眼法混淆
local _0xMask = 0x9A4F
local function _0xDecrypt(_0xNum) return (_0xNum % _0xMask) + 0x10 end

local function _0xIsItem(_0xObj)
    if not _0xObj or not _0xObj:IsA("Tool") or not _0xObj:FindFirstChild("Handle") then return false end
    if _0xObj.Parent and _0xObj.Parent:IsA("Backpack") then return false end
    if _0xObj.Parent and _0xObj.Parent:FindFirstChild("Humanoid") then return false end
    return true
end

_0xR.RenderStepped:Connect(function()
    _0xDecrypt(math.random(1, 100))
    local _0xFound = {}
    local _0xMyRoot = _0xL.Character and _0xL.Character:FindFirstChild("HumanoidRootPart")
    
    for _, _0xObj in pairs(workspace:GetDescendants()) do
        if _0xIsItem(_0xObj) then
            local _0xHandle = _0xObj.Handle
            local _0xCanDraw = true
            
            -- 【核心性能保护 1】：超过 300 格的物品，直接不画（防卡顿）
            if _0xMyRoot then
                local _0xDistToMe = (_0xMyRoot.Position - _0xHandle.Position).Magnitude
                if _0xDistToMe > 300 then _0xCanDraw = false end
            end

            if _0xCanDraw then
                _0xFound[_0xObj] = true
                
                if not _0xD[_0xObj] then
                    _0xD[_0xObj] = {Lines = {}, Box = Drawing.new("Square"), Text = Drawing.new("Text")}
                    _0xD[_0xObj].Box.Thickness = 1
                    _0xD[_0xObj].Text.Size = 12
                    _0xD[_0xObj].Text.Center = true
                    _0xD[_0xObj].Text.Outline = true
                    _0xD[_0xObj].Text.Font = 2
                    
                    -- 预先计算顶点
                    local _0xVerts = {}
                    for _, _0xPart in pairs(_0xObj:GetChildren()) do
                        if _0xPart:IsA("BasePart") then
                            local _0xSize = _0xPart.Size / 2
                            table.insert(_0xVerts, _0xPart.CFrame * Vector3.new(-_0xSize.X, -_0xSize.Y, -_0xSize.Z))
                            table.insert(_0xVerts, _0xPart.CFrame * Vector3.new( _0xSize.X, -_0xSize.Y, -_0xSize.Z))
                            table.insert(_0xVerts, _0xPart.CFrame * Vector3.new(-_0xSize.X,  _0xSize.Y, -_0xSize.Z))
                            table.insert(_0xVerts, _0xPart.CFrame * Vector3.new( _0xSize.X,  _0xSize.Y, -_0xSize.Z))
                            table.insert(_0xVerts, _0xPart.CFrame * Vector3.new(-_0xSize.X, -_0xSize.Y,  _0xSize.Z))
                            table.insert(_0xVerts, _0xPart.CFrame * Vector3.new( _0xSize.X, -_0xSize.Y,  _0xSize.Z))
                            table.insert(_0xVerts, _0xPart.CFrame * Vector3.new(-_0xSize.X,  _0xSize.Y,  _0xSize.Z))
                            table.insert(_0xVerts, _0xPart.CFrame * Vector3.new( _0xSize.X,  _0xSize.Y,  _0xSize.Z))
                        end
                    end
                    _0xD[_0xObj].Points = _0xVerts
                    for i = 1, #_0xVerts + 4 do
                        local _0xL1 = Drawing.new("Line")
                        _0xL1.Thickness = 1.2
                        _0xL1.Transparency = 0.3
                        _0xL1.Color = Color3.fromRGB(0, 255, 255)
                        table.insert(_0xD[_0xObj].Lines, _0xL1)
                    end
                end
                
                local _0xData = _0xD[_0xObj]
                local _0xPos, _0xOn = _0xC:WorldToViewportPoint(_0xHandle.Position)
                
                -- 【核心性能保护 2】：不在屏幕视野里的，直接不画
                if _0xOn then
                    local _0xDist = math.floor((_0xC.CFrame.Position - _0xHandle.Position).Magnitude)
                    local _0xColor = Color3.fromRGB(0, 255, 255)
                    if _0xDist < 100 then _0xColor = Color3.fromRGB(0, 255, 150) end 
                    
                    local _0xLineIdx = 1
                    for _, _0xV in ipairs(_0xData.Points) do
                        local _0xSP, _0xVOn = _0xC:WorldToViewportPoint(_0xV)
                        if _0xVOn then
                            for _, _0xV2 in ipairs(_0xData.Points) do
                                if _0xV ~= _0xV2 and _0xLineIdx <= #_0xData.Lines then
                                    local _0xDist2 = (_0xV - _0xV2).Magnitude
                                    if _0xDist2 > 0 and _0xDist2 < 5 then 
                                        local _0xSP2, _0xV2On = _0xC:WorldToViewportPoint(_0xV2)
                                        if _0xV2On then
                                            local _0xL1 = _0xData.Lines[_0xLineIdx]
                                            _0xL1.From = Vector2.new(_0xSP.X, _0xSP.Y)
                                            _0xL1.To = Vector2.new(_0xSP2.X, _0xSP2.Y)
                                            _0xL1.Color = _0xColor
                                            _0xL1.Visible = true
                                            _0xLineIdx = _0xLineIdx + 1
                                        end
                                    end
                                end
                            end
                        end
                    end
                    for i = _0xLineIdx, #_0xData.Lines do _0xData.Lines[i].Visible = false end
                    
                    _0xData.Box.Size = Vector2.new(40, 40)
                    _0xData.Box.Position = Vector2.new(_0xPos.X - 20, _0xPos.Y - 20)
                    _0xData.Box.Visible = true
                    _0xData.Box.Color = _0xColor
                    
                    _0xData.Text.Text = _0xObj.Name .. " [" .. _0xDist .. "m]"
                    _0xData.Text.Position = Vector2.new(_0xPos.X, _0xPos.Y - 30)
                    _0xData.Text.Visible = true
                else
                    _0xData.Box.Visible = false
                    _0xData.Text.Visible = false
                    for _, _0xL1 in pairs(_0xData.Lines) do _0xL1.Visible = false end
                end
            end
        end
    end
    
    -- 清理被捡走或超出距离的物品
    for _0xObj, _0xData in pairs(_0xD) do
        if not _0xFound[_0xObj] then
            _0xData.Box:Remove()
            _0xData.Text:Remove()
            for _, _0xL1 in pairs(_0xData.Lines) do _0xL1:Remove() end
            _0xD[_0xObj] = nil
        end
    end
end)
