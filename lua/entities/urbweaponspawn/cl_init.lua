include("shared.lua")

function ENT:Draw()
	self:DrawModel()
	local ang = self:GetAngles()    
	ang:RotateAroundAxis(ang:Up(), 1)
	self:SetAngles(ang)
end

net.Receive( "UrbanWeaponSpawnsOpenMenu", function() 
	local w = ScrW()
	local h = ScrH()
	local ent = net.ReadEntity()
	local scale = 0.4
	local frame = vgui.Create( "UrbanWeapon.Frame" )
	frame:SetSize( 300, 230)
	frame:SetTitle("Editing " .. weapons.Get(ent:GetNWInt("weapon")).PrintName .. " Spawn")
	frame:Center()
	frame:MakePopup()
	frame.posEntry:SetText(tostring(ent:GetPos()))
	frame.respawnEntry:SetText(tostring(ent:GetNWInt("respawnTime")))
end)