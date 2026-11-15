local P,R,C=game:GetService("Players"),game:GetService("RunService"),workspace.CurrentCamera local L=P.LocalPlayer local O={}
local R15={{"Head","UpperTorso"},{"UpperTorso","LowerTorso"},{"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},{"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},{"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},{"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"}}
local R6={{"Head","Torso"},{"Torso","Left Arm"},{"Torso","Right Arm"},{"Torso","Left Leg"},{"Torso","Right Leg"}}
local function iE(p)if p==L or not p.Character then return false end local a,b=L.Team,p.Team return a~=b end
local function cln(p)if O[p]then for _,d in pairs(O[p])do if type(d)=="table" then for _,l in pairs(d)do if l.Remove then l:Remove()end end elseif d.Remove then d:Remove()end end O[p]=nil end end
R.RenderStepped:Connect(function()
for _,p in pairs(P:GetPlayers())do local ch=p.Character local r=ch and ch:FindFirstChild("HumanoidRootPart")local u=ch and ch:FindFirstChild("Humanoid")local hd=ch and ch:FindFirstChild("Head")
if iE(p)and r and u and u.Health>0 and hd then
local d=(C.CFrame.Position-r.Position).Magnitude
if d<=400 then
if not O[p]or O[p].Chr~=ch then cln(p)O[p]={Chr=ch,Ln={},Cross={}}for i=1,15 do local l=Drawing.new("Line")l.Thickness=1.5 O[p].Ln[i]=l end for i=1,2 do local l=Drawing.new("Line")l.Thickness=2 l.Color=Color3.fromRGB(255,0,0)O[p].Cross[i]=l end end
local o=O[p]local isR15=(ch:FindFirstChild("UpperTorso")~=nil)local bList=isR15 and R15 or R6
local col=Color3.fromRGB(0,255,255)
local idx=1
for _,v in ipairs(bList)do local p1=ch:FindFirstChild(v[1])local p2=ch:FindFirstChild(v[2])
if p1 and p2 and idx<=15 then local s1,on1=C:WorldToViewportPoint(p1.Position)local s2,on2=C:WorldToViewportPoint(p2.Position)
if on1 and on2 then o.Ln[idx].From=Vector2.new(s1.X,s1.Y)o.Ln[idx].To=Vector2.new(s2.X,s2.Y)
-- 动态渐变：上半身青色，下半身偏红
if v[1]=="Head"or v[1]=="UpperTorso"then o.Ln[idx].Color=Color3.fromRGB(0,255,255)else o.Ln[idx].Color=Color3.fromRGB(255,50,50)end
o.Ln[idx].Visible=true idx=idx+1 else o.Ln[idx].Visible=false end end end
for i=idx,15 do o.Ln[i].Visible=false end
-- 十字星瞄准爆头
local hs,hon=C:WorldToViewportPoint(hd.Position)if hon then local sz=6 local cx,cy=hs.X,hs.Y o.Cross[1].From=Vector2.new(cx-sz,cy)o.Cross[1].To=Vector2.new(cx+sz,cy)o.Cross[1].Visible=true o.Cross[2].From=Vector2.new(cx,cy-sz)o.Cross[2].To=Vector2.new(cx,cy+sz)o.Cross[2].Visible=true else o.Cross[1].Visible=false o.Cross[2].Visible=false end
else cln(p)end
else cln(p)end
end
end)
P.PlayerRemoving:Connect(cln)
