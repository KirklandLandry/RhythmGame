require "input"
require "audioManager"
require "game"
require "extraMathFunctions"

-- ADD A DEBUG BOOL
DEBUG_MODE = true 
-- wrap any debug code around it so it can be turned on / off easily

-- NOTES --
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

-- implement all stuff that a music player would have
-- skip to point
-- play 
-- pause
-- volume

-- use a stack for showing menu screens

-- okay, so here's an idea for changing up input.
-- you have 4 tracks of input. when adding a bar, you have to add input for all 4 tracks
-- you specify track, time to press down, time to release 
-- or maybe you specify if it's updown (press), up, or down
-- so up, down. up and down == press, up == release, down == press, neither = rest
-- for each track you keep track of the press and release times
-- 

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


