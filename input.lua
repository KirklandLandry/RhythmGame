keys = {}


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

function initKeys()
    keys[gameButtons.button1] = {down = false, time = 0}
    keys[gameButtons.button2] = {down = false, time = 0}
    keys[gameButtons.button3] = {down = false, time = 0}
    keys[gameButtons.button4] = {down = false, time = 0}
end 



--[[input = {}
input.mouseDown = false

input.aKeyDown = false
input.dKeyDown = false
input.iKeyDown = false
input.jKeyDown = false
input.oKeyDown = false
input.sKeyDown = false
input.wKeyDown = false
input.qKeyDown = false
input.eKeyDown = false

input.spaceKeyDown = false
input.escKeyDown = false

function input:Reset()
    input.mouseDown = false
    input.spaceKeyDown = false

    input.aKeyDown = false
    input.dKeyDown = false
    input.iKeyDown = false
    input.jKeyDown = false
    input.oKeyDown = false
    input.sKeyDown = false
    input.wKeyDown = false
    input.qKeyDown = false
    input.eKeyDown = false
end

--[[function input:UpdateInput()
    if love.mouse.isDown(1) then 
        if input.mouseDown==false then 
            input.mouseDown=true
        end 
    else input.mouseDown = false end 

    if love.keyboard.isDown('escape') then 
        if input.escKeyDown==false then 
            input.escKeyDown=true
        end 
    else input.escKeyDown=false end 

    if love.keyboard.isDown('space') then 
        if input.spaceKeyDown==false then 
            input.spaceKeyDown=true 
        end 
    else input.spaceKeyDown=false end 

    if love.keyboard.isDown('a') then 
        if input.aKeyDown==false then 
            input.aKeyDown=true
        end 
    else input.aKeyDown=false end 

    if love.keyboard.isDown('d') then 
        if input.dKeyDown==false then 
            input.dKeyDown=true
        end 
    else input.dKeyDown=false end 

    if love.keyboard.isDown('i') then 
        if input.iKeyDown==false then 
            input.iKeyDown=true
        end 
    else input.iKeyDown=false end 

    if love.keyboard.isDown('j') then 
        if input.jKeyDown==false then 
            input.jKeyDown=true
        end 
    else input.jKeyDown=false end 

    if love.keyboard.isDown('o') then 
        if input.oKeyDown==false then 
            input.oKeyDown=true
        end 
    else input.oKeyDown=false end 

    if love.keyboard.isDown('s') then 
        if input.sKeyDown==false then 
            input.sKeyDown=true
        end 
    else input.sKeyDown=false end 

    if love.keyboard.isDown('w') then 
        if input.wKeyDown==false then 
            input.wKeyDown=true
        end 
    else input.wKeyDown=false end 

    if love.keyboard.isDown('q') then 
        if input.qKeyDown==false then 
            input.qKeyDown=true
        end 
    else input.qKeyDown=false end 

    if love.keyboard.isDown('e') then 
        if input.eKeyDown==false then 
            input.eKeyDown=true
        end 
    else input.eKeyDown=false end 
end 
]]

