local keys = {}


btns = {}
btns.one = "a"
btns.two = "s"
btns.three = "d"
btns.four = "f"



function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end

    keys[key] = {down = true, time = getSongTime()} 

end

function love.keyreleased(key)
    --[[if key == "escape" then
        love.event.quit()
    end]]
    keys[key] = {down = false, time = getSongTime()} 
end

function initInput()
    keys[btns.one] = {down = false, time = 0}
    keys[btns.two] = {down = false, time = 0}
    keys[btns.three] = {down = false, time = 0}
    keys[btns.four] = {down = false, time = 0}
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




