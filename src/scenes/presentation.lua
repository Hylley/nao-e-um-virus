local time = require 'time'

local terminal = require 'src.terminal'
local scene = {}

local user_id = USERNAME..'@'..HOSTNAME

function scene.load()
	terminal.load()
	terminal.input_callback = scene.process_prompt

	time.schedule(function ()
		scene.process_prompt('Olá')
	end, 5)
end

function scene.update(delta)
	time.tick(delta)
end

function scene.process_prompt(text)
	scene.append_to_buffer(user_id, text, {.3, .9, .5, 1})
	terminal.descend()
end

-- Sync the other methods
for k, v in pairs(terminal) do
	if type(v) == 'function' and scene[k] == nil then scene[k] = terminal[k] end
end

return scene