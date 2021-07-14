AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self.respawnTime = 30
	self.weapon = weapons.Get("weapon_medkit")
	self:SetModel( self.weapon.WorldModel )
	self.Entity:SetUseType( SIMPLE_USE )
	self:SetSolid( SOLID_VPHYSICS )
end

function ENT:Use(a, c)

end

function ENT:SetConfig(weapon, pos, respawnTime)
	self.respawnTime = respawnTime
	self:SetPos(Vector(pos))
	self.weapon = weapons.Get(weapon)
	self:SetModel( self.weapon.WorldModel )
end

function ENT:StartTouch(ply)
	if ply:IsPlayer() then
		if ply:Give(self.weapon.ClassName) == NULL then
			if self.weapon.Primary.ClipSize > 0 then
				ply:GiveAmmo(self.weapon.Primary.ClipSize, self.weapon.Primary.Ammo)
			else
				ply:GiveAmmo(self.weapon.Primary.DefaultClip, self.weapon.Primary.Ammo)
			end
		end
		self:SetNoDraw(true)
		self:SetSolid( SOLID_NONE )
		timer.Simple(self.respawnTime, function()
			self:SetSolid( SOLID_VPHYSICS )
			self:SetNoDraw(false)
		end)
	end
end
