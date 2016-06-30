local keys = {}


gameButtons = {}
gameButtons.button1 = "a"
gameButtons.button2 = "s"
gameButtons.button3 = "d"
gameButtons.button4 = "f"



function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end

    keys[key] = {down = true, time = getSongTime()} 

    print(key)
    --[[if key == "d" then 
        input.dKeyDown = true
    end ]]

end

function love.keyreleased(key)
    --[[if key == "escape" then
        love.event.quit()
    end]]

    keys[key] = {down = false, time = getSongTime()} 
    --[[if key == "d" then 
        input.dKeyDown = false
    end ]]

end

function initInput()
    keys[gameButtons.button1] = {down = false, time = 0}
    keys[gameButtons.button2] = {down = false, time = 0}
    keys[gameButtons.button3] = {down = false, time = 0}
    keys[gameButtons.button4] = {down = false, time = 0}
end 



-- the game should only ever call to these 2, never to the actual stuff in the key object
-- so call an iskeydown(gamebuttons.button) and then getpresstime(gamebuttons.button)

-- is the key pressed or released
function keyIsDown(key)
    if keys[key] ~= nil and keys[key].down then 
        return true 
    else 
        return false
    end 
end 

-- what time was the key pressed or released
function getKeyTime(key)
    if keys[key] ~= nil then 
        return keys[key].time 
    else 
        return 0
    end 
end 




