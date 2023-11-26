local game = {}

game.current_scene = nil

function game.fetch_scene(scene)
	local scene = require('scenes.'..scene) -- Since it's a local module this isn't going for the global table
	return scene
end

function game.unfetch_module(module)
	package.loaded[m] = nil
	_G[module] = nil
end

function game.load_scene(scene)
	game.reset()
	local fetch = game.fetch_scene(scene)

	if game.current_scene ~= nil then
		for k, v in pairs(game.current_scene) do
			if type(v) == 'function' then love[k] = nil end
		end
		
		fetch.load()
	end

	for k, v in pairs(fetch) do
		if type(v) == 'function' then love[k] = fetch[k] end
	end

	game.current_scene = fetch
end

function game.reset()
	love.graphics.clear()
	love.mouse.setCursor(love.mouse.getSystemCursor("arrow"))
end

return game