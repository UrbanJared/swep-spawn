local PANEL = {}

function PANEL:Init()
	self.base = nil
	local weplist = self:Add("DListView")
	weplist:Dock(FILL)
	weplist:SetMultiSelect( false )
	weplist:AddColumn( "Weapon Class" )
	weplist:AddColumn( "Weapon Name" )
	weplist:AddColumn( "Category" )

	local weps = weapons.GetList()
	for k,v in pairs(weps) do
		if (v.PrintName) then
			weplist:AddLine(v.ClassName, v.PrintName, v.Category or "Other")
		end
	end

	weplist.OnRowSelected = function( lst, index, pnl )
		self.base:SelectWep(pnl:GetColumnText( 1 ))
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

vgui.Register("UrbanWeapon.WeaponFrame", PANEL, "DFrame")
