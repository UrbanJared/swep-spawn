local PANEL = {}

function PANEL:Init()
	self.entity = nil
	local weaponBtn = self:Add("DButton")
	weaponBtn:SetText("Change Weapon")
	weaponBtn:Dock(TOP)
	weaponBtn:SetTall(40)
	weaponBtn.DoClick = function()
		local wepframe = vgui.Create( "UrbanWeapon.WeaponFrame" )
		wepframe:SetSize( 500, 500)
		wepframe:SetTitle("Select a Weapon")
		wepframe:Center()
		wepframe:MakePopup()
		wepframe.base = self
	end
	local weaponLabel = self:Add("DLabel")
	weaponLabel:SetText("Weapon Class")
	weaponLabel:Dock(TOP)
	self.weaponEntry = self:Add("DTextEntry")
	self.weaponEntry:Dock(TOP)
	local respawnLabel = self:Add("DLabel")
	respawnLabel:SetText("Respawn Time (seconds)")
	respawnLabel:Dock(TOP)
	self.respawnEntry = self:Add("DNumberWang")
	self.respawnEntry:Dock(TOP)
	self.respawnEntry:SetMin(0.7)
	self.respawnEntry:SetMax(1000000)

	local saveBtn = self:Add("DButton")
	saveBtn:SetText("Save")
	saveBtn:SetTall(35)
	saveBtn:Dock(BOTTOM)
	saveBtn.DoClick = function()
		if !weapons.Get(self.weaponEntry:GetValue()) then ply:PrintMessage( HUD_PRINTTALK, "Invalid weapon" ) return end
		net.Start("UrbanWeaponSpawnsSetConfig")
			net.WriteEntity(self.entity)
			net.WriteString(self.weaponEntry:GetValue())
			net.WriteFloat(self.respawnEntry:GetValue())
		net.SendToServer()
		self:Remove()
	end
	local deleteBtn = self:Add("DButton")
	deleteBtn:SetText("Delete")
	deleteBtn:SetTall(35)
	deleteBtn:DockMargin(0,0,0,5)
	deleteBtn:Dock(BOTTOM)
	deleteBtn.DoClick = function()
		local frame = vgui.Create( "UrbanWeapon.DeleteFrame" )
		frame:SetSize( 280, 180)
		frame:SetTitle("Delete?")
		frame:Center()
		frame:MakePopup()
		frame.base = self
	end
end

vgui.Register("UrbanWeapon.Frame", PANEL, "DFrame")
