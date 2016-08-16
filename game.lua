local globalRunning = false

-- the +- allowance to hit a note
-- should change it so that + and - are different.
-- there should be a longer Pre allowance than post allowance
local offs = 30


function gameUpdate(dt)
	if keyIsDown(btns.one) then 
		globalRunning = true 
	end 



	if not globalRunning then 
		return 
	end 
	
	
	local songTime = updateAudioManager()

	-- to compare against actual bars 
	local currentBar = getCurrentBar() + 1
	-- to compare against song time 
	local currentBarInMs = getCurrentBar() * getBarLength() 

	-- current bar starts at 0
	if #beatmap < currentBar then 
		return
	end

	local noteToHit = 0
	for i=1,#beatmap[currentBar] do
		-- if it's a playable note and not a rest
		if beatmap[currentBar][i].play then 
			noteToHit = beatmap[currentBar][i].barPosition

			if songTime >= (currentBarInMs + noteToHit - offs) and songTime <= (currentBarInMs + noteToHit + offs) then 
				
				local currentButtonToPress = beatmap[currentBar][i].buttonToPress
				--print(currentButtonToPress)
				if keyIsDown(currentButtonToPress) and getKeyTime(currentButtonToPress) >= (currentBarInMs + noteToHit - (offs* 2)) and 
					getKeyTime(currentButtonToPress)  <= (currentBarInMs + noteToHit + (offs* 2)) and 
					beatmap[currentBar][i].hit == false then 

					print("hit")
					beatmap[currentBar][i].hit = true 
					playSfx()
				end 
			end 

			-- the note expired, set to missed
			if currentBarInMs + noteToHit + offs < songTime and beatmap[currentBar][i].hit == false and not beatmap[currentBar][i].missed then 
				beatmap[currentBar][i].missed = true
				print("miss")
			end 
		end
	end
	
	
end


function gameDraw()
	audioManagerDebugPrint()

	-- a value between 0 and 1 multiplied by the screen width
	local xVal = (getCurrentTimePositionInBar() / getBarLength()) * love.graphics.getWidth()
	love.graphics.line(xVal, 0, xVal, love.graphics.getHeight())


	-- current bar starts at 0, lua tables start at 1
	-- add 1 to make it line up
	local currentBar = getCurrentBar() + 1

	local buttonHeights = {}
	buttonHeights[btns.one] = (love.graphics.getHeight()/2) - 125
	buttonHeights[btns.two] = (love.graphics.getHeight()/2) - 50
	buttonHeights[btns.three] = (love.graphics.getHeight()/2) + 50
	buttonHeights[btns.four] = (love.graphics.getHeight()/2) + 125


	if #beatmap >= currentBar then 
		for i=1,#beatmap[currentBar] do
			if beatmap[currentBar][i].play then 

				local currentButtonToPress = beatmap[currentBar][i].buttonToPress
				
				if beatmap[currentBar][i].hit then 
					love.graphics.setColor(0,255,0,255)			
					love.graphics.circle("fill", (beatmap[currentBar][i].barPosition / getBarLength()) * love.graphics.getWidth(), buttonHeights[currentButtonToPress], 30, 32)
				elseif beatmap[currentBar][i].missed then 
					love.graphics.setColor(255,0,0,255)			
					love.graphics.circle("fill", (beatmap[currentBar][i].barPosition / getBarLength()) * love.graphics.getWidth(), buttonHeights[currentButtonToPress], 30, 32)
				else 
					love.graphics.setColor(255,255,0,255)			
					love.graphics.circle("fill", (beatmap[currentBar][i].barPosition / getBarLength()) * love.graphics.getWidth(), buttonHeights[currentButtonToPress], 30, 32)
				end 
				love.graphics.setColor(255,255,255, 255)
			end 
		end
	end 

	love.graphics.line(0, buttonHeights[btns.one], love.graphics.getWidth(), buttonHeights[btns.one])
	love.graphics.line(0, buttonHeights[btns.two], love.graphics.getWidth(), buttonHeights[btns.two])
	love.graphics.line(0, buttonHeights[btns.three], love.graphics.getWidth(), buttonHeights[btns.three])
	love.graphics.line(0, buttonHeights[btns.four], love.graphics.getWidth(), buttonHeights[btns.four])
end