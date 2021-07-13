AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self.timeAlive = 0
	self.respawnTime = nil
	self.weapon = "weapon_medkit"
	self:SetModel( weapons.Get(self.weapon).WorldModel )
	self.Entity:SetUseType( SIMPLE_USE )
	self:SetSolid( SOLID_VPHYSICS )
end

function ENT:Use(a, c)

end

function ENT:SetConfig(weapon, pos, respawnTime)
	self.respawnTime = respawnTime
	self:SetPos(Vector(pos))
	self.weapon = weapon
	self:SetModel( weapons.Get(weapon).WorldModel )
end

function ENT:StartTouch(ply)
	if ply:IsPlayer() then
		if ply:Give(self.weapon) == NULL then
			if weapons.Get(self.weapon).Primary.ClipSize > 0 then
				ply:GiveAmmo(weapons.Get(self.weapon).Primary.ClipSize, weapons.Get(self.weapon).Primary.Ammo)
			else
				ply:GiveAmmo(weapons.Get(self.weapon).Primary.DefaultClip, weapons.Get(self.weapon).Primary.Ammo)
			end
		end
		self:SetNoDraw(true)
		self:SetSolid( SOLID_NONE )
		timer.Simple(self.respawnTime or 30, function()
			self:SetSolid( SOLID_VPHYSICS )
			self:SetNoDraw(false)
		end)
	end
end

function ENT:Think( ... )
    self:SetAngles(Angle(0, self.timeAlive, 0))
    self:SetPos(self:GetPos() + Vector(0,0,TimedSin(0.1,0,1,0)))
    self.timeAlive = self.timeAlive + 3
    if self.timeAlive > 360 then
    	self.timeAlive = self.timeAlive - 360
    end
end
