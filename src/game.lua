local game = {}

game.current_scene = nil

function game.fetch_scene(name)
	return require('scenes.'..name)
end

function game.load_scene(name)
	if game.current_scene ~= nil then
		for k, v in pairs(current_scene) do
			if type(v) == "function" then love.remove(k) end
		end
	end

	local fetch = game.fetch_scene(name)

	for k, v in pairs(fetch) do
		if type(v) == "function" then love[k] = fetch[k] end
	end

	game.current_scene = fetch
end

return game