local socket = require('socket')
udp = socket.udp()
udp:setsockname('*', 12345)
udp:settimeout(0)
listPlayers = {}
p = {}

local fileWaiting = require("waiting")
local gameState = {} 

function love.load()
	gameState.waiting_Start = true
end

function love.update(dt)
	if gameState.waiting_Start then
		fileWaiting.update_my_waiting(dt)
	end
	
end

function split(s, delimiter)
	result = {}
	for match in (s..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match)
	end
	return result
end

function love.keypressed(key)
	if (key == "m") then
		for i = 1, #listPlayers do
			print(listPlayers[i])
		end
	end
end