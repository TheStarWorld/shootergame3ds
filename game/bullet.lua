Bullet = Object:extend()

function Bullet:new(x,y,dir,p,hit)
	self.x=x
	self.y=y
	self.dir=dir
	self.dir_visual=dir
	self.out = false
	
	self.offset = p.offset
	self.speed = p.speed
	self.ai = p.ai
	self.rotate = p.rotate
	self.texture = p.texture
	self.hostile = p.hostile
	self.w = p.width
	self.h = p.height
	
	self.hitbox = {}
	
	self.hitbox.x = hit.x
	self.hitbox.y = hit.y
	self.hitbox.width = hit.width
	self.hitbox.height = hit.height
	self.hitbox.off_x = hit.off_x
	self.hitbox.off_y = hit.off_y
	
	if self.rotate == false then
		self.dir_visual = 0
	end
	
	self.x = self.x + math.cos(self.dir)*self.offset
	self.y = self.y + math.sin(self.dir)*self.offset
end

function Bullet:update()
	self.x = self.x + math.cos(self.dir)*self.speed
	self.y = self.y + math.sin(self.dir)*self.speed
	self.hitbox.x = self.x+self.hitbox.off_x
	self.hitbox.y = self.y+self.hitbox.off_y
	
	if self.x < 0 then
		self.out = true
	elseif self.x > 400 then
		self.out = true
	end
	
	if self.y < 0 then
		self.out = true
	elseif self.y > 240 then
		self.out = true
	end
end

function Bullet:draw()
	if self.texture ~= nil then
		love.graphics.draw(self.texture,self.x+3,self.y+3,self.dir_visual,self.w,self.h)
	end
	if debugm == true then
		love.graphics.rectangle("line", self.hitbox.x-(self.hitbox.width/3), self.hitbox.y-(self.hitbox.height/3), self.hitbox.width, self.hitbox.height)
	end
end