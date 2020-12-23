local socket = require "socket"
local address, port = "localhost", 12345
udp = socket.udp()
udp:setpeername(address, port)
udp:settimeout(0)

local fileMenu = require('menu')
local fileDropship = require('dropship')
local filePlayer = require('player_creation')

gameState = {}
gameState.menu = false
gameState.dropship = true

function love.load()
    --[[love.window.setFullscreen(true)--]]
	
    if (gameState.dropship) then
		fileDropship.load_my_dropship()
		filePlayer.load_my_player()
	end
	
	
	screenW = love.graphics.getWidth()
	screenH = love.graphics.getHeight()
	fileMenu.load_my_menu()
   

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
		love.graphics.translate(camera.x, camera.y)
		love.graphics.draw(dropship, (screenW/2) - ((dropshipW*2)/2), 0, 0, 2, 2)
		love.graphics.draw(bdropship, 293, 617*2, 0, 2, 2)
		filePlayer.draw_my_player()
		fileDropship.draw_my_dropship()
	end
end

function sleep(sec)
    socket.select(nil, nil, sec)
end


function areAlive(dt)
	udp:send("Alive"..'-'..tostring(seed))
end

function love.update(dt)
	if (gameState.menu) then
		fileMenu.update_my_menu(dt)
	end
	if (gameState.dropship) then
		fileDropship.update_my_dropship(dt)
		areAlive(dt)
		filePlayer.update_my_player(dt)
	end
end

function love.mousepressed(x, y, button)
	if (gameState.menu) then
		fileMenu.mousepressed_my_menu(x, y, button)
	end
end

function love.keypressed(key)
	if (gameState.menu) then
		fileMenu.keypressed_my_menu(key)
	end
end