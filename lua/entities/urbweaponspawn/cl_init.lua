include("shared.lua")

function ENT:Draw()
	self:DrawModel()
	local ang = self:GetAngles()    
	ang:RotateAroundAxis(ang:Up(), 1)
	self:SetAngles(ang)
end

net.Receive( "UrbanWeaponSpawnsOpenMenu", function()
	local ent = net.ReadEntity()
	local frame = vgui.Create( "UrbanWeapon.Frame" )
	frame:SetSize( 300, 230)
	frame:SetTitle("Editing " .. weapons.Get(ent:GetNWString("weapon")).PrintName .. " Spawn")
	frame:Center()
	frame:MakePopup()
	frame.posEntry:SetValue(tostring(ent:GetPos()))
	frame.respawnEntry:SetValue(tostring(ent:GetNWFloat("respawnTime")))
	frame.entity = ent
end)