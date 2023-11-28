local time = require 'time'
local terminal = require 'terminal'

local scene = {}

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

local glitch_sound = love.audio.newSource('assets/sounds/glitch.wav', 'static'); glitch_sound:setVolume(.3); glitch_sound:setLooping(true)

------------------------

function scene.load()
	terminal.load()
	terminal.set_data(user, hacker)

	scene.being_story()
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

------------------------ STORY


function scene.being_story()
	terminal.lock()

	--[[

	terminal.send_no_label '###############################################################'
	terminal.send_no_label 'Terminal Winlux [versão 10.0.17134.285ac%782*@3-stable]'
	terminal.send_no_label 'Copyright (c) Softmicro Foundation'
	terminal.send_no_label 'Consulte a licença'
	terminal.send_no_label '###############################################################'
	terminal.send_no_label ''

	terminal.prompt(terminal.send_as_system, 'Processando requisição...', 5)
	terminal.prompt(terminal.send_as_system, 'Pacote de reconhecimento enviado;', 4)

	for i = 1, 15 do
		terminal.prompt(terminal.send_as_system, 'Escutando na porta '..user.port..'...', 1)
	end

	terminal.prompt(terminal.send_as_system, 'Resposta recebida;', 5)
	terminal.prompt(terminal.send_as_system, 'Finalizando aperto de mão;', 5.5)
	terminal.prompt(terminal.send_as_system, 'Conexão estabelecida;', 4)
	terminal.prompt(terminal.send_as_system, 'Sincronizando dados...', 1)

	time.append(function () glitch_sound:play() end, 0)
	for line in love.filesystem.lines('assets/glitch.txt') do
		terminal.prompt(terminal.send_no_label, line, .01)
	end
	time.append(function () glitch_sound:stop() end, 0)

	time.append(terminal.clear_buffer, 1)
	terminal.prompt(terminal.send_as_system, 'Conexão estabelecida com '..hacker.ip..' na porta '..hacker.port..'.', 2)

	terminal.prompt(terminal.send_as_hacker, 'seus firewalls são tão robustos quanto uma parede de papel', 5)
	terminal.prompt(terminal.send_as_hacker, 'esqueceu de atualizar o windows, não é?', 3)
	terminal.prompt(terminal.send_as_hacker, 'isso sem citar o fato de você abrir um arquivo chamado "não-é-um-vírus.exe"', 5)
	terminal.prompt(terminal.send_as_hacker, 'é como carregar uma placa enorme escrito "eu sou um vírus"')
	terminal.prompt(terminal.send_as_hacker, 'e mesmo assim você abriu...')
	terminal.prompt(terminal.send_as_hacker, 'eu não me surpreenderia se você me disser que já clicou num daqueles...')
	terminal.prompt(terminal.send_as_hacker, '...anúncios de mães solteiras na sua área também', 0)
	terminal.prompt(terminal.send_as_hacker, 'não me entenda errado, fico agradecido pelo que fez')
	terminal.prompt(terminal.send_as_hacker, 'agora eu tenho acesso completo a todas as suas senhas, contas e informações')
	terminal.prompt(terminal.send_as_hacker, 'não precisa se alarmar tanto')
	terminal.prompt(terminal.send_as_hacker, 'considere isso uma remodelação não autorizada do seu sistema')
	terminal.prompt(terminal.send_as_hacker, 'uma intervenção artística, se preferir')
	terminal.prompt(terminal.send_as_hacker, 'sei que você adora seus segredos digitais, mas não se preocupe')
	terminal.prompt(terminal.send_as_hacker, 'não vou sair por aí divulgando seus memes constrangedores..')
	terminal.prompt(terminal.send_as_hacker, '...nem a sua pasta secreta de prazeres culposos')
	terminal.prompt(terminal.send_as_hacker, 'mas apenas se, é claro, se você me der o que eu desejo')
	terminal.prompt(terminal.send_as_hacker, 'ah, claro, óbvio')
	terminal.prompt(terminal.send_as_hacker, 'vou entender se você não acreditar em mim, '..USERNAME)
	terminal.prompt(terminal.send_as_hacker, 'você tem mesmo a cara de quem não confia muito nas pessoas')

	local cmd = utils.capture 'pnputil /enum-devices /class Camera /connected'
	if cmd:find 'Iniciado' or cmd:find 'Started' then
		terminal.prompt(terminal.send_as_hacker, 'literalmente, eu consigo ver a sua câmera')
		time.append(function () os.execute('start microsoft.windows.camera:') end, 4)
		time.append(function () os.execute('taskkill /f /im WindowsCamera.exe') end, 5)
		terminal.prompt(terminal.send_as_hacker, 'esse não é o rosto de quem põe fé na minha história', 2)
	else
		terminal.prompt(terminal.send_as_hacker, 'você não acredita que eu tenho controle do seu computador')
		terminal.prompt(terminal.send_as_hacker, 'é uma reação perfeitamente compreensível.')
	end

	terminal.prompt(terminal.send_as_hacker, 'nesse caso, olha só o que eu sei fazer...')

	local window_x, window_y, window_displayindex = love.window.getPosition()
	time.append(function ()
		lerp_window = true
		lerp_to = {x = window_x + 120, y = window_y + 120}
	end, 1)

	time.append(function ()
		lerp_window = true
		lerp_to = {x = window_x - 120, y = window_y - 120}
	end, 1)

	time.append(function ()
		lerp_window = true
		lerp_to = {x = window_x - 120, y = window_y + 120}
	end, 1)

	time.append(function ()
		lerp_window = true
		lerp_to = {x = window_x + 120, y = window_y - 120}
	end, 1)

	time.append(function ()
		lerp_window = true
		lerp_to = {x = window_x, y = window_y}
	end, 1)

	time.append(function() lerp_window = false end, 1)

	terminal.prompt(terminal.send_as_hacker, 'legal, né?')
	terminal.prompt(terminal.send_as_hacker, 'enfim, preciso ir')
	terminal.prompt(terminal.send_as_hacker, 'algum idiota abriu o meu malware...')
	terminal.prompt(terminal.send_as_hacker, '...então eu vou copiar os dados do computador dele')
	terminal.prompt(terminal.send_as_hacker, 'entendeu?', 2)
	terminal.prompt(terminal.send_as_hacker, 'entendeu?')
	terminal.prompt(terminal.send_as_hacker, 'é engraçado porque esse idiota é você')
	terminal.prompt(terminal.send_as_hacker, 'enfim, você tem 20 minutos')
	terminal.prompt(terminal.send_as_hacker, 'se eu não receber o que eu quero até lá...')
	terminal.prompt(terminal.send_as_hacker, '...o histórico do seu navegador será público')

	time.append(terminal.clear_buffer, 6)

	--[[]]

	terminal.prompt(terminal.send_unknown, 'Macacos me mordam! Ora que infortúnio! [O_O]', 5)
	terminal.prompt(terminal.send_unknown, 'O seu computador acaba de ser invadido por um usuário malicioso! [U~U]', 2)
	terminal.prompt(terminal.send_unknown, 'Sorte a sua que o seu plano de antivírus contém auxílio de Inteligência Artificial! [^v^]', 3)
	terminal.prompt(terminal.send_as_amy, 'O meu nome é Amy, e eu sou a I.A. designada para o seu caso. [O_^]')
	terminal.prompt(terminal.send_as_amy, 'Não precisa ter medo. Eu não mordo. [^_^]')
	terminal.prompt(terminal.send_as_amy, 'Pelo menos não na maioria das vezes. [O///O]')
	terminal.prompt(terminal.send_as_amy, 'Você pode começar digitando \'help\' para listar todos os comandos disponíveis. [UwU]', 3)

	time.append(function() terminal.input_callback = scene.parse end, 0)

	time.append(terminal.unlock, 0)
end

------------------------ Interpreter

function scene.parse(command)
	if command:match("^%s*$") then return end

	terminal.send_as_user(command)

	if terminal.interpreter[command] ~= nil then
		terminal.interpreter[command]()
	else
		terminal.send_no_label 'O comando que você tentou executar não existe.'
	end
end

------------------------ Sync the other methods

for k, v in pairs(terminal) do
	if type(v) == 'function' and scene[k] == nil then scene[k] = terminal[k] end
end

return scene