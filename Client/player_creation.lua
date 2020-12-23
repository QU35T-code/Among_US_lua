local Module = {}
local liste_sprites = {}
player = {}


function CreeSprite(pNomImage, pNbImages, pX, pY)
  
  sprite = {}
  sprite.x = pX
  sprite.y = pY
  sprite.frame = 1
  sprite.vx = 0
  sprite.vy = 0
  sprite.flip = 1
  sprite.images = {}
  local imgNum
  for imgNum = 1,pNbImages do
    sprite.images[imgNum] = love.graphics.newImage("assets/Players/Walk/"..pNomImage..imgNum..".png")
  end   
  sprite.l = sprite.images[1]:getWidth()
  sprite.h = sprite.images[1]:getHeight()
  
  table.insert(liste_sprites, sprite)
  
  sprite.Anime = function()
    sprite.frame = player.frame + 0.14
    if sprite.frame >= #sprite.images then
      sprite.frame = 1
    end
  end
  
  sprite.Deplace = function()
    -- Réduction de la vélocité (=friction)
    sprite.vx = sprite.vx * .7
    sprite.vy = sprite.vy * .7
    if math.abs(sprite.vx) < 0.01 then sprite.vx = 0 end
    if math.abs(sprite.vy) < 0.01 then sprite.vy = 0 end
    
    -- Application de la vélocité
    sprite.x = sprite.x + sprite.vx
    sprite.y = sprite.y + sprite.vy
  end
  
  return sprite
  
end

function Module.load_my_player()

	player = CreeSprite("player", 13, 1050, 550)
	--[[player.x = 1050
	player.y = 550
	player.speed = 2.5
	player.frame = 1--]]
	camera = {}
	camera.x = player.x
	camera.y = player.y

	--[[for i = 1, 12 do
		player.sprite[i] = love.graphics.newImage("assets/Players/Walk/player" .. i .. ".png")
	end--]]

	--[[table.insert(listPlayer, player)

	player.Anime = function()
		player.frame = player.frame + 0.4
		if (player.frame >= #player.sprite) then
			player.frame = 1
		end
	end--]]
end

function Module.update_my_player(dt)

	-- Camera
	camera.tx = -(player.x) + screenW/2
	camera.ty = -(player.y) + screenH/2
	camera.x = camera.x + ((camera.tx - camera.x))
	camera.y = camera.y + ((camera.ty - camera.y))

	local n
	for n=1,#liste_sprites do
		local s = liste_sprites[n]
	    s.Deplace()
	    s.Anime()
	end

	if math.abs(player.vx) < 1 and math.abs(player.vy) < 1 then
    	player.frame = 1
  	end

	-- Movement
	if (love.keyboard.isDown("s")) then
		player.vy = player.vy + 1
	end
	if (love.keyboard.isDown("z")) then
		player.vy = player.vy - 1
	end
	if (love.keyboard.isDown("q")) then
		player.vx = player.vx - 1
		player.flip = -1
	end
	if (love.keyboard.isDown("d")) then
		player.vx = player.vx + 1
		player.flip = 1
	end

end

function Module.draw_my_player()
	local n
  	for n=1,#liste_sprites do
    	local s = liste_sprites[n]
    	local frame = s.images[math.floor(s.frame)]
    	love.graphics.draw(frame, s.x, s.y, 0, s.flip * 1.2, 1.2, s.l/2, s.h-6)
    end
end

return Module