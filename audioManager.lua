

local src1 = love.audio.newSource("assets/blip.wav", "static")


local currentSong = nil 

local bpm = 0
local bps = 0
local bpms = 0

local half_note               = 0
local quarter_note            = 0
local eighth_note             = 0
local sixteenth_note          = 0
local dotted_quarter_note     = 0  
local dotted_eighth_note      = 0 
local dotted_sixteenth_note   = 0
local triplet_quarter_note    = 0
local triplet_eighth_note     = 0
local triplet_sixteenth_note  = 0

local songTime = 0

local bar = 0
local previousBar = 0

local lastReportedSongPosition = 0
local previousFrameTime = 0

local sixteenthBeat = 0
local sixteenthTripletBeat = 0


function initAudioManager(songPath)
	currentSong = love.audio.newSource(songPath)--"assets/testSong.wav")
	currentSong:setVolume(0.7)

	-- DEFINING CONSTANT VALUES -- 
	-- beats per minute
	bpm = 130
	-- beats per second
	bps = bpm / 60
	-- beats per millisecond
	bpms = bps / 1000
	-- note values in ms
	half_note               =  (120 / bpm) * 1000 -- 1 half note = 2 quarter notes
	quarter_note            =   (60 / bpm) * 1000 -- 1 quarter note = 1/4 of a bar
	eighth_note             =   (30 / bpm) * 1000 -- 2 eighth notes = 1 quarter note
	sixteenth_note          =   (15 / bpm) * 1000 -- 4 16th notes = 1 quarter note 
	dotted_quarter_note     =   (90 / bpm) * 1000 -- 1 dotted quarter note = 1 quarter note + 1 16th note
	dotted_eighth_note      =   (45 / bpm) * 1000 -- 1 dotted eight note = 
	dotted_sixteenth_note   = (22.5 / bpm) * 1000 --
	triplet_quarter_note    =   (40 / bpm) * 1000 -- 3 triplet quarter notes = 1 half note
	triplet_eighth_note     =   (20 / bpm) * 1000 -- 3 triplet eighth notes = 1 quarter note
	triplet_sixteenth_note  =   (10 / bpm) * 1000 -- 6 triplet 16th notes = 1 quarter note

	initSources()
	initBeatmap()
end 

-- beatmap is a 2D array
-- the table is filled with bars 
-- each bar is a table filled with notes
beatmap = {}
local barLength = 0

function initBeatmap()
	-- this is the length of a single bar in ms
	barLength = quarter_note * 4

for i=1,10 do
		-- fill a bar with values
	newBar = {}
 	local quarter1 = newNote(true, quarter_note, 0)
 	local quarter2 = newNote(true, quarter_note, 0 + quarter_note)
 	local note3 = newNote(true, triplet_eighth_note, 0 + quarter_note + quarter_note)
 	local note4 = newNote(true, triplet_eighth_note, 0 + quarter_note + quarter_note + triplet_eighth_note)
 	local note5 = newNote(true, triplet_eighth_note, 0 + quarter_note + quarter_note + triplet_eighth_note + triplet_eighth_note)
 	local quarter4 = newNote(true, quarter_note, 0 + quarter_note + quarter_note + triplet_eighth_note + triplet_eighth_note + triplet_eighth_note)

 	--local quarter3 = newNote(true, quarter_note, 0 + quarter_note + quarter_note)
 	--local quarter4 = newNote(true, quarter_note, 0 + quarter_note + quarter_note + quarter_note)

	table.insert(newBar, quarter1)
	table.insert(newBar, quarter2)
	--table.insert(newBar, quarter3)
	table.insert(newBar, note3)
	table.insert(newBar, note4)
	table.insert(newBar, note5)

	table.insert(newBar, quarter4)

	-- the new bar was sucessfully created
	if addBeatmapBar(newBar) then 
		print("success")
	else -- bar wasn't added sucessfully
		print("fail")
	end  
end

end 

function newNote(_play, _duration, _position)
	return {play = _play, duration = _duration, position = _position, y = 0}
end 

function addBeatmapBar(newBar)
	local barCount = 0
	for i=1,#newBar do
		barCount = barCount + newBar[i].duration
	end

	-- a bar must add up to the barLength
	-- ie 4 quarter notes = 1 bar
	-- 2 half notes = 1 bar
	-- 3 quarter notes does not equal 1 bar
	if barCount > barLength or barCount < barLength then 
		return false 
	end 


	-- if the bar adds up to the proper amount then add it to the beatmap
	table.insert(beatmap, newBar)

	return true
end


function updateAudioManager()
	if previousFrameTime == 0 then 
		currentSong:play()
		songTime = 0
	else
		songTime = songTime + (love.timer.getTime()*1000) - previousFrameTime
	end 
	previousFrameTime = love.timer.getTime() * 1000

	-- easing function for if the playhead position doesn't match the actual song position
	if currentSong:tell("seconds") ~= lastReportedSongPosition then 
		songTime = (songTime + (currentSong:tell("seconds") * 1000)) * 0.5
		lastReportedSongPosition = currentSong:tell("seconds") * 1000
	end 


	-- 4 16th notes in a beat, 4 beats in a bar
	previousBar = bar 
	bar = songTime / sixteenth_note * (1 / 16)

	-- where you are in the bar - the current bar (int)
	sixteenthBeat = (songTime / sixteenth_note) - (math.floor(bar) * 16)
	sixteenthTripletBeat = (songTime / triplet_sixteenth_note) - (math.floor(bar) * 24)

	return songTime
end 

function getSongTime()
	return songTime + (love.timer.getTime()*1000) - previousFrameTime
end

function getCurrentBar()
	return math.floor(bar)
end 

function getCurrentTimePositionInBar()
	return ((bar - math.floor(bar)) * barLength) 
end 

function getPreviousBar()
	return math.floor(previousBar)
end 

function getBarLength()
	return barLength
end 

function getSixteenthBeatInCurrentBar()
	return sixteenthBeat
end 

function getSixteenthTripletBeatInCurrentBar()
	return sixteenthTripletBeat
end 

-- very erratic
-- go through this https://github.com/vrld/slam/blob/master/slam.lua
-- and this https://love2d.org/forums/viewtopic.php?t=2220
local sources = {}
function initSources()
	for i=1,10 do
		table.insert(sources, love.audio.newSource("assets/blip.wav", "static"))
		sources[i]:setLooping(false)
	end
end 
-- keep track of current source with a current var
function playSfx()
	local sfxPlayed = false
	for i=1,#sources do
		if sources[i]:isStopped() then 
			sources[i]:play()
			sfxPlayed = true
			break
		end 
	end
	if not sfxPlayed then 
		table.insert(sources, love.audio.newSource("assets/blip.wav", "static"))
		sources[#sources]:setLooping(false)
		sources[#sources]:play()
	end 
end 



function audioManagerDebugPrint()
	love.graphics.print("songTime: "..tostring(songTime), 10, 0)
	love.graphics.print("bar:           "..tostring(bar), 10, 10)
	love.graphics.print("16th beat:           "..tostring(sixteenthBeat), 10, 20)
	love.graphics.print("16th triplet beat: "..tostring(sixteenthTripletBeat), 10, 30)
	--print(sixteenthTripletBeat)


	for i=1,#sources do
		love.graphics.print("sfx"..tostring(i)..": "..tostring(sources[i]:isPlaying()), 10, 40 + (10 * i))
	end
end 
