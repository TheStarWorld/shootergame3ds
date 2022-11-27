Player = Object:extend()

function Player:new(x,y)
	self.x=x
	self.y=y
	
	self.bullet_p = {
		offset = 10,
		speed = 4,
		ai = 1,
		rotate = true,
		texture = bulletimg,
		hostile = false,
		width=1,
		height=0.2
	}
	
	self.playerx_s = 0
	self.playery_s = 0
	self.speed = 1
	self.shoottimer = 0
end

function Player:update()
	self.speed = 1
	if buttondown("leftshoulder") then
		self.speed = 0.65
	end
	
	if buttondown("a") then
		self.x = 200
		self.y = 120
	end

	self.playerx_s = lerp(self.playerx_s,leftx,0.2)
	self.playery_s = lerp(self.playery_s,lefty,0.2)
	
	self.x = self.x + self.playerx_s*self.speed
	self.y = self.y + self.playery_s*self.speed
	
	if self.x < 0 then
		self.x = 0
	elseif self.x > w_width then
		self.x = w_width
	end
	
	if self.y < 0 then
		self.y = 0
	elseif self.y > w_height then
		self.y = w_height
	end

	pointer_r = angle(self.x,cursorx,self.y,cursory)
	
	self.shoottimer = self.shoottimer+1
	
	if self.shoottimer % 7 == 0 and (buttondown("rightshoulder") or touch) then
		table.insert(bullets,Bullet(self.x,self.y,pointer_r,self.bullet_p))
		self.shoottimer = 0
	end
end

function Player:draw()
	love.graphics.draw(playerimg,self.x-3,self.y-3)
	love.graphics.draw(pointerimg,self.x+math.cos(pointer_r)*10, self.y+math.sin(pointer_r)*10)
end