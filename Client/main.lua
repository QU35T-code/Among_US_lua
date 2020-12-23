local socket = require "socket"
local address, port = "localhost", 12345
udp = socket.udp()
udp:setpeername(address, port)
udp:settimeout(0)

local fileMenu = require('menu')
local fileDropship = require('dropship')
gameState = {}


function love.load()
    love.window.setFullscreen(true)
	gameState.menu = true
	gameState.dropship = false

	fileMenu.load_my_menu()
	fileDropship.load_my_dropship()
	camera = {}
	camera.x = player.x
	camera.y = player.y
	screenW = love.graphics.getWidth()
	screenH = love.graphics.getHeight()
   

	-- Send seed 
	seed = love.math.random(1, 10)
	print("Seed : " .. seed)
	udp:send("seed"..'-'..tostring(seed))
end



function love.draw()
	if (gameState.menu) then
		fileMenu.draw_my_menu()
	end
	if (gameState.dropship) then
		fileDropship.draw_my_dropship()
	end
end

function love.update(dt)
	if (gameState.menu) then
		fileMenu.update_my_menu(dt)
	end
	-- PLAYER
	if (love.keyboard.isDown("s")) then
		player.y = player.y + player.speed
	end
	if (love.keyboard.isDown("z")) then
		player.y = player.y - player.speed
	end
	if (love.keyboard.isDown("q")) then
		player.x = player.x - player.speed
	end
	if (love.keyboard.isDown("d")) then
		player.x = player.x + player.speed
	end

	camera.tx = -(player.x) + screenW/2
	camera.ty = -(player.y) + screenH/2
	camera.x = camera.x + ((camera.tx - camera.x))
	camera.y = camera.y + ((camera.ty - camera.y))

end

--[[function split(s, delimiter)
	result = {}
	for match in (s..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match)
	end
	return result
end--]]

function love.mousepressed(x, y, button)
	if (button == 1) then
		--[[print(x)
		print(y)--]]
	end
end

function love.keypressed(key)
	if (gameState.menu) then
		fileMenu.keypressed_my_menu(key)
	end
end