include("shared.lua")

function ENT:Draw()
	self:DrawModel()
	local ang = self:GetAngles()    
	ang:RotateAroundAxis(ang:Up(), 1)
	self:SetAngles(ang)
end

net.Receive( "UrbanWeaponSpawnsOpenMenu", function()
	local ent = net.ReadEntity()
	local weapon = ent:GetNWString("weapon")
	local frame = vgui.Create( "UrbanWeapon.Frame" )
	frame:SetSize( 300, 200)
	frame:SetTitle("Editing " .. weapons.Get(weapon).PrintName .. " Spawn")
	frame:Center()
	frame:MakePopup()
	frame.respawnEntry:SetValue(ent:GetNWFloat("respawnTime"))
	frame.entity = ent
	frame.weapon = weapon
end)