local Module = {}
local fileUtils = require('utils')

function Module.load_my_menu()
	text = ""
	MenuCodeInput = love.graphics.newImage("assets/Menu/code.png")
	MenuFont = love.graphics.newFont("assets/fonts/droit.ttf", 75)
end

function Module.draw_my_menu()
	love.graphics.draw(MenuCodeInput, (screenW / 2) - (190 / 2), screenH - 200, 0, 1.5, 1.5)
	love.graphics.setFont(MenuFont)
	love.graphics.printf(text, (screenW / 2) - (190 / 2) + 60, screenH - 200, love.graphics.getWidth())
end

function Module.update_my_menu(dt)
	data, msg = udp:receive()
	if data then
		if (data == "CODE OK") then
			gameState.menu = false
			gameState.dropship = true
		elseif (data == "CODE ERROR") then
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
	end
  	if key == "delete" or key == "backspace" then
   		text = text:sub( 1, #text - 1 )
  	end
end

return Module