Enemy = Object:extend()

function Enemy:new(x,y)
	self.finaly = y
	self.x=x
	self.y=0
	self.r = 0
	self.dead = false
	self.despawn = false
	
	self.p = {
		ai = 1,
		speed = 10,
		health = 30
	}
	
	self.hitbox = {
		x = self.x,
		y = self.y,
		width = 18,
		height = 18
	}
	
	self.bullet_p = {
		offset = 10,
		speed = 4,
		ai = 1,
		rotate = false,
		texture = bullet2img,
		hostile = true,
		width=1,
		height=1
	}
	
	self.hitbox_p = {
		x = self.x,
		y = self.y,
		width = 8,
		height = 8,
		off_x = 5.4,
		off_y = 5.4
	}
	
end

function Enemy:update()
	if ready == false and self.dead == false then
		self.y = lerp(self.y,self.finaly,0.1)
			elseif ready == true then
		tick(self,self.p.ai,self.p.speed,self.bullet_p,self.hitbox_p)
	end
	for i,v in ipairs(bullets) do
		if collide(self.hitbox,v.hitbox) and v.hostile == false then
			self.p.health = self.p.health - 1
			table.remove(bullets,i)
			break
		end
	end
	if self.p.health <= 0 then
		self.dead = true
		self.despawn = true
	end
end

function tick(self,ai,speed,pro,hit)
	local rot = angle(self.x,cursorx,self.y,cursory)
	if ai_t % speed == 0 then
		if ai == 1 then
			table.insert(bullets,Bullet(self.x,self.y,rot,pro,hit))
		end
	end
end

function Enemy:draw()
	self.hitbox.x = self.x
	self.hitbox.y = self.y
	
	love.graphics.draw(enemyimg,self.x-(18/3),self.y-(18/3))
	if debugm == true then
		love.graphics.rectangle("line", self.hitbox.x-(self.hitbox.width/3), self.hitbox.y-(self.hitbox.height/3), self.hitbox.width, self.hitbox.height)
	end
end