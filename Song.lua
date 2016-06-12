Song = {}


--[[
so each song needs a file that saves...
- the beatmap (a seperate class)
- the location of the actual song file
- offset (if song is mp3)
- bpm
]]

function Song:new(o)
 	local o = o or {}
	setmetatable(o, self)
	self.__index  = self 
	return o 
end 

function Song:init(filePath, file, bpm)

end 