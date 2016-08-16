require "input"
require "audioManager"
require "game"
require "extraMathFunctions"

-- ADD A DEBUG BOOL
DEBUG_MODE = true 
-- wrap any debug code around it so it can be turned on / off easily

-- TODO 
-- here's an idea 
-- get rid of the current beatmap[bar][note] setup
-- just have beatmap[note] based on song position 
-- still need to set it up bar by bar, but that's just temp 

-- eliminate all direct accessign of the beatmap 
-- setup functions for everything that accesses the beatmap 

-- also change how newnote / beatmap setup goes 
-- the last param is useless 
-- that should be calculated / figured out automatically as you're building the bars/ beatmap


-- okay, so here's an idea for changing up input.
-- you have 4 tracks of input. when adding a bar, you have to add input for all 4 tracks
-- you specify track, time to press down, time to release 
-- or maybe you specify if it's updown (press), up, or down
-- so up, down. up and down == press, up == release, down == press, neither = rest
-- for each track you keep track of the press and release times
-- use an enum for that 



-- NOTES --
-- implement the hasfocus and quit callbacks
-- redo sfx management

-- have it show you performance by bar like in ff theatrhythm
-- then let you jump to bar to practice

-- implement all stuff that a music player would have
-- skip to point
-- play 
-- pause
-- volume

-- use a stack for showing menu screens



function love.load()
	audioManagerInit("assets/testSong.wav", 130)
	initInput()
end


function love.update(dt)
	gameUpdate(dt)	
end


function love.draw()
	gameDraw()
end


