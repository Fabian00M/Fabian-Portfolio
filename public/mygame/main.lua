function love.load()
    -- Load the font
    font = love.graphics.newFont(20)

    -- Load the images
    book_img = love.graphics.newImage("book.png")
    princess_img = love.graphics.newImage("princess.png")
    castle_img = love.graphics.newImage("castle.png")
    sunrise_img = love.graphics.newImage("sunrise.png")
    dragon_img = love.graphics.newImage("dragon.png")
    knight_img = love.graphics.newImage("knight.png")
    fight_img = love.graphics.newImage("fight.png")
    rescue_img = love.graphics.newImage("rescue.png")
    reward_img = love.graphics.newImage("reward.png")
    celebration_img = love.graphics.newImage("celebration.png")
    exclamation_img = love.graphics.newImage("exclamation.png")
    theend_img = love.graphics.newImage("theend.png")
    
    -- Set up the animation frames
    frames = {}
    for line in love.filesystem.lines("story.txt") do
        local parts = {}
        for part in line:gmatch("%S+") do
            table.insert(parts, part)
        end
        local image_name = parts[#parts]
        table.remove(parts)
        local text = table.concat(parts, " ")
        local image = nil 
        if image_name == "book.png" then
            image = book_img
        elseif image_name == "princess.png" then
            image = princess_img
        elseif image_name == "castle.png" then
            image = castle_img
        elseif image_name == "sunrise.png" then
            image = sunrise_img
        elseif image_name == "dragon.png" then
            image = dragon_img
        elseif image_name == "knight.png" then
            image = knight_img
        elseif image_name == "fight.png" then
            image = fight_img
        elseif image_name == "rescue.png" then
            image = rescue_img
        elseif image_name == "reward.png" then
            image = reward_img
        elseif image_name == "celebration.png" then
            image = celebration_img
        elseif image_name == "exclamation.png" then
            image = exclamation_img
        elseif image_name == "theend.png" then
            image = theend_img 
        end
        table.insert(frames, {text = text, image = image})
    end

    current_frame = 1

    -- Set up the button
    button_width = 100
    button_height = 50
    button_x = love.graphics.getWidth() - button_width - 10
    button_y = love.graphics.getHeight() - button_height - 10
    button_text = "Next"
    button_font = love.graphics.newFont(16)
    button_color = {255, 255, 255}
    button_hover_color = {200, 200, 200}
    button_pressed_color = {150, 150, 150}
    button_state = "up"
end

function love.update(dt)
    -- Update the button state
    local mouse_x, mouse_y = love.mouse.getPosition()
    if mouse_x >= button_x and mouse_x < button_x + button_width and mouse_y >= button_y and mouse_y < button_y + button_height then
        if love.mouse.isDown(1) then
            button_state = "pressed"
        else
            button_state = "hover"
        end
    else
        button_state = "up"
    end
end

function love.draw()
    -- Draw the current frame
    love.graphics.setColor(255, 255, 255)
    love.graphics.setFont(font)
    local frame = frames[current_frame]
    local text = frame.text
    local text_width = font:getWidth(text)
    local text_height = font:getHeight()
    local image = frame.image
    if image ~= nil then
        local image_width = image:getWidth()
        local image_height = image:getHeight()
        local scale_factor = 0.5 -- Change the scale factor as desired
        love.graphics.draw(image, (love.graphics.getWidth() - scale_factor*image_width) / 2, (love.graphics.getHeight() - text_height - scale_factor*image_height - 20) / 2, 0, scale_factor, scale_factor)
        love.graphics.printf(text, (love.graphics.getWidth() - text_width) / 2, (love.graphics.getHeight() + scale_factor*image_height + 20 - text_height) / 2, text_width, "center")
    else
        love.graphics.printf(text, (love.graphics.getWidth() - text_width) / 2, (love.graphics.getHeight() - text_height) / 2, text_width, "center")
    end

   -- Draw the button
   if button_state == "up" then
      love.graphics.setColor(button_color)
   elseif button_state == "hover" then
      love.graphics.setColor(button_hover_color)
   elseif button_state == "pressed" then
      love.graphics.setColor(button_pressed_color)
   end
   love.graphics.rectangle("fill", button_x, button_y, button_width, button_height)
   love.graphics.setFont(button_font)
   love.graphics.setColor(0, 0, 0)
   love.graphics.printf(button_text, button_x, button_y + button_height / 2 - button_font:getHeight() / 2, button_width, "center")
end

function love.mousepressed(x, y, button)
    -- Go to the next frame if the button is pressed
    if button == 1 and button_state ~= "disabled" then
       if current_frame < #frames then
          current_frame = current_frame + 1
       else
          love.event.quit()
       end
    end
 end
 