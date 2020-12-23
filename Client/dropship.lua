local Module = {}

function Module.load_my_dropship()

	player = {}
	player.x = 1050
	player.y = 550
	player.speed = 2.5
	
	
	cafet = love.graphics.newImage("assets/cafet.png")
	dropship = love.graphics.newImage("assets/dropship.png")
	bdropship = love.graphics.newImage("assets/backdropship.png")
	dropshipW = dropship:getWidth()
	dropshipH = dropship:getHeight()
	bdropshipW = bdropship:getWidth()
	bdropshipH = bdropship:getHeight()
	player.sprite = love.graphics.newImage("assets/player.png")
	caisse = love.graphics.newImage("assets/caisse.png")
	pc = love.graphics.newImage("assets/pc.png")
end

function Module.draw_my_dropship()
	love.graphics.translate(camera.x, camera.y)
	love.graphics.draw(dropship, (screenW/2) - ((dropshipW*2)/2), 0, 0, 2, 2)
	love.graphics.draw(bdropship, 293, 617*2, 0, 2, 2)
	love.graphics.draw(player.sprite, player.x, player.y, 0, 1.2, 1.2)
	love.graphics.draw(caisse, 1390, 850, 0, -1.5, 1.5)
	love.graphics.draw(caisse, 570, 890, 0, 1.2, 1.2)
	love.graphics.draw(caisse, 725, 700, 0, 0.8, 0.8)
	love.graphics.draw(pc, 725, 660, 0, 1.2, 1.2)
end

return Module