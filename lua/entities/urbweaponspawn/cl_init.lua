include("shared.lua")

function ENT:Draw()
	self:DrawModel()
	local ang = self:GetAngles()    
	ang:RotateAroundAxis(ang:Up(), 1)
	self:SetAngles(ang)
end

net.Receive( "UrbanWeaponSpawnsOpenMenu", function()
	local ent = net.ReadEntity()
	local id = ent:GetNWInt("id")
	local weapon = ent:GetNWString("weapon")
	local pos = ent:GetPos()
	local respawnTime = ent:GetNWFloat("respawnTime")
	local frame = vgui.Create( "UrbanWeapon.Frame" )
	frame:SetSize( 300, 230)
	frame:SetTitle("Editing " .. weapons.Get(weapon).PrintName .. " Spawn")
	frame:Center()
	frame:MakePopup()
	frame.posEntry:SetValue(tostring(pos))
	frame.respawnEntry:SetValue(tostring(respawnTime))
	frame.entity = ent
	frame.weapon = weapon
	frame.pos = pos
	frame.respawnTime = respawnTime
end)