local P,R,C=game:GetService("Players"),game:GetService("RunService"),workspace.CurrentCamera local L=P.LocalPlayer local O={}
local function iE(p)if p==L or not p.Character then return false end local a,b=L.Team,p.Team return a~=b end
local function cln(p)if O[p]then for _,l in pairs(O[p])do if l.Remove then l:Remove()end end O[p]=nil end end
local function iV(t)if not t then return false end local rp=RaycastParams.new()rp.FilterType=Enum.RaycastFilterType.Exclude rp.FilterDescendantsInstances={L.Character}local r=workspace:Raycast(C.CFrame.Position,t.Position-C.CFrame.Position,rp)return r==nil or r.Instance:IsDescendantOf(t.Parent)end

R.RenderStepped:Connect(function()
local tm=tick()*5
for _,p in pairs(P:GetPlayers())do 
local ch=p.Character 
local r=ch and ch:FindFirstChild("HumanoidRootPart") 
local u=ch and ch:FindFirstChild("Humanoid") 
local hd=ch and ch:FindFirstChild("Head")
if iE(p) and r and u and hd and u.Health>0 then
local d=(C.CFrame.Position-r.Position).Magnitude
if d<=800 then
if not O[p] or O[p].C~=ch then 
cln(p) O[p]={C=ch,Line={},Txt={}} 
-- 四角框需要 8 根线
for i=1,8 do local l=Drawing.new("Line") l.Thickness=1.5 O[p].Line[i]=l end 
-- 3根文字 (名字、距离、武器)
for i=1,3 do local t=Drawing.new("Text") t.Size=13 t.Center=true t.Outline=true t.Font=2 O[p].Txt[i]=t end
end
local o=O[p]
local size = ch:GetExtentsSize()
local pos = r.Position
local st,ot=C:WorldToViewportPoint(pos + Vector3.new(0, size.Y/2, 0))
local sb,ob=C:WorldToViewportPoint(pos - Vector3.new(0, size.Y/2, 0))
if ot and ob then
local h = math.abs(st.Y - sb.Y)
local w = h / 2.2
local x = st.X - w/2
local y = st.Y
-- 四角线的长度：宽和高的 20%
local cw = w * 0.2
local chh = h * 0.2
local vis = iV(hd)
local alpha = vis and 1 or 0.3
local col = vis and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(150, 50, 50)
local hpScale = u.Health / u.MaxHealth
local hpCol = Color3.fromHSV(hpScale * 0.3, 1, 1)
if hpScale < 0.3 and math.sin(tm) > 0 then hpCol = Color3.fromRGB(255, 0, 0) end

-- 【手工绘制四角框】
-- 左上角
o.Line[1].From=Vector2.new(x,y) o.Line[1].To=Vector2.new(x+cw,y)
o.Line[2].From=Vector2.new(x,y) o.Line[2].To=Vector2.new(x,y+chh)
-- 右上角
o.Line[3].From=Vector2.new(x+w,y) o.Line[3].To=Vector2.new(x+w-cw,y)
o.Line[4].From=Vector2.new(x+w,y) o.Line[4].To=Vector2.new(x+w,y+chh)
-- 左下角
o.Line[5].From=Vector2.new(x,y+h) o.Line[5].To=Vector2.new(x+cw,y+h)
o.Line[6].From=Vector2.new(x,y+h) o.Line[6].To=Vector2.new(x,y+h-chh)
-- 右下角
o.Line[7].From=Vector2.new(x+w,y+h) o.Line[7].To=Vector2.new(x+w-cw,y+h)
o.Line[8].From=Vector2.new(x+w,y+h) o.Line[8].To=Vector2.new(x+w,y+h-chh)

for i=1,8 do
    o.Line[i].Color=col
    o.Line[i].Transparency=alpha
    o.Line[i].Visible=true
end

-- 极简排版：名字在上，距离在下
o.Txt[1].Text=p.Name
o.Txt[1].Position=Vector2.new(st.X, y-18)
o.Txt[1].Color=col
o.Txt[1].Transparency=alpha
o.Txt[1].Visible=true

o.Txt[2].Text=math.floor(d).."m"
o.Txt[2].Position=Vector2.new(st.X, y+h+4)
o.Txt[2].Color=Color3.fromRGB(200, 200, 200)
o.Txt[2].Transparency=alpha
o.Txt[2].Visible=true

local held = "空手"
for _, item in pairs(ch:GetChildren()) do
    if item:IsA("Tool") then held = item.Name break end
end
o.Txt[3].Text="["..held.."]"
o.Txt[3].Position=Vector2.new(st.X, y+h+20)
o.Txt[3].Color=hpCol -- 武器名跟着血量变色
o.Txt[3].Transparency=alpha
o.Txt[3].Visible=true

else
for i=1,8 do o.Line[i].Visible=false end
for i=1,3 do o.Txt[i].Visible=false end
end
else cln(p)end
else cln(p)end
end
end)
P.PlayerRemoving:Connect(cln)
