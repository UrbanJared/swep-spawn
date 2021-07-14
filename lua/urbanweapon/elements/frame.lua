local PANEL = {}

function PANEL:Init()
	local scrollpanel = vgui.Create("DScrollPanel")
	local weaponBtn = vgui.Create("DButton", self)
	weaponBtn:SetText("Change Weapon")
	weaponBtn:Dock(TOP)
	local posLabel = vgui.Create("DLabel", self)
	posLabel:SetText("Position")
	posLabel:Dock(TOP)
	self.posEntry = vgui.Create("DTextEntry", self)
	self.posEntry:Dock(TOP)
	self.posEntry:SetEditable(false)
	local respawnLabel = vgui.Create("DLabel", self)
	respawnLabel:SetText("Respawn Time (seconds)")
	respawnLabel:Dock(TOP)
	self.respawnEntry = vgui.Create("DTextEntry", self)
	self.respawnEntry:Dock(TOP)

	local saveBtn = vgui.Create("DButton", self)
	saveBtn:SetText("Save")
	saveBtn:SetTall(40)
	saveBtn:Dock(BOTTOM)
	local deleteBtn = vgui.Create("DButton", self)
	deleteBtn:SetText("Delete")
	deleteBtn:SetTall(40)
	deleteBtn:DockMargin(0,0,0,5)
	deleteBtn:Dock(BOTTOM)
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
