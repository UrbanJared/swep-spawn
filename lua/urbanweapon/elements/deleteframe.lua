local PANEL = {}

function PANEL:Init()
	self.base = nil
	self.entity = nil
	local deleteText = self:Add("DLabel")
	deleteText:SetText("Are you sure you want to delete this spawn point?")
	deleteText:Dock(TOP)
	local acceptBtn = self:Add("DButton")
	acceptBtn:SetText("Delete")
	acceptBtn:SetTall(40)
	acceptBtn:Dock(BOTTOM)
	acceptBtn.DoClick = function()
		net.Start("UrbanWeaponSpawnsDelete")
			net.WriteEntity(self.entity)
		net.SendToServer()
		self:Remove()
		self.base:Remove()
	end
	local cancelBtn = self:Add("DButton")
	cancelBtn:SetText("Cancel")
	cancelBtn:SetTall(40)
	cancelBtn:DockMargin(0,0,0,5)
	cancelBtn:Dock(BOTTOM)
	cancelBtn.DoClick = function()
		self:Remove()
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

vgui.Register("UrbanWeapon.DeleteFrame", PANEL, "DFrame")
