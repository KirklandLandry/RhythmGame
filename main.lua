 require "input"
require "audioManager"
--song = nil


-- IMPORTANT --
-- go through the callbacks and implement them
-- input should be replaced with callbacks AND the exact time the button was pressed
-- implement the hasfocus and quit callbacks
-- redo sfx management
-- make a time management class
-- make a pattern class
-- make a static variable class for the music stuff
-- make a song class (store bpm, note values, etc...)

function love.load()
	initAudioManager("assets/testSong.wav")
end


local radius = 0

local hitBeatOne = false 
local hitBeatTwo = false
local hitBeatThree = false 
local hitBeatFour = false 

local globalRunning = false

function love.update(dt)
	if globalRunning then 

		local songTime = updateAudioManager()

		local currentBar = getCurrentBar()
		local currentBarInMs = getCurrentBar() * getBarLength() 

		local offs = 10

		if #beatmap >= currentBar + 1 then 
			local noteToHit = 0
			for i=1,#beatmap[currentBar + 1] do
				noteToHit = beatmap[currentBar + 1][i].position
				if songTime >= (currentBarInMs + noteToHit - offs) and songTime <= (currentBarInMs + noteToHit + offs) then 
					print("hit")
					playSfx()
					radius = 100
				end 
				print(songTime, currentBarInMs + noteToHit - offs, currentBarInMs + noteToHit, currentBarInMs + noteToHit + offs )
			end
			
		end 
		
		radius = radius - 10
		if radius < 0 then radius = 0 end 

		--[[if(getPreviousBar() ~= getCurrentBar()) then 
			hitBeatOne = false
			hitBeatTwo = false
			hitBeatThree = false
			hitBeatFour = false
		end 

		--print(bar)
		--beat = (songTime / sixteenth_note) - (math.floor(bar) * 16)
		local beat = getSixteenthBeatInCurrentBar()

		if ((beat >= 0 and beat <= 0.2) or (beat >= 15.8 and beat <= 16)) and not hitBeatOne then playSfx() hitBeatOne = true radius = 50 end 
		if beat >= 3.8 and beat <= 4.2 and not hitBeatTwo then playSfx() hitBeatTwo = true radius = 50 end 
		if beat >= 7.8 and beat <= 8.2 and not hitBeatThree then playSfx() hitBeatThree = true radius = 50 end 
		if beat >= 11.8 and beat <= 12.2 and not hitBeatFour then playSfx() hitBeatFour = true radius = 50 end 
		--if beat >= 11.9 and beat <= 12.1 and not hitBeatFour then playSfx() hitBeatFour = true radius = 50 end 


		radius = radius - 3
		if radius < 0 then radius = 0 end ]]
	end 

	
	-- time in song, beats per second, four 16th notes per beat
	--[[previousSixteenthNode = sixteenthNote
	sixteenthNote = songTime * bpm * (1/60) * 4
	print(sixteenthNote - previousSixteenthNode)
	allowance = sixteenthNote - previousSixteenthNode
	onbeat = false
	if  sixteenthNote >= beats[1] - allowance or sixteenthNote <= beats[1] + allowance or 
		sixteenthNote >= beats[2] - allowance or sixteenthNote <= beats[2] + allowance or 
		sixteenthNote >= beats[3] - allowance or sixteenthNote <= beats[3] + allowance or 
		sixteenthNote >= beats[4] - allowance or sixteenthNote <= beats[4] + allowance then 
		onbeat = true
	end 
	if onbeat then 
		src1:play()
	end ]]

end




function love.draw()
	audioManagerDebugPrint()

	love.graphics.circle("fill", love.graphics.getWidth()/2, love.graphics.getHeight()/2, radius, 32)
	--print(love.graphics.getWidth()/2, love.graphics.getHeight()/2, radius)

end


function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end

	if key == "d" then 
		globalRunning = true
	end 

end

function getSign(x)
	if x < 0 then
 		return -1
	elseif x > 0 then
		return 1
	else
		return 0
	end
end





