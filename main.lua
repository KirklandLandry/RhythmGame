 require "input"
require "audioManager"


-- IMPORTANT --
-- go through the callbacks and implement them
-- input should be replaced with callbacks AND the exact time the button was pressed
-- implement the hasfocus and quit callbacks
-- redo sfx management
-- make a time management class
-- make a pattern class
-- make a static variable class for the music stuff
-- make a song class (store bpm, note values, etc...)

-- have it show you performance by bar like in ff theatrhythm
-- then let you jump to bar to practice


-- okay, so here's an idea for changing up input.
-- you have 4 tracks of input. when adding a bar, you have to add input for all 4 tracks
-- you specify track, time to press down, time to release 
-- or maybe you specify if it's updown (press), up, or down
-- for each track you keep track of the press and release times
-- 


function love.load()
	initAudioManager("assets/testSong.wav")
	initKeys()
end


local radius = 0

local globalRunning = false

function love.update(dt)

	if keys['d'].down then 
		--print(keys['d'].time)
		--print(songTime)
		globalRunning = true 
	end 

	if globalRunning then 

		local songTime = updateAudioManager()

		local currentBar = getCurrentBar()
		local currentBarInMs = getCurrentBar() * getBarLength() 

		local offs = 40

		-- current bar starts at 0
		if #beatmap >= currentBar + 1 then 
			local noteToHit = 0
			for i=1,#beatmap[currentBar + 1] do
				noteToHit = beatmap[currentBar + 1][i].songPosition
		        --love.event.quit()
				if songTime >= (currentBarInMs + noteToHit - offs) and songTime <= (currentBarInMs + noteToHit + offs) then 
					
					if keys[gameButtons.button3].down and keys[gameButtons.button3].time >= (currentBarInMs + noteToHit - (offs* 2)) and 
						keys[gameButtons.button3].time  <= (currentBarInMs + noteToHit + (offs* 2)) and 
						beatmap[currentBar + 1][i].hit == false then 

						print("hit")
						beatmap[currentBar + 1][i].hit = true 
						playSfx()
						radius = 100
					end 
				end 

				-- the note expired, set to missed
				if currentBarInMs + noteToHit + offs < songTime and beatmap[currentBar + 1][i].hit == false and not beatmap[currentBar + 1][i].missed then 
					beatmap[currentBar + 1][i].missed = true
					print("miss")
				end 


				--print(songTime, currentBarInMs + noteToHit - offs, currentBarInMs + noteToHit, currentBarInMs + noteToHit + offs )
			end
		end 
		
		radius = radius - 10
		if radius < 0 then radius = 0 end 

	end 
end


function love.draw()
	audioManagerDebugPrint()

	-- a value between 0 and 1 multiplied by the screen width
	local xVal = (getCurrentTimePositionInBar() / getBarLength()) * love.graphics.getWidth()
	--print(xVal)
	love.graphics.line(xVal, 0, xVal, love.graphics.getHeight())


	local currentBar = getCurrentBar()
	-- current bar starts at 0
	if #beatmap >= currentBar + 1 then 
		for i=1,#beatmap[currentBar + 1] do
			if beatmap[currentBar + 1][i].play then 
				if beatmap[currentBar + 1][i].hit then 
					love.graphics.setColor(0,255,0,255)			
					love.graphics.circle("fill", (beatmap[currentBar + 1][i].songPosition / getBarLength()) * love.graphics.getWidth(), love.graphics.getHeight()/2, 30, 32)
				elseif beatmap[currentBar + 1][i].missed then 
					love.graphics.setColor(255,0,0,255)			
					love.graphics.circle("fill", (beatmap[currentBar + 1][i].songPosition / getBarLength()) * love.graphics.getWidth(), love.graphics.getHeight()/2, 30, 32)
				else 
					love.graphics.setColor(255,255,0,255)			
					love.graphics.circle("fill", (beatmap[currentBar + 1][i].songPosition / getBarLength()) * love.graphics.getWidth(), love.graphics.getHeight()/2, 30, 32)
				end 
				love.graphics.setColor(255,255,255, 255)
			end 
		end
	end 

	love.graphics.line(0, love.graphics.getHeight()/2, love.graphics.getWidth(), love.graphics.getHeight()/2)
	--love.graphics.circle("fill", love.graphics.getWidth()/2, love.graphics.getHeight()/2, radius, 32)
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



