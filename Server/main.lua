local socket = require('socket')
udp = socket.udp()
udp:setsockname('*', 12345)
local code_secret = "AZERT"
udp:settimeout(0)
myClient = {}
listPlayers = {}
p = {}

--[[local fileWaiting = require("waiting")--]]
local gameState = {} 

gameState.waiting_Start = true
gameState.prepare = true

local canCreateGame = true

local clock = os.clock
function sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end

function newClient(pIP, pPort)
  myClient.IP = pIP
  myClient.Port = pPort
  myClient.Delay = 0
  table.insert(listPlayers, myClient)
  print(#listPlayers)
end

while gameState.prepare do
	data, ip, port = udp:receivefrom()
	if data then
		local posSep = string.find(data, "-")
    -- print(posSep)
		local Keyword = string.sub(data, 1, posSep - 1)
		local Value = string.sub(data, posSep + 1)
		-- print("Keyword  : " .. Keyword)
		-- print("Value  : " .. Value)
    if (Keyword == "Alive") then
      myClient.Delay = 0
      -- if (ip == myClient[0].IP and port == myClient[0].Port) then
       --  myClient[0].Delay = 0
      -- end
    -- else
      -- myClient.Delay = myClient.Delay + 0.5
      -- if (myClient.Delay > 4) then
        -- table.remove(listPlayers, myClient)
        -- udp:sendto("DISCONNECT", ip, port)
      -- end
    end
    -- print(myClient.Delay)
    
    -- NewGame
    if (Keyword == "NewGame") then
      if (canCreateGame) then
        canCreateGame = false
        udp:sendto("NewGameOk", ip, port)
      end
    end
    
    -- Code 
    if (Keyword == "code") then
      if (Value == code_secret) then
        udp:sendto("CODE OK", ip, port)
      else
				udp:sendto("CODE ERROR", ip, port)
			end
    end
    
    if (Keyword == "Connected") then
      newClient(ip, port)
    end
    
    for myClientId, myClient in ipairs(listPlayers) do
      myClient.Delay = myClient.Delay + 0.5
      if (myClient.Delay > 4) then
        table.remove(listPlayers, myClientId)
        udp:sendto("DISCONNECT", myClient.IP, myClient.Port)
      end
    end
    print(#listPlayers)
  end
  
  
  socket.sleep(0.01)
end

--[[function love.update(dt)
	if gameState.waiting_Start then
		fileWaiting.update_my_waiting(dt)
	end
	
end--]]

function split(s, delimiter)
	result = {}
	for match in (s..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match)
	end
	return result
end