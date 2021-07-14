local PANEL = {}

function PANEL:Init()
	local weplist = self:Add("DListView")
	weplist:Dock(FILL)
	weplist:SetMultiSelect( false )
	weplist:AddColumn( "Weapon Class" )
	weplist:AddColumn( "Weapon Name" )
	weplist:AddColumn( "Category" )

	local weps = weapons.GetList()
	for k,v in pairs(weps) do
		weplist:AddLine(v.ClassName, v.PrintName, v.Category)
	end

	weplist.OnRowSelected = function( lst, index, pnl )
		print( "Selected " .. pnl:GetColumnText( 1 ) .. " ( " .. pnl:GetColumnText( 2 ) .. " ) at index " .. index )
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
