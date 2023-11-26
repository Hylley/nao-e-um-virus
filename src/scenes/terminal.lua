local utf8 = require("utf8")
local scene = {}

local scroll_sensitivity = 30
local scroll_offset = 0
local scroll_limit = {top = 0, bottom = 0}
local buffer = {}
local input_text = ''

local close_button

local function append_to_buffer(user, text, color)
	buffer[#buffer + 1] = {user = user, text = text, color = color}
end

---------------------------------------

function scene.load()
	love.window.setTitle('Terminal')
	love.window.setIcon(love.image.newImageData("assets/images/icons/terminal.png"))
	love.graphics.setBackgroundColor(.04705882353, .04705882353, .04705882353)
	love.window.setMode(800, 500, {resizable = false, borderless = true})

	local name = os.getenv('USERNAME')
	
	for i=0, 50 do
		append_to_buffer(name, 'saosaosnaosasas', {1, 0, 0, 1})
	end

	love.keyboard.setKeyRepeat(true)	

	close_button = love.graphics.newImage("assets/images/icons/white_close.png")
	scroll_limit.bottom = 0
end

function scene.draw()
	for i=#buffer, 1, -1 do
		local message = buffer[i]
		local font_size = 20
		local spacing = 20

		local y_pos = (love.graphics.getHeight() - font_size - spacing * (#buffer - i)) - 60

		love.graphics.setNewFont("assets/fonts/Segoe UI.ttf", font_size)
		-- Render name
		love.graphics.print({message.color, message.user}, font_size, y_pos + scroll_offset)
		-- Render text
		love.graphics.print({{1, 1, 1, 1}, message.text}, 20 + love.graphics.getFont():getWidth(message.user) + 10, y_pos + scroll_offset)

		if y_pos < scroll_limit.top then scroll_limit.top = y_pos - 30 end
	end

	-- Custom Title bar
	love.graphics.setColor(.1803921569, .1803921569, .1803921569)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), 31)

	-- Render text input box
	local margin = 10
	local height = 50
	love.graphics.setColor(.04705882353, .04705882353, .04705882353)
	love.graphics.rectangle("fill", margin, love.graphics.getHeight() - height, love.graphics.getWidth() - margin * 2, height)

	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(close_button, 775, 10, 0, .05, .05)

	love.graphics.setNewFont("assets/fonts/Segoe UI.ttf", 16)
	love.graphics.print({{1, 1, 1, 1}, "Terminal"}, 20, 5)
	love.graphics.setNewFont("assets/fonts/Segoe UI.ttf", 20)

	love.graphics.print({{.5, .5, .5, 1}, ">"}, margin + 5, love.graphics.getHeight() - height - margin + 15)
	love.graphics.print({{.5, .5, .5, 1}, "_"}, margin + 30 + love.graphics.getFont():getWidth(input_text), love.graphics.getHeight() - height - margin + 15)
	love.graphics.print({{1, 1, 1, 1}, input_text}, margin + 25, love.graphics.getHeight() - height - margin + 15)

	if input_text == '' then
		love.graphics.print({{.5, .5, .5, 1}, "_"}, margin + 25, love.graphics.getHeight() - height - margin + 15)
	end
end

function scene.wheelmoved(x, y)
	if y < 0 and scroll_offset <= scroll_limit.bottom then return end
	if y > 0 and math.abs(scroll_offset) >= math.abs(scroll_limit.top) then return end

	scroll_offset = scroll_offset + y * scroll_sensitivity
end

function scene.mousemoved(x, y, dx, dy, istouch)
	if x > 775 - 10 and x < 775 + (close_button:getWidth() * .05) + 10 and y > 10 - 10 and y < 10 + (close_button:getHeight() * .05) + 10 then
		love.mouse.setCursor(love.mouse.getSystemCursor("hand"))
		return
	end

	love.mouse.setCursor(love.mouse.getSystemCursor("arrow"))
end

function scene.mousepressed(x, y, k, istouch)
	if k ~= 1 then return end

	if x > 775 - 10 and x < 775 + (close_button:getWidth() * .05) + 10 and y > 10 - 10 and y < 10 + (close_button:getHeight() * .05) + 10 then
		love.event.quit()
		return
	end
end

function love.keypressed(key)
    if key == 'backspace' then
		input_text = input_text:sub(1, -2)
    end
end

function scene.textinput(t)
    input_text = input_text .. t
end


return scene