local Module = {}
local code_secret = "AZERT"

function Module.load_my_waiting()
end

function Module.update_my_waiting(dt)
	data, ip, port = udp:receivefrom()
	if data then
		p = split(data, '-')
		for i = 1, #p do
			if (p[i] == "seed") then
				seed = p[i + 1]
				table.insert(listPlayers, seed)
			end
			if (p[i] == "code") then
				code = p[i + 1]
				if (code == code_secret) then
					udp:sendto("CODE OK", ip, port)
				else
					udp:sendto("CODE ERROR", ip, port)
				end
			end
		end
	end
end

return Module