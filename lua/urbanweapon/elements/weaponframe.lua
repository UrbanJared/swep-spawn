local PANEL = {}

function PANEL:Init()
	self.base = nil
	local weplist = self:Add("DListView")
	weplist:Dock(FILL)
	weplist:SetMultiSelect( false )
	weplist:AddColumn( "Weapon Class" )
	weplist:AddColumn( "Weapon Name" )
	weplist:AddColumn( "Category" )

	for k,v in pairs(weapons.GetList()) do
		weplist:AddLine(v.ClassName, v.PrintName, v.Category or "Other")
	end

	weplist.OnRowSelected = function( lst, index, pnl )
		self.base.weaponEntry:SetText(weapons.Get(pnl:GetColumnText( 1 )).ClassName)
		self:Remove()
	end
end

vgui.Register("UrbanWeapon.WeaponFrame", PANEL, "DFrame")
