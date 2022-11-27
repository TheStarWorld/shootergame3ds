Bullet = Object:extend()

function Bullet:new(x,y,dir,p)
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
	
	if self.rotate == false then
		self.dir_visual = 0
	end
	
	self.x = self.x + math.cos(self.dir)*self.offset
	self.y = self.y + math.sin(self.dir)*self.offset
end

function Bullet:update()
	self.x = self.x + math.cos(self.dir)*self.speed
	self.y = self.y + math.sin(self.dir)*self.speed
	
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
end