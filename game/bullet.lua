Bullet = Object:extend()

function Bullet:new(x,y,dir)
	self.x=x
	self.y=y
	self.dir=dir
	self.out = false
	
	self.x = self.x + math.cos(self.dir)*13
	self.y = self.y + math.sin(self.dir)*13
end

function Bullet:update()
	self.x = self.x + math.cos(self.dir)*4
	self.y = self.y + math.sin(self.dir)*4
	
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
	if bulletimg ~= nil then
		love.graphics.draw(bulletimg,self.x+3,self.y+3,self.dir,1,0.2)
	end
end