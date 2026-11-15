local P,R,C=game:GetService("Players"),game:GetService("RunService"),workspace.CurrentCamera local L=P.LocalPlayer local O={}
local function iE(p)if p==L or not p.Character then return false end local a,b=L.Team,p.Team return a~=b end
local function cln(p)if O[p]then for _,l in pairs(O[p])do if l.Remove then l:Remove()end end O[p]=nil end end
R.RenderStepped:Connect(function()
for _,p in pairs(P:GetPlayers())do 
local ch=p.Character 
local r=ch and ch:FindFirstChild("HumanoidRootPart") 
local u=ch and ch:FindFirstChild("Humanoid") 
if iE(p) and r and u and u.Health>0 then
local d=(C.CFrame.Position-r.Position).Magnitude
if d<=500 then
if not O[p] or O[p].C~=ch then 
cln(p) O[p]={C=ch,L={}} 
for i=1,15 do local l=Drawing.new("Line") l.Thickness=1.5 l.Color=Color3.fromRGB(0,255,100) O[p].L[i]=l end 
end
local o=O[p] local isR15 = ch:FindFirstChild("UpperTorso") ~= nil
if isR15 then
-- 彻底拆开 R15 的14根骨骼（绝对不循环）
local p1,p2,s1,s2,o1,o2
p1=ch:FindFirstChild("Head") p2=ch:FindFirstChild("UpperTorso") if p1 and p2 then s1,o1=C:WorldToViewportPoint(p1.Position) s2,o2=C:WorldToViewportPoint(p2.Position) if o1 and o2 then o.L[1].From=Vector2.new(s1.X,s1.Y) o.L[1].To=Vector2.new(s2.X,s2.Y) o.L[1].Visible=true else o.L[1].Visible=false end end
p1=ch:FindFirstChild("UpperTorso") p2=ch:FindFirstChild("LowerTorso") if p1 and p2 then s1,o1=C:WorldToViewportPoint(p1.Position) s2,o2=C:WorldToViewportPoint(p2.Position) if o1 and o2 then o.L[2].From=Vector2.new(s1.X,s1.Y) o.L[2].To=Vector2.new(s2.X,s2.Y) o.L[2].Visible=true else o.L[2].Visible=false end end
p1=ch:FindFirstChild("UpperTorso") p2=ch:FindFirstChild("LeftUpperArm") if p1 and p2 then s1,o1=C:WorldToViewportPoint(p1.Position) s2,o2=C:WorldToViewportPoint(p2.Position) if o1 and o2 then o.L[3].From=Vector2.new(s1.X,s1.Y) o.L[3].To=Vector2.new(s2.X,s2.Y) o.L[3].Visible=true else o.L[3].Visible=false end end
p1=ch:FindFirstChild("LeftUpperArm") p2=ch:FindFirstChild("LeftLowerArm") if p1 and p2 then s1,o1=C:WorldToViewportPoint(p1.Position) s2,o2=C:WorldToViewportPoint(p2.Position) if o1 and o2 then o.L[4].From=Vector2.new(s1.X,s1.Y) o.L[4].To=Vector2.new(s2.X,s2.Y) o.L[4].Visible=true else o.L[4].Visible=false end end
p1=ch:FindFirstChild("LeftLowerArm") p2=ch:FindFirstChild("LeftHand") if p1 and p2 then s1,o1=C:WorldToViewportPoint(p1.Position) s2,o2=C:WorldToViewportPoint(p2.Position) if o1 and o2 then o.L[5].From=Vector2.new(s1.X,s1.Y) o.L[5].To=Vector2.new(s2.X,s2.Y) o.L[5].Visible=true else o.L[5].Visible=false end end
p1=ch:FindFirstChild("UpperTorso") p2=ch:FindFirstChild("RightUpperArm") if p1 and p2 then s1,o1=C:WorldToViewportPoint(p1.Position) s2,o2=C:WorldToViewportPoint(p2.Position) if o1 and o2 then o.L[6].From=Vector2.new(s1.X,s1.Y) o.L[6].To=Vector2.new(s2.X,s2.Y) o.L[6].Visible=true else o.L[6].Visible=false end end
p1=ch:FindFirstChild("RightUpperArm") p2=ch:FindFirstChild("RightLowerArm") if p1 and p2 then s1,o1=C:WorldToViewportPoint(p1.Position) s2,o2=C:WorldToViewportPoint(p2.Position) if o1 and o2 then o.L[7].From=Vector2.new(s1.X,s1.Y) o.L[7].To=Vector2.new(s2.X,s2.Y) o.L[7].Visible=true else o.L[7].Visible=false end end
p1=ch:FindFirstChild("RightLowerArm") p2=ch:FindFirstChild("RightHand") if p1 and p2 then s1,o1=C:WorldToViewportPoint(p1.Position) s2,o2=C:WorldToViewportPoint(p2.Position) if o1 and o2 then o.L[8].From=Vector2.new(s1.X,s1.Y) o.L[8].To=Vector2.new(s2.X,s2.Y) o.L[8].Visible=true else o.L[8].Visible=false end end
p1=ch:FindFirstChild("LowerTorso") p2=ch:FindFirstChild("LeftUpperLeg") if p1 and p2 then s1,o1=C:WorldToViewportPoint(p1.Position) s2,o2=C:WorldToViewportPoint(p2.Position) if o1 and o2 then o.L[9].From=Vector2.new(s1.X,s1.Y) o.L[9].To=Vector2.new(s2.X,s2.Y) o.L[9].Visible=true else o.L[9].Visible=false end end
p1=ch:FindFirstChild("LeftUpperLeg") p2=ch:FindFirstChild("LeftLowerLeg") if p1 and p2 then s1,o1=C:WorldToViewportPoint(p1.Position) s2,o2=C:WorldToViewportPoint(p2.Position) if o1 and o2 then o.L[10].From=Vector2.new(s1.X,s1.Y) o.L[10].To=Vector2.new(s2.X,s2.Y) o.L[10].Visible=true else o.L[10].Visible=false end end
p1=ch:FindFirstChild("LeftLowerLeg") p2=ch:FindFirstChild("LeftFoot") if p1 and p2 then s1,o1=C:WorldToViewportPoint(p1.Position) s2,o2=C:WorldToViewportPoint(p2.Position) if o1 and o2 then o.L[11].From=Vector2.new(s1.X,s1.Y) o.L[11].To=Vector2.new(s2.X,s2.Y) o.L[11].Visible=true else o.L[11].Visible=false end end
p1=ch:FindFirstChild("LowerTorso") p2=ch:FindFirstChild("RightUpperLeg") if p1 and p2 then s1,o1=C:WorldToViewportPoint(p1.Position) s2,o2=C:WorldToViewportPoint(p2.Position) if o1 and o2 then o.L[12].From=Vector2.new(s1.X,s1.Y) o.L[12].To=Vector2.new(s2.X,s2.Y) o.L[12].Visible=true else o.L[12].Visible=false end end
p1=ch:FindFirstChild("RightUpperLeg") p2=ch:FindFirstChild("RightLowerLeg") if p1 and p2 then s1,o1=C:WorldToViewportPoint(p1.Position) s2,o2=C:WorldToViewportPoint(p2.Position) if o1 and o2 then o.L[13].From=Vector2.new(s1.X,s1.Y) o.L[13].To=Vector2.new(s2.X,s2.Y) o.L[13].Visible=true else o.L[13].Visible=false end end
p1=ch:FindFirstChild("RightLowerLeg") p2=ch:FindFirstChild("RightFoot") if p1 and p2 then s1,o1=C:WorldToViewportPoint(p1.Position) s2,o2=C:WorldToViewportPoint(p2.Position) if o1 and o2 then o.L[14].From=Vector2.new(s1.X,s1.Y) o.L[14].To=Vector2.new(s2.X,s2.Y) o.L[14].Visible=true else o.L[14].Visible=false end end
o.L[15].Visible=false
else
-- 彻底拆开 R6 的5根骨骼
local p1,p2,s1,s2,o1,o2
p1=ch:FindFirstChild("Head") p2=ch:FindFirstChild("Torso") if p1 and p2 then s1,o1=C:WorldToViewportPoint(p1.Position) s2,o2=C:WorldToViewportPoint(p2.Position) if o1 and o2 then o.L[1].From=Vector2.new(s1.X,s1.Y) o.L[1].To=Vector2.new(s2.X,s2.Y) o.L[1].Visible=true else o.L[1].Visible=false end end
p1=ch:FindFirstChild("Torso") p2=ch:FindFirstChild("Left Arm") if p1 and p2 then s1,o1=C:WorldToViewportPoint(p1.Position) s2,o2=C:WorldToViewportPoint(p2.Position) if o1 and o2 then o.L[2].From=Vector2.new(s1.X,s1.Y) o.L[2].To=Vector2.new(s2.X,s2.Y) o.L[2].Visible=true else o.L[2].Visible=false end end
p1=ch:FindFirstChild("Torso") p2=ch:FindFirstChild("Right Arm") if p1 and p2 then s1,o1=C:WorldToViewportPoint(p1.Position) s2,o2=C:WorldToViewportPoint(p2.Position) if o1 and o2 then o.L[3].From=Vector2.new(s1.X,s1.Y) o.L[3].To=Vector2.new(s2.X,s2.Y) o.L[3].Visible=true else o.L[3].Visible=false end end
p1=ch:FindFirstChild("Torso") p2=ch:FindFirstChild("Left Leg") if p1 and p2 then s1,o1=C:WorldToViewportPoint(p1.Position) s2,o2=C:WorldToViewportPoint(p2.Position) if o1 and o2 then o.L[4].From=Vector2.new(s1.X,s1.Y) o.L[4].To=Vector2.new(s2.X,s2.Y) o.L[4].Visible=true else o.L[4].Visible=false end end
p1=ch:FindFirstChild("Torso") p2=ch:FindFirstChild("Right Leg") if p1 and p2 then s1,o1=C:WorldToViewportPoint(p1.Position) s2,o2=C:WorldToViewportPoint(p2.Position) if o1 and o2 then o.L[5].From=Vector2.new(s1.X,s1.Y) o.L[5].To=Vector2.new(s2.X,s2.Y) o.L[5].Visible=true else o.L[5].Visible=false end end
for i=6,15 do o.L[i].Visible=false end
end
else cln(p)end
else cln(p)end
end
end)
P.PlayerRemoving:Connect(cln)
