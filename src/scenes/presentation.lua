local time = require 'time'

local terminal = require 'terminal'
local scene = {}
local story = {}

local user = {
	id = USERNAME..'@'..HOSTNAME,
	ip = string.format("%03d", math.random(10, 255)).. '.' ..string.format("%03d", math.random(10, 255))..'.'..string.format("%03d", math.random(10, 255)),
	port = math.random(444, 65535)
}

local hacker = {
	id = 'kovach@k0v4ck',
	ip = string.format("%03d", math.random(11, 255))..'.'..string.format("%03d", math.random(11, 255))..'.'..string.format("%03d", math.random(11, 255)),
	port = math.random(444, 65535)
}

local lerp_window
local lerp_to = {}
local lerp_speed = .1

------------------------ STORY


function story.begin()
	terminal.lock()
	
	send_no_label('###############################################################')
	send_no_label('Winlux Terminal [versão 10.0.17134.285ac%782*@@@@@3-estável]')
	send_no_label('Copyright (c) Softmicro Foundation')
	send_no_label('Consulte a licença')
	send_no_label('###############################################################')
	send_no_label('')

	time.schedule(function () send_as_system('processando requisição...') end, 3)
	time.schedule(function () send_as_system('pacote de reconhecimento enviado') end, 8)
	time.schedule(function () send_as_system('escutando na porta '..user.port..'...') end, 11)
	time.schedule(function () send_as_system('escutando na porta '..user.port..'...') end, 12)
	time.schedule(function () send_as_system('escutando na porta '..user.port..'...') end, 13)
	time.schedule(function () send_as_system('escutando na porta '..user.port..'...') end, 14)
	time.schedule(function () send_as_system('escutando na porta '..user.port..'...') end, 15)
	time.schedule(function () send_as_system('resposta recebida') end, 20)
	time.schedule(function () send_as_system('finalizando aperto de mão de três vias') end, 21)
	time.schedule(function () send_as_system('conexão TCP estabelecida') end, 30)
	time.schedule(function () send_as_system('transferindo dados...') end, 33)

	time.schedule(story.glitch, 40)
end

function story.glitch()
	local i = 0
	for line in love.filesystem.lines('assets/glitch1.txt') do
		i = i + 1
		time.schedule(function () send_no_label(line) end, i/30)
	end

	time.schedule(function ()
		terminal.reset_buffer()
		time.schedule(story.first_interaction, 3)
	end, i/30 + 3)
end

function story.first_interaction()
	time.schedule(function () send_as_system('conexão estabelecida com '..hacker.ip..' na porta '..hacker.port) end, time.after(1))

	auto_schedule_send_as_hacker('git add .')
	auto_schedule_send_as_hacker('git commit -m \'\'')
	auto_schedule_send_as_hacker('git push origin master --force')
	time.schedule(function () send_as_hacker('Quê?') end, time.after(4))
	auto_schedule_send_as_hacker('Não')
	auto_schedule_send_as_hacker('Espera')
	auto_schedule_send_as_hacker('O seu terminal se conectou diretamente no meu')
	auto_schedule_send_as_hacker('Você me pegou num momento constrangedor...')
	time.schedule(function () send_as_hacker('Eu não tô acreditando') end, time.after(5))
	time.schedule(function () send_as_hacker('Tava na cara aquilo era um vírus') end, time.after(1))
	auto_schedule_send_as_hacker('O arquivo se chama literalmente "não-é-um-vírus.exe"')
	auto_schedule_send_as_hacker('É como carregar uma placa enorme escrito "eu sou um vírus"')
	auto_schedule_send_as_hacker('E MESMO ASSIM........?')
	auto_schedule_send_as_hacker('Você não é muito bom com computadores, não é?')
	auto_schedule_send_as_hacker('Digo, pra ter feito uma besteira dessas, é a única explicação')
	auto_schedule_send_as_hacker('Bom, vitória minha, já que agora eu tenho controle do seu computador')
	time.schedule(function () send_as_hacker('O quê?') end, time.after(4))
	auto_schedule_send_as_hacker('Você não acredita em mim, '..USERNAME..'?')

	local cmd = utils.capture('pnputil /enum-devices /class Camera /connected')
	if cmd:find('Iniciado') or cmd:find('Started') then
		auto_schedule_send_as_hacker('Eu consigo ver a sua câmera')
		time.schedule(function () os.execute('start microsoft.windows.camera:') end, time.after(4))
		time.schedule(function () os.execute('taskkill /f /im WindowsCamera.exe') end, time.after(5))
		time.schedule(function () send_as_hacker('esse não é o rosto de quem põe fé na minha história') end, time.after(2))
	else
		auto_schedule_send_as_hacker('Você não acredita que eu tenho controle do seu computador, não é?')
		auto_schedule_send_as_hacker('Perfeitamente compreensível.')
	end

	auto_schedule_send_as_hacker('Nesse caso, olha só o que eu sei fazer...')

	local window_x, window_y, window_displayindex = love.window.getPosition()

	time.schedule(function ()
		lerp_window = true
		lerp_to = {x = window_x + 120, y = window_y + 120}
	end, time.after(1))

	time.schedule(function ()
		lerp_window = true
		lerp_to = {x = window_x - 120, y = window_y - 120}
	end, time.after(1))

	time.schedule(function ()
		lerp_window = true
		lerp_to = {x = window_x - 120, y = window_y + 120}
	end, time.after(1))

	time.schedule(function ()
		lerp_window = true
		lerp_to = {x = window_x + 120, y = window_y - 120}
	end, time.after(1))

	time.schedule(function ()
		lerp_window = true
		lerp_to = {x = window_x, y = window_y}
	end, time.after(1))

	time.schedule(function () lerp_window = false end, time.after(1))

	auto_schedule_send_as_hacker('Legal, né?')
end

------------------------

function scene.load()
	terminal.load()
	terminal.input_callback = scene.process_prompt

	story.begin()
end

function scene.update(delta)
	time.tick(delta)

	if lerp_window then
		local window_x, window_y, window_displayindex = love.window.getPosition()

		love.window.setPosition(
			utils.lerp(window_x, lerp_to.x, lerp_speed),
			utils.lerp(window_y, lerp_to.y, lerp_speed)
		)
	end
end

function scene.process_prompt(text)
	terminal.append_to_buffer(user.id, text, {.3, .9, .5, 1})
end

-------------------------

function send_as_user(text)
	scene.process_prompt(text)
end

function send_as_system(text)
	terminal.append_to_buffer('SISTEMA', text, {.3, .8, .9, 1})
end

function send_as_hacker(text)
	terminal.append_to_buffer(hacker.id, text, {.9, .3, .5, 1})
end

function auto_schedule_send_as_hacker(text)
	time.schedule(function ()
		send_as_hacker(text)
	end, time.after(text:len() * .1))
end

function send_no_label(text)
	terminal.append_to_buffer(nil, text, nil)
end

------------------------ Sync the other methods
for k, v in pairs(terminal) do
	if type(v) == 'function' and scene[k] == nil then scene[k] = terminal[k] end
end

return scene