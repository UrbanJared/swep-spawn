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
	local id = net.ReadUInt(32)
	local ent = net.ReadEntity()
	local scale = 0.4
	local frame = vgui.Create( "UrbanWeapon.Frame" )
	frame:SetSize( w * scale, h * scale)
	frame:SetTitle("Edit")
	frame:Center()
	frame:MakePopup()
end)