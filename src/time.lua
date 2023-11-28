module = {}

local paused = false
local scheduled = {}

local after_time = 0
local multiplier = 1

function module.tick(delta)
	if paused then return end
	
	for callback, lifetime in pairs(scheduled) do
		if lifetime <= 0 then
			callback()
			scheduled[callback] = nil
		else
			scheduled[callback] = lifetime - delta * multiplier
		end
	end
end

function module.schedule(callback, seconds)
	local lambda = function() callback() end -- Forgive me Father for I'm about to sin
	scheduled[lambda] = seconds
end

function module.after(seconds)
	after_time = after_time + seconds
	return after_time
end

function module.stop()
	paused = true
end

function module.resume()
	paused = false
end

function module.forward()
	multiplier = 10
end

function module.backward()
	multiplier = 1
end

return module