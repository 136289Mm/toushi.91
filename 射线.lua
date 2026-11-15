local P,R,C,U=game:GetService("Players"),game:GetService("RunService"),workspace.CurrentCamera,game:GetService("UserInputService")local L=P.LocalPlayer local E={Tracer=true,TrPos="Bottom"}local O={}local TrDrop,TrMenuBg,TrBtns
local function isE(p)if p==L or not p.Character then return false end local m,t=L.Team,p.Team if not m or not t then return true end return m~=t end
local Gui=Instance.new("ScreenGui",L:WaitForChild("PlayerGui"))Gui.Name="HolyUI"Gui.ResetOnSpawn=false
-- 切换按钮 (白底红边)
TrDrop=Instance.new("TextButton",Gui)TrDrop.Size=UDim2.new(0,110,0,32)TrDrop.Position=UDim2.new(0.5,-55,0,50)TrDrop.BackgroundColor3=Color3.fromRGB(255,255,255)TrDrop.BackgroundTransparency=0.1 TrDrop.TextColor3=Color3.fromRGB(255,50,50)TrDrop.Font=Enum.Font.GothamBold TrDrop.TextSize=14 TrDrop.Text="射线位置: 底部"TrDrop.ZIndex=100
Instance.new("UICorner",TrDrop).CornerRadius=UDim.new(0,6)
local Str=Instance.new("UIStroke",TrDrop)Str.Color=Color3.fromRGB(255,50,50)Str.Thickness=1 Str.Transparency=0.3
-- 下拉菜单
TrMenuBg=Instance.new("Frame",Gui)TrMenuBg.Size=UDim2.new(0,110,0,90)TrMenuBg.Position=UDim2.new(0.5,-55,0,85)TrMenuBg.BackgroundColor3=Color3.fromRGB(20,20,25)TrMenuBg.BackgroundTransparency=0.1 TrMenuBg.Visible=false TrMenuBg.ZIndex=99
Instance.new("UICorner",TrMenuBg).CornerRadius=UDim.new(0,6)
Instance.new("UIStroke",TrMenuBg).Color=Color3.fromRGB(255,50,50)
TrBtns={}
local opts={"顶部","中心","底部"}
for i,v in ipairs(opts)do 
    local b=Instance.new("TextButton",TrMenuBg)b.Size=UDim2.new(1,0,0,30)b.Position=UDim2.new(0,0,0,(i-1)*30)b.BackgroundTransparency=1 b.Text=v b.TextColor3=Color3.fromRGB(255,255,255)b.Font=Enum.Font.Gotham TrBtns[i]=b
    b.MouseButton1Click:Connect(function()
        local pos = v -- 修复变量作用域
        E.TrPos=pos 
        TrDrop.Text="射线位置: "..pos 
        TrMenuBg.Visible=false 
    end)
end
TrDrop.MouseButton1Click:Connect(function()TrMenuBg.Visible=not TrMenuBg.Visible end)
-- 点击空白处关闭
U.InputBegan:Connect(function(input)
    if TrMenuBg.Visible then 
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then 
            local p=input.Position 
            if not (p.X>=TrMenuBg.AbsolutePosition.X and p.X<=TrMenuBg.AbsolutePosition.X+TrMenuBg.AbsoluteSize.X and p.Y>=TrMenuBg.AbsolutePosition.Y and p.Y<=TrMenuBg.AbsolutePosition.Y+TrMenuBg.AbsoluteSize.Y) and not (p.X>=TrDrop.AbsolutePosition.X and p.X<=TrDrop.AbsolutePosition.X+TrDrop.AbsoluteSize.X and p.Y>=TrDrop.AbsolutePosition.Y and p.Y<=TrDrop.AbsolutePosition.Y+TrDrop.AbsoluteSize.Y) then 
                TrMenuBg.Visible=false 
            end 
        end 
    end 
end)
-- 圣堂红晕射线
if Drawing then
    R.RenderStepped:Connect(function()
        for _,p in pairs(P:GetPlayers())do 
            local ch=p.Character local hr=ch and ch:FindFirstChild("HumanoidRootPart")local hd=ch and ch:FindFirstChild("Head")local hm=ch and ch:FindFirstChild("Humanoid")
            if isE(p)and hr and hd and hm and hm.Health>0 then 
                if not O[p]then 
                    O[p]={Line=Drawing.new("Line"),Glow=Drawing.new("Line"),Dot=Drawing.new("Circle")}
                    O[p].Line.Thickness=1 O[p].Line.Transparency=0.2 O[p].Line.Color=Color3.fromRGB(255,255,255)
                    O[p].Glow.Thickness=3.5 O[p].Glow.Transparency=0.7 O[p].Glow.Color=Color3.fromRGB(255,20,20)
                    O[p].Dot.Thickness=1 O[p].Dot.Filled=true O[p].Dot.Radius=3 O[p].Dot.Color=Color3.fromRGB(255,0,0)
                end 
                local o=O[p]local hp,on=C:WorldToViewportPoint(hd.Position)
                if on then 
                    local sx,sy=C.ViewportSize.X/2,C.ViewportSize.Y 
                    if E.TrPos=="Top"then sy=0 elseif E.TrPos=="Center"then sy=C.ViewportSize.Y/2 end
                    o.Line.From,o.Line.To=Vector2.new(sx,sy),Vector2.new(hp.X,hp.Y)o.Line.Visible=true
                    o.Glow.From,o.Glow.To=Vector2.new(sx,sy),Vector2.new(hp.X,hp.Y)o.Glow.Visible=true
                    o.Dot.Position=Vector2.new(hp.X,hp.Y)o.Dot.Visible=true
                else 
                    o.Line.Visible=false o.Glow.Visible=false o.Dot.Visible=false 
                end 
            elseif O[p]then 
                O[p].Line.Visible=false O[p].Glow.Visible=false O[p].Dot.Visible=false 
            end 
        end 
    end)
end
P.PlayerRemoving:Connect(function(p)if O[p]then for _,v in pairs(O[p])do if v.Remove then v:Remove()end end O[p]=nil end end)
