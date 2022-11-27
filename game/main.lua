text = "test"

gamepadbuttons = {}

cursorx = 250
cursory = 70

--cirlce pad directions
leftx = 0
lefty = 0
rightx = 0
righty = 0

maxspeed = 1.7

controltype = 1
pointer_r = -1 

touch = false

isds = false

loaded = nil

function love.load()
	loaded = love.joystick.getJoysticks()[1]
	playerimg = love.graphics.newImage("circle.png")
	pointerimg = love.graphics.newImage("pointer.png")
	cursorimg = love.graphics.newImage("cursor.png")
	bulletimg = love.graphics.newImage("bullet.png")
	bullet2img = love.graphics.newImage("projectile1.png")
	Object = require "classic"
	require "bullet"
	require "player"
	player = Player(200,120)
	bullets = {}
end

function angle(x1,x2,y1,y2)
	return math.atan2(y2-y1, x2-x1)
end

function love.gamepadaxis(joy, axis, value)
	if round(value,10,0,0) > 0 and axis:find("left") then
		controltype = 1
	end
end

function lerp(start, realend, amt)
  return (1-amt)*start+amt*realend
end

function buttondown(button)
	down = gamepadbuttons[button]
	if down == nil then
		return(false)
	end
	return(down)
end

function love.touchmoved(id, x, y, dx, dy, pressure)
	cursorx = x
	cursory = y
end

function love.touchpressed()
	touch = true
end

function love.touchreleased()
	touch = false
end

w_width = love.graphics.getWidth()
w_height = love.graphics.getHeight()

function love.draw(screen)
	if screen ~= "bottom" then
		w_width = love.graphics.getWidth()
		player:draw()
		
		love.graphics.setLineWidth(10)
		love.graphics.rectangle("line", 0, 0, 400, 240)
		
		for i,v in ipairs(bullets) do
			v:draw()
		end
		
	elseif screen == "bottom" then
		love.graphics.print(tostring(leftx), 50, 100)
		love.graphics.print(tostring(lefty), 50, 120)
		love.graphics.print(tostring(controltype), 50, 140)
		love.graphics.print(tostring(text), 50, 160)
		love.graphics.print(tostring(pointer_r), 50, 180)
		love.graphics.print(tostring(speed), 50, 200)
	end
	love.graphics.draw(cursorimg,cursorx-4,cursory-4)
end 

function round(num,times,add,subt)
	num1 = math.floor((num * times)+add)/times-subt
	if math.abs(num1) > 0.1 then
			return(num1)
		else
			return(0)
	end
	return(math.floor(num1+add)/times-subt)
end

function love.update()
	player:update()

	if loaded ~= nil then
		if controltype == 1 then
			leftx = round(loaded:getGamepadAxis("leftx"),10,0,0)*maxspeed
			lefty = round(loaded:getGamepadAxis("lefty"),10,0,0)*maxspeed
			rightx = round(loaded:getGamepadAxis("rightx"),10,0,0)*4
			righty = round(loaded:getGamepadAxis("righty"),10,0,0)*4
		end
	end
	
	if controltype == 2 then
		if buttondown("dpright") then
			leftx = maxspeed
		end
		if buttondown("dpleft") then
			leftx = -maxspeed
		end
		if buttondown("dpup") then
			lefty = -maxspeed
		end
		if buttondown("dpdown") then
			lefty = maxspeed
		end
	end
	
	for i,v in ipairs(bullets) do
		v:update()
		if v.out then
			table.remove(bullets,i)
		end
	end
	
	cursorx = cursorx + rightx
	cursory = cursory + righty
end

function love.gamepadpressed(joystick,button)
	gamepadbuttons[button] = true
	text = button
	if button == "dpright" then
		controltype = 2
	end
	if button == "dpleft" then
		controltype = 2
	end
	if button == "dpup" then
		controltype = 2
	end
	if button == "dpdown" then
		controltype = 2
	end
end

function love.gamepadreleased(joystick,button)
	gamepadbuttons[button] = false
	if button == "dpright" then
		leftx = 0
	end
	if button == "dpleft" then
		leftx = 0
	end
	if button == "dpup" then
		lefty = 0
	end
	if button == "dpdown" then
		lefty = 0
	end
end