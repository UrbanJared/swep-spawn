AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self.timeAlive = 0
	self.active = true
	self.respawnTime = 30
 	self:SetNWEntity("myWeapon", "weapon_extinguisher")
	self:SetModel( weapons.Get(self:GetNWEntity("myWeapon")).WorldModel )
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

function ENT:StartTouch(ply)
	local myGun = self:GetNWEntity("myWeapon")
	if ply:IsPlayer() and self.active then
		if ply:Give(myGun) == NULL then
			if weapons.Get(myGun).Primary.ClipSize > 0 then
				ply:GiveAmmo(weapons.Get(myGun).Primary.ClipSize, weapons.Get(myGun).Primary.Ammo)
			else
				ply:GiveAmmo(weapons.Get(myGun).Primary.DefaultClip, weapons.Get(myGun).Primary.Ammo)
			end
		end
		self.active = false
		self:SetNoDraw(true)
		self:SetSolid( SOLID_NONE )
		timer.Simple(self.respawnTime, function()
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