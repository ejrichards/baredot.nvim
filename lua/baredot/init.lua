local commands = require("baredot.commands")
local scan = require("baredot.scan")

local Baredot = {}

---@class BaredotConfig
local defaults = {
	git_dir = "~/.cfg",
	git_work_tree = "~",
	disable_pattern = "%.git"
}

---@param opt? BaredotConfig
function Baredot.setup(opt)
	---@type BaredotConfig
	local options = vim.tbl_deep_extend("force", {}, defaults, opt or {})

	options.git_dir = vim.fn.expand(options.git_dir)
	options.git_work_tree = vim.fn.expand(options.git_work_tree)

	commands.setup(options)
	scan.setup(options)

	if scan.in_work_tree_no_dot_git() then
		commands.set(true)
	end

	local group = vim.api.nvim_create_augroup("baredot", { clear = true })
	vim.api.nvim_create_autocmd("DirChanged", {
		group = group,
		desc =  "Baredot: scan for .git",
		callback = function()
			if vim.v.event.scope == "global" then
				commands.set(scan.in_work_tree_no_dot_git())
			end
		end,
	})
end

function Baredot.info()
	return commands.info()
end
---@param enable boolean
function Baredot.set(enable)
	return commands.set(enable)
end
function Baredot.toggle()
	return commands.toggle()
end

return Baredot
