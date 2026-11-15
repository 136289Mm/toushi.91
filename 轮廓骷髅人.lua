local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local SkullCache = {}

local SkullShape = {
    {{0.2,0.2},{0.4,0.05}}, {{0.4,0.05},{0.6,0.05}}, {{0.6,0.05},{0.8,0.2}},
    {{0.8,0.2},{0.8,0.6}},  {{0.8,0.6},{0.2,0.6}},  {{0.2,0.6},{0.2,0.2}},
    {{0.3,0.3},{0.45,0.3}}, {{0.45,0.3},{0.45,0.45}},{{0.45,0.45},{0.3,0.45}},
    {{0.3,0.45},{0.3,0.3}}, {{0.55,0.3},{0.7,0.3}}, {{0.7,0.3},{0.7,0.45}},
    {{0.7,0.45},{0.55,0.45}},{{0.55,0.45},{0.55,0.3}},{{0.5,0.5},{0.5,0.6}},
    {{0.3,0.65},{0.7,0.65}},{{0.3,0.65},{0.3,0.75}},{{0.4,0.65},{0.4,0.75}},
    {{0.5,0.65},{0.5,0.75}},{{0.6,0.65},{0.6,0.75}},{{0.7,0.65},{0.7,0.75}},
    {{0.3,0.75},{0.7,0.75}}
}

local function isEnemy(player)
    if player == LocalPlayer or not player.Character then return false end
    local myTeam = LocalPlayer.Team
    local pTeam = player.Team
    if not myTeam or not pTeam then return true end
    return myTeam ~= pTeam
end

local function cleanPlayer(player)
    if SkullCache[player] then
        for _, line in pairs(SkullCache[player]) do
            if line.Remove then line:Remove() end
        end
        SkullCache[player] = nil
    end
end

RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        local char = player.Character
        local head = char and char:FindFirstChild("Head")
        local humanoid = char and char:FindFirstChild("Humanoid")

        if isEnemy(player) and head and humanoid and humanoid.Health > 0 then
            if not SkullCache[player] then
                SkullCache[player] = {
                    Lines = {},
                    TargetPos = nil, -- 用于平滑位置
                    CurrentPos = nil
                }
                for i = 1, #SkullShape do
                    local line = Drawing.new("Line")
                    line.Thickness = 1.5
                    line.Color = Color3.fromRGB(255, 255, 255)
                    line.Transparency = 0.2
                    table.insert(SkullCache[player].Lines, line)
                end
            end

            local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1.5, 0))
            local cache = SkullCache[player]

            if onScreen then
                -- 防高速抖动：Lerp 平滑靠拢（0.4 是跟随灵敏度，越大越紧，越小越平滑）
                local smoothFactor = 0.4
                if not cache.TargetPos then
                    cache.TargetPos = screenPos
                    cache.CurrentPos = screenPos
                else
                    cache.TargetPos = screenPos
                    cache.CurrentPos = cache.CurrentPos:Lerp(cache.TargetPos, smoothFactor)
                end

                local size = 25
                local baseX = cache.CurrentPos.X - size / 2
                local baseY = cache.CurrentPos.Y - size / 2

                for i, points in ipairs(SkullShape) do
                    local line = cache.Lines[i]
                    line.From = Vector2.new(baseX + points[1][1] * size, baseY + points[1][2] * size)
                    line.To = Vector2.new(baseX + points[2][1] * size, baseY + points[2][2] * size)
                    line.Visible = true
                end
            else
                for _, line in pairs(cache.Lines) do
                    line.Visible = false
                end
            end
        else
            cleanPlayer(player)
        end
    end
end)

Players.PlayerRemoving:Connect(cleanPlayer)
