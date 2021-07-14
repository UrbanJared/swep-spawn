local PANEL = {}

function PANEL:Init()
	self.entity = nil
	local weaponBtn = self:Add("DButton")
	weaponBtn:SetText("Change Weapon")
	weaponBtn:Dock(TOP)
	weaponBtn.DoClick = function()
		local wepframe = vgui.Create( "UrbanWeapon.WeaponFrame" )
		wepframe:SetSize( 500, 500)
		wepframe:SetTitle("Select a Weapon")
		wepframe:Center()
		wepframe:MakePopup()
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
	self.respawnEntry = self:Add("DTextEntry")
	self.respawnEntry:Dock(TOP)

	local saveBtn = self:Add("DButton")
	saveBtn:SetText("Save")
	saveBtn:SetTall(40)
	saveBtn:Dock(BOTTOM)
	saveBtn.DoClick = function()

	end
	local deleteBtn = self:Add("DButton")
	deleteBtn:SetText("Delete")
	deleteBtn:SetTall(40)
	deleteBtn:DockMargin(0,0,0,5)
	deleteBtn:Dock(BOTTOM)
	deleteBtn.DoClick = function()

	end
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
