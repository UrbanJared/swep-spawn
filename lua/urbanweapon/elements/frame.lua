local PANEL = {}

function PANEL:Init()
	self.entity = nil
	self.weapon = nil
	self.pos = nil
	self.respawnTime = nil
	self.weaponBtn = self:Add("DButton")
	self.weaponBtn:SetText("Change Weapon")
	self.weaponBtn:Dock(TOP)
	self.weaponBtn.DoClick = function()
		local wepframe = vgui.Create( "UrbanWeapon.WeaponFrame" )
		wepframe:SetSize( 500, 500)
		wepframe:SetTitle("Select a Weapon")
		wepframe:Center()
		wepframe:MakePopup()
		wepframe.base = self
	end
	local posLabel = self:Add("DLabel")
	posLabel:SetText("Position")
	posLabel:Dock(TOP)
	self.posEntry = self:Add("DTextEntry")
	self.posEntry:Dock(TOP)
	self.posEntry:SetEditable(false)
	local respawnLabel = self:Add("DLabel")
	respawnLabel:SetText("Respawn Time (seconds)")
	respawnLabel:Dock(TOP)
	self.respawnEntry = self:Add("DNumberWang")
	self.respawnEntry:Dock(TOP)

	local saveBtn = self:Add("DButton")
	saveBtn:SetText("Save")
	saveBtn:SetTall(40)
	saveBtn:Dock(BOTTOM)
	saveBtn.DoClick = function()
		net.Start("UrbanWeaponSpawnsSetConfig")
			net.WriteEntity(self.entity)
			--net.WriteInt(id, 32)
			net.WriteString(tostring(self.weapon))
			net.WriteString(tostring(self.pos))
			net.WriteFloat(self.respawnEntry:GetValue())
		net.SendToServer()
	end
	local deleteBtn = self:Add("DButton")
	deleteBtn:SetText("Delete")
	deleteBtn:SetTall(40)
	deleteBtn:DockMargin(0,0,0,5)
	deleteBtn:Dock(BOTTOM)
	deleteBtn.DoClick = function()
		local frame = vgui.Create( "UrbanWeapon.DeleteFrame" )
		frame:SetSize( 280, 180)
		frame:SetTitle("Delete?")
		frame:Center()
		frame:MakePopup()
		frame.entity = self.entity
		frame.base = self
	end
end

function PANEL:SelectWep(weapon)
	self.weapon = weapon
	self.weaponBtn:SetText(tostring(weapons.Get(weapon).PrintName))
end
--
--function PANEL:PerformLayout(w, h)
--
--end
--
--function PANEL:Paint(w, h)
--
--end

vgui.Register("UrbanWeapon.Frame", PANEL, "DFrame")
