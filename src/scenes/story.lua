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

------------------------

function scene.load()
	terminal.load()
	terminal.set_data(user, hacker)

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

function scene.process_command(text)
	print(text)
	terminal.send_as_user(text)
end

function scene.prompt(sender, text, delay)
	delay = delay or text:len() * .1

	time.schedule(function ()
		sender(text)
	end, time.after(delay))
end

------------------------ STORY


function story.begin()
	terminal.lock()
	
	terminal.send_no_label('###############################################################')
	terminal.send_no_label('Winlux Terminal [versão 10.0.17134.285ac%782*@@@@@3-estável]')
	terminal.send_no_label('Copyright (c) Softmicro Foundation')
	terminal.send_no_label('Consulte a licença')
	terminal.send_no_label('###############################################################')
	terminal.send_no_label('')

	scene.prompt(terminal.send_as_system, 'Processando requisição...', 5)
	scene.prompt(terminal.send_as_system, 'Pacote de reconhecimento enviado;', 4)

	for i = 1, 15 do
		scene.prompt(terminal.send_as_system, 'Escutando na porta '..user.port..'...', 1)
	end

	scene.prompt(terminal.send_as_system, 'Resposta recebida;', 5)
	scene.prompt(terminal.send_as_system, 'Finalizando aperto de mão;', 5.5)
	scene.prompt(terminal.send_as_system, 'Conexão estabelecida;', 4)
	scene.prompt(terminal.send_as_system, 'Sincronizando dados...', 1)

	for line in love.filesystem.lines('assets/glitch.txt') do
		scene.prompt(terminal.send_no_label, line, .01)
	end

	time.schedule(terminal.clear_buffer, time.after(1))
	scene.prompt(terminal.send_as_system, 'Conexão estabelecida com '..hacker.ip..' na porta '..hacker.port..'.', 2)

	scene.prompt(terminal.send_as_hacker, 'oi!', 5)
	scene.prompt(terminal.send_as_hacker, 'hã...eu não sei qual é a melhor forma de dizer isso...', 5)
	scene.prompt(terminal.send_as_hacker, 'você acabou de ser infectado', 5)
	scene.prompt(terminal.send_as_hacker, 'o arquivo que você abriu se chamava literalmente "não-é-um-vírus.exe"')
	scene.prompt(terminal.send_as_hacker, 'é como carregar uma placa enorme escrito "eu sou um vírus"')
	scene.prompt(terminal.send_as_hacker, 'e mesmo assim você clicou...')
	scene.prompt(terminal.send_as_hacker, 'eu não me surpreenderia se você me disser que já clicou num daqueles...')
	scene.prompt(terminal.send_as_hacker, '...anúncios de mães solteiras na sua área também', 0.1)
	scene.prompt(terminal.send_as_hacker, 'não me entenda errado, eu fico agradecido pelo que fez')
	scene.prompt(terminal.send_as_hacker, 'agora eu tenho acesso completo a todas as suas senhas, contas e informações')
	scene.prompt(terminal.send_as_hacker, 'mas mesmo assim, ainda sinto pena sua')
	scene.prompt(terminal.send_as_hacker, 'eu sou um hacker, não um monstro, tá?')
	scene.prompt(terminal.send_as_hacker, 'e vou entender se você não acreditar em mim, '..USERNAME)
	scene.prompt(terminal.send_as_hacker, 'você tem mesmo a cara de quem não confia muito nas pessoas')

	local cmd = utils.capture('pnputil /enum-devices /class Camera /connected')
	if cmd:find('Iniciado') or cmd:find('Started') then
		scene.prompt(terminal.send_as_hacker, 'literalmente, eu consigo ver a sua câmera')
		time.schedule(function () os.execute('start microsoft.windows.camera:') end, time.after(4))
		time.schedule(function () os.execute('taskkill /f /im WindowsCamera.exe') end, time.after(5))
		scene.prompt(terminal.send_as_hacker, 'esse não é o rosto de quem põe fé na minha história', 2)
	else
		scene.prompt(terminal.send_as_hacker, 'você não acredita que eu tenho controle do seu computador')
		scene.prompt(terminal.send_as_hacker, 'perfeitamente compreensível.')
	end

	scene.prompt(terminal.send_as_hacker, 'nesse caso, olha só o que eu sei fazer...')

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

	scene.prompt(terminal.send_as_hacker, 'legal, né?')
	scene.prompt(terminal.send_as_hacker, 'enfim, preciso ir')
	scene.prompt(terminal.send_as_hacker, 'algum idiota abriu o meu malware...')
	scene.prompt(terminal.send_as_hacker, '...então eu vou copiar os dados do computador dele')
	scene.prompt(terminal.send_as_hacker, 'entendeu?', 2)
	scene.prompt(terminal.send_as_hacker, 'entendeu?')
	scene.prompt(terminal.send_as_hacker, 'é engraçado porque esse idiota é você')
	scene.prompt(terminal.send_as_hacker, 'enfim, aproveite seus últimos momentos de paz...')
	scene.prompt(terminal.send_as_hacker, '...porque em breve, o histórico do seu navegador será público', 3)

	time.schedule(terminal.clear_buffer, time.after(6))

	scene.prompt(terminal.send_unknown, 'Macacos me mordam! Ora que infortúnio! [O_O]', 5)
	scene.prompt(terminal.send_unknown, 'O seu computador acaba de ser invadido por um usuário malicioso! [U~U]', 2)
	scene.prompt(terminal.send_unknown, 'Sorte a sua que o seu plano de antivírus contém auxílio de Inteligência Artificial! [^v^]', 3)
	scene.prompt(terminal.send_as_amy, 'O meu nome é Amy, e eu sou a I.A. designada para o seu caso. [O_^]')
	scene.prompt(terminal.send_as_amy, 'Não precisa ter medo. Eu não mordo. [^_^]')
	scene.prompt(terminal.send_as_amy, 'Pelo menos não na maioria das vezes. [O///O]')
	scene.prompt(terminal.send_as_amy, 'Você pode começar digitando \'help\' para listar todos os comandos disponíveis. [UwU]', 3)

	time.schedule(terminal.unlock, time.after(0))
	
end

------------------------ Sync the other methods
for k, v in pairs(terminal) do
	if type(v) == 'function' and scene[k] == nil then scene[k] = terminal[k] end
end

return scene