local Module = {}
local fileUtils = require('utils')

function Module.load_my_menu()
	text = ""
	inputX = (screenW / 2) - (190 / 2)
	MenuCodeInput = love.graphics.newImage("assets/Menu/code.png")
	MenuNewGame = love.graphics.newImage("assets/Menu/newGame.png")
	MenuFont = love.graphics.newFont("assets/fonts/droit.ttf", 75)
end

function Module.draw_my_menu()
	love.graphics.draw(MenuNewGame, inputX, 200, 0, 1.5, 1.5)
	love.graphics.draw(MenuCodeInput, inputX, screenH - 200, 0, 1.5, 1.5)
	love.graphics.setFont(MenuFont)
	love.graphics.printf(text, inputX + 60, screenH - 200, love.graphics.getWidth())
end

function Module.update_my_menu(dt)
	data, msg = udp:receive()
	if data then
		-- Code
		if (data == "CODE OK") then
			gameState.menu = false
			gameState.dropship = true
			love.load()
		elseif (data == "CODE ERROR") then

		-- New Game
		elseif (data == "NewGameOk") then
			gameState.menu = false
			gameState.dropship = true
			love.load()
		else
			print("Error Code : " .. data)
		end
	end
end



function love.textinput(t)
		t = fileUtils.toupper(t)
		local len = string.len(text)
		if (len < 5) then
			text = text .. t
		end
end

function Module.keypressed_my_menu(key)
	if (key == 'return') then
		udp:send("code"..'-'..tostring(text))
		print("send")
	end
  	if key == "delete" or key == "backspace" then
   		text = text:sub( 1, #text - 1 )
  	end
end

function Module.mousepressed_my_menu(x, y, button)
	if (button == 1) then
		if (x >= inputX and x <= inputX + 190 * 1.5 and y >= 200 and y <= 200 + 48 * 1.5) then
			udp:send("NewGame"..'-true')
		end
	end 
end

return Module