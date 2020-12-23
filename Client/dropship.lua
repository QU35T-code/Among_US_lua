local Module = {}

local fileUtils = require('utils')


function Module.load_my_dropship()

	udp:send("Connected-true")
	
	cafet = love.graphics.newImage("assets/cafet.png")
	dropship = love.graphics.newImage("assets/dropship.png")
	bdropship = love.graphics.newImage("assets/backdropship.png")
	dropshipW = dropship:getWidth()
	dropshipH = dropship:getHeight()
	bdropshipW = bdropship:getWidth()
	bdropshipH = bdropship:getHeight()
	--[[player.sprite = love.graphics.newImage("assets/player.png")--]]
	caisse = love.graphics.newImage("assets/caisse.png")
	pc = love.graphics.newImage("assets/pc.png")
	box1 = {}
	box1.x = 760
	box1.y = 480
	box1.width = 400

	box2 = {}
	box2.x = 1160
	box2.y = 480
	box2.width = 400
end

function Module.update_my_dropship(dt)
	data, msg = udp:receive()
	if data then
		-- Disconnect Dropship
		if (data == "DISCONNECT") then
			gameState.menu = true
			gameState.dropship = false
			love.load()
		end
	end

	--[[local collide = fileUtils.collision(player, box1)
	if (collide) then
		
		player.y = box1.y + box1.height
	else 
	end--]]

	if (player.y <= box1.y and player.x >= box1.x and player.x < box1.x + box1.width) then
		player.y = box1.y
	end

	if (player.y <= box1.y and player.x >= box1.x and player.x < box1.x + box1.width) then
		player.y = box1.y
	end
end

function Module.draw_my_dropship()
	
	love.graphics.draw(caisse, 1390, 850, 0, -1.5, 1.5)
	love.graphics.draw(caisse, 570, 890, 0, 1.2, 1.2)
	love.graphics.draw(caisse, 725, 700, 0, 0.8, 0.8)
	love.graphics.draw(pc, 725, 660, 0, 1.2, 1.2)
	--[[love.graphics.draw(player.sprite, player.x, player.y, 0, 1.2, 1.2)--]]
	love.graphics.line(box1.x, box1.y, box1.x + box1.width, box1.y)
	love.graphics.line(box2.x, box2.y, 1600, box2.y + 170)
	love.graphics.circle('line', 1300, 950, 90)
end

return Module