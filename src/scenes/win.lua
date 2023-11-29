local scene = {}

local close_button

function scene.load()
	love.graphics.setBackgroundColor(1, 1, 1, 1)
	close_button = love.graphics.newImage("assets/images/icons/close.png")

	love.window.setMode(654, 450, {resizable = false, borderless = true})
end

function scene.draw()
	love.graphics.setNewFont("assets/fonts/Segoe UI.ttf", 30)
	love.graphics.print({{0, 0, 0, 1}, "Você venceu!"}, 220, 200)

	love.graphics.setNewFont("assets/fonts/Segoe UI.ttf", 16)
	love.graphics.print({{0, 0, 0, 1}, "*Não tive tempo de fazer algo melhor então é isso mesmo. <3"}, 190, 250)

	love.graphics.draw(close_button, 609, 20, 0, .07, .07)
end

function scene.mousemoved(x, y, dx, dy, istouch)
	if x > 609 - 10 and x < 609 + (close_button:getWidth() * .07) + 10 and y > 20 - 10 and y < 20 + (close_button:getHeight() * .07) + 10 then
		love.mouse.setCursor(love.mouse.getSystemCursor("hand"))
		return
	end

	love.mouse.setCursor(love.mouse.getSystemCursor("arrow"))
end

function scene.mousepressed(x, y, k, istouch)
	if x > 609 - 10 and x < 609 + (close_button:getWidth() * .07) + 10 and y > 20 - 10 and y < 20 + (close_button:getHeight() * .07) + 10 then
		love.event.quit()
	end
end

return scene