module = {}

local scheduled = {}

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

function module.sleep(seconds)
	if seconds > 0 then os.execute("ping -n " .. tonumber(seconds+1) .. " localhost > NUL") end
end

return module