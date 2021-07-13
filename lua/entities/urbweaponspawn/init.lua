AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self.timeAlive = 0
	self.active = true
	self.respawnTime = nil
	self.weapon = "weapon_medkit"
	self:SetModel( weapons.Get(self.weapon).WorldModel )
	self.Entity:SetUseType( SIMPLE_USE )
 
	--self:PhysicsInit( SOLID_VPHYSICS )
	--self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	--self:SetSolidFlags(FSOLID_NOT_SOLID)
	--self:AddSolidFlags(FSOLID_NOT_STANDABLE)
	--self:AddSolidFlags(FSOLID_TRIGGER)
    --local phys = self:GetPhysicsObject()
	--if (phys:IsValid()) then
	--	phys:Wake()
	--end
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
	if ply:IsPlayer() and self.active then
		if ply:Give(self.weapon) == NULL then
			if weapons.Get(self.weapon).Primary.ClipSize > 0 then
				ply:GiveAmmo(weapons.Get(self.weapon).Primary.ClipSize, weapons.Get(self.weapon).Primary.Ammo)
			else
				ply:GiveAmmo(weapons.Get(self.weapon).Primary.DefaultClip, weapons.Get(self.weapon).Primary.Ammo)
			end
		end
		self.active = false
		self:SetNoDraw(true)
		self:SetSolid( SOLID_NONE )
		timer.Simple(self.respawnTime or 30, function()
			self:SetSolid( SOLID_VPHYSICS )
			self:SetNoDraw(false)
			self.active = true
		end)
	end
end

function ENT:Think( ... )
    self:SetAngles(Angle(0, self.timeAlive, 0))
    self:SetPos(self:GetPos() + Vector(0,0,TimedSin(0.1,0,1,0)))
    self.timeAlive = self.timeAlive + 3
    if self.timeAlive > 360 then
    	self.timeAlive = 0
    end
end