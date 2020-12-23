local Module = {}

function Module.toupper(pString)
	if (pString == 'a') then return "A"
	elseif (pString == 'b') then return "B"
	elseif (pString == 'c') then return "C"
	elseif (pString == 'd') then return "D"
	elseif (pString == 'e') then return "E"
	elseif (pString == 'f') then return "F"
	elseif (pString == 'g') then return "G"
	elseif (pString == 'h') then return "H"
	elseif (pString == 'i') then return "I"
	elseif (pString == 'j') then return "J"
	elseif (pString == 'k') then return "K"
	elseif (pString == 'l') then return "L"
	elseif (pString == 'm') then return "M"
	elseif (pString == 'n') then return "N"
	elseif (pString == 'o') then return "O"
	elseif (pString == 'p') then return "P"
	elseif (pString == 'q') then return "Q"
	elseif (pString == 'r') then return "R"
	elseif (pString == 's') then return "S"
	elseif (pString == 't') then return "T"
	elseif (pString == 'u') then return "U"
	elseif (pString == 'v') then return "V"
	elseif (pString == 'w') then return "W"
	elseif (pString == 'x') then return "X"
	elseif (pString == 'y') then return "Y"
	elseif (pString == 'z') then return "Z"
	else return pString
	end
end

function Module.collision(obj1, obj2)
	if (obj1.x >= obj2.x and obj1.x <= obj2.x + obj2.width and obj1.y >= obj2.y and obj1.y <= obj2.y + obj2.height) then
		return true
	else
		return false
	end
end

return Module