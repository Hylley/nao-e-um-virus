local utf8 = require'utf8'
local time = require 'time'

local scene = {}

local user = {}
local hacker = {}
scene.interpreter = {}

local scroll_sensitivity = 30
local scroll_offset = 0
local scroll_limit = {top = 0, bottom = 0}
local buffer = {}
local locked = false

local terminal_font = 'assets/fonts/vt323-latin-400-normal.ttf'
local input_text = ''
scene.input_callback = nil

local key_sound = love.audio.newSource('assets/sounds/key.wav', 'static'); key_sound:setVolume(.2)
local backspace_sound = love.audio.newSource('assets/sounds/backspace.wav', 'static'); backspace_sound:setVolume(.2)
local enter_sound = love.audio.newSource('assets/sounds/enter.wav', 'static'); backspace_sound:setVolume(.2)
local new_message_sound = love.audio.newSource('assets/sounds/new_message.wav', 'static'); backspace_sound:setVolume(.3)
local clear_terminal_sound = love.audio.newSource('assets/sounds/clear_terminal.wav', 'static'); backspace_sound:setVolume(.1)

local close_button

function scene.append_to_buffer(user, text, color)
	if user == nil or user == '' then
		buffer[#buffer + 1] = {user = nil, text = text, color = color}
		return
	end

	buffer[#buffer + 1] = {user = '['..user..']', text = text, color = color}

	scene.descend()
	new_message_sound:play()
end

function scene.load()
	love.window.setTitle 'Terminal'
	love.window.setIcon(love.image.newImageData("assets/images/icons/terminal.png"))
	love.graphics.setBackgroundColor(.04705882353, .04705882353, .04705882353)
	love.window.setMode(800, 500, {resizable = false, borderless = true})

	love.keyboard.setKeyRepeat(true)

	close_button = love.graphics.newImage 'assets/images/icons/white_close.png'
	scroll_limit.bottom = 0
end

function scene.set_data(new_user, new_hacker)
	user = new_user
	hacker = new_hacker
end

function scene.draw()
	for i=#buffer, 1, -1 do
		local message = buffer[i]
		local font_size = 20
		local spacing = 25

		local y_pos = (love.graphics.getHeight() - font_size - spacing * (#buffer - i)) - 60
		if y_pos + scroll_offset + font_size < - 1 then goto continue end

		love.graphics.setNewFont(terminal_font, font_size)
		if message.user ~= nil then
			-- Render name
			love.graphics.print({message.color, message.user}, font_size, y_pos + scroll_offset)
			-- Render text
			love.graphics.print({{1, 1, 1, 1}, message.text}, 20 + love.graphics.getFont():getWidth(message.user) + 10, y_pos + scroll_offset)
		else
			-- Render text
			love.graphics.print({{1, 1, 1, 1}, message.text}, font_size, y_pos + scroll_offset)
		end

		::continue::

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

	love.graphics.setNewFont('assets/fonts/Segoe UI.ttf', 16)
	love.graphics.print({{1, 1, 1, 1}, "Terminal"}, 20, 5)
	love.graphics.setNewFont(terminal_font, 20)

	love.graphics.print({{.5, .5, .5, 1}, ">"}, margin + 5, love.graphics.getHeight() - height - margin + 15)
	love.graphics.print({{.5, .5, .5, 1}, "_"}, margin + 30 + love.graphics.getFont():getWidth(input_text), love.graphics.getHeight() - height - margin + 15)
	love.graphics.print({{1, 1, 1, 1}, input_text}, margin + 25, love.graphics.getHeight() - height - margin + 15)

	if input_text == '' then
		love.graphics.print({{.5, .5, .5, 1}, "_"}, margin + 25, love.graphics.getHeight() - height - margin + 15)
	end
end

function scene.send_as_user   (text) scene.append_to_buffer(user.id,   text, { 1, .7,  0, 1}) end
function scene.send_as_system (text) scene.append_to_buffer('SISTEMA', text, {.3, .8, .9, 1}) end
function scene.send_as_hacker (text) scene.append_to_buffer(hacker.id, text, {.9, .3, .5, 1}) end
function scene.send_unknown   (text) scene.append_to_buffer('???',     text, {.6, .6, .6, 1}) end
function scene.send_as_amy    (text) scene.append_to_buffer('AMY',     text, { 0,  1, .4, 1}) end
function scene.send_no_label  (text) scene.append_to_buffer(nil,       text, nil            ) end

function scene.prompt(sender, text, delay)
	delay = delay or text:len() * .1

	time.append(function ()
		sender(text)
	end, delay)
end

------------------- Interpreter

function scene.interpreter.help()
	scene.send_no_label 'help            | Mostra os comandos disponívels;'
	scene.send_no_label 'clss            | Limpa o terminal;'
	scene.send_no_label 'list            | Lista os arquivos e diretórios do caminho atual;'
	scene.send_no_label 'cdir (caminho)  | Muda para o diretório especificado;'
	scene.send_no_label 'open (caminho)  | Abre ou executa o arquivo especificado;'
	scene.send_no_label 'info (caminho)  | Mostra informações sobre um diretório ou arquivo;'
	scene.send_no_label 'stat            | Mostra todas as conexões à rede ativas;'
	scene.send_no_label 'shut (conexão)  | Desliga uma conexão à força.'
end

function scene.interpreter.clss()
	scene.clear_buffer()
end

function scene.interpreter.list()
	
end

function scene.interpreter.cdir(path)
	
end

function scene.interpreter.open(path)
	
end

function scene.interpreter.info(path)
	
end

function scene.interpreter.stat()
	scene.send_no_label 'Você não tem permissão para executar esse comando.'
end

function scene.interpreter.shut(connection)
	scene.send_no_label 'Você não tem permissão para executar esse comando.'
end


-------------------

function scene.descend() scroll_offset = 0 end

function scene.clear_buffer()
	buffer = {}
	scroll_offset = 0
	scroll_limit.top = 0
	scroll_limit.bottom = 0

	clear_terminal_sound:play()
end

function scene.lock()
	locked = true
	input_text = ''
end

function scene.unlock()
	locked = false
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

function scene.keypressed(key)
    if key == 'space' then
		time.forward()
		return
	end

	if locked then return end

	if key == 'backspace' then
        local byteoffset = utf8.offset(input_text, -1)

        if byteoffset then
            input_text = string.sub(input_text, 1, byteoffset - 1)
        end

		backspace_sound:play()
		return
    end

	if key == 'return' and scene.input_callback ~= nil then
		scene.input_callback(input_text)
		input_text = ''
		enter_sound:play()
	end
end

function love.keyreleased(key)
	if key == 'space' then
		time.backward()
		return
	end
end

function scene.textinput(t)
	if locked then return end
    input_text = input_text .. t
	key_sound:play()
end

return scene