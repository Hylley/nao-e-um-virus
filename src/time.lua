module = {}

local paused = false
local timeline = {}

local multiplier = 1

function module.tick(delta)
	if paused or #timeline <= 0 then return end

	local head = timeline[1]
	head.seconds = head.seconds - delta

	if head.seconds <= 0 then
		timeline[1].callback()
		table.remove(timeline, 1)
	end
end

function module.append(callback, seconds)
	timeline[#timeline + 1] = {callback = callback, seconds = seconds}
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