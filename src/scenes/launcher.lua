local scene = {}

local admin_dialog
local no_button_position = {x = 330, y = 370}
local yes_button__color = {.7, .7, .7}
local close_button

function scene.load()
	love.window.setTitle('Controle de Conta de Usuário')
	love.window.setIcon(love.image.newImageData("assets/images/icons/defender.png"))
	admin_dialog = love.graphics.newImage("assets/images/admin_dialog_background.png")
	love.window.setMode(admin_dialog:getWidth(), admin_dialog:getHeight(), {resizable = false, borderless = true})

	love.audio.newSource('assets/sounds/uac.mp3', 'static'):play()

	close_button = love.graphics.newImage("assets/images/icons/close.png")
end


function scene.draw()
	-- Draw background
	for i = 0, love.graphics.getWidth() / admin_dialog:getWidth() do
		for j = 0, love.graphics.getHeight() / admin_dialog:getHeight() do
			love.graphics.draw(admin_dialog, i * admin_dialog:getWidth(), j * admin_dialog:getHeight())
		end
	end

	-- Draw texts
	love.graphics.setNewFont("assets/fonts/Segoe UI.ttf", 16)
	love.graphics.print({{0, 0, 0, 1}, "Controle de Conta de Usuário"}, 36, 17)

	love.graphics.setNewFont("assets/fonts/Segoe UI.ttf", 25)
	love.graphics.print({{0, 0, 0, 1}, "Deseja permitir que este aplicativo de um\nfornecedor desconhecido faça alterações no\nseu dispositivo?"}, 36, 56)
	love.graphics.print({{0, 0, 0, 1}, "não-é-um-vírus.exe"}, 36, 200)

	love.graphics.setNewFont("assets/fonts/Segoe UI.ttf", 18)
	love.graphics.print({{0, 0, 0, 1}, "Fornecedor: Desconhecido"}, 36, 260)
	love.graphics.print({{0, 0, 0, 1}, "Origem do arquivo: Disco rígido deste computador"}, 36, 280)

	love.graphics.print({{0, .4, .8, 1}, "Mostrar mais detalhes"}, 36, 325)

	-- Draw buttons
	love.graphics.draw(close_button, 609, 20, 0, .07, .07)

	love.graphics.setColor(yes_button__color)
	love.graphics.rectangle("fill", 36, 370, 288, 50)
	love.graphics.setColor(.7, .7, .7)
	love.graphics.rectangle("fill", no_button_position.x, no_button_position.y, 288, 50)

	love.graphics.print({{0, 0, 0, 1}, "Sim"}, 163, 382)
	love.graphics.print({{0, 0, 0, 1}, "Não"}, no_button_position.x + 118, no_button_position.y + 12)

	love.graphics.setColor(1, 1, 1)
end


function scene.mousemoved(x, y, dx, dy, istouch)
	if x > no_button_position.x and x < no_button_position.x + 288 and y > no_button_position.y and y < no_button_position.y + 50 then
		no_button_position.x = math.random(0, love.graphics.getWidth() - 288)
		no_button_position.y = math.random(0, love.graphics.getHeight() - 50)
		return
	end

	if x > 609 - 10 and x < 609 + (close_button:getWidth() * .07) + 10 and y > 20 - 10 and y < 20 + (close_button:getHeight() * .07) + 10 then
		love.mouse.setCursor(love.mouse.getSystemCursor("hand"))
		return
	end

	if x > 36 and x < 36 + 288 and y > 370 and y < 370 + 50 then
		love.mouse.setCursor(love.mouse.getSystemCursor("hand"))
		yes_button__color = {.5, .5, .5}
		return
	end

	yes_button__color = {.7, .7, .7}
	love.mouse.setCursor(love.mouse.getSystemCursor("arrow"))
end


function scene.mousepressed(x, y, k, istouch)
	if k ~= 1 then return end

	if x > 609 - 10 and x < 609 + (close_button:getWidth() * .07) + 10 and y > 20 - 10 and y < 20 + (close_button:getHeight() * .07) + 10 then
		love.event.quit()
	end

	if x > 36 and x < 36 + 288 and y > 370 and y < 370 + 50 then
		game.load_scene('story')
	end
end

return scene