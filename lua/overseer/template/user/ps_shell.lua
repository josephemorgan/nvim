return {
	name = "ps shell",
	params = {
		cmd = { type = "string", order = 1 },
	},
	builder = function(p)
		return {
			cmd = { "powershell", "-NoLogo", "-NoProfile", "-ExecutionPolicy", "Bypass", "-Command", p.cmd },
			strategy = { "jobstart", use_terminal = true },
		}
	end,
}
