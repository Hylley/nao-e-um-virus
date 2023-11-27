module = {}

local scheduled = {}
local time = 0

function module.tick(delta)
	for callback, info in pairs(scheduled) do
		info.foretime = info.foretime + delta

		if info.foretime >= info.deadline then
			callback()
			scheduled[callback] = nil
		end
	end
end

function module.schedule(callback, seconds)
	scheduled[callback] = {deadline = seconds, foretime = 0}
end

function module.after(seconds)
	time = time + seconds
	return time
end

return module