local Commands = {}

---@type BaredotConfig
local options

function Commands.set(enable)
	if enable then
		vim.env.GIT_WORK_TREE = options.git_work_tree
		vim.env.GIT_DIR = options.git_dir
	else
		vim.env.GIT_WORK_TREE = nil
		vim.env.GIT_DIR = nil
	end
end

function Commands.is_enabled()
	return vim.env.GIT_DIR ~= nil and vim.env.GIT_WORK_TREE ~= nil
end

function Commands.toggle()
	Commands.set(not Commands.is_enabled())
	Commands.info()
end

function Commands.info()
	if Commands.is_enabled() then
		vim.notify(
			"Baredot mode on: GIT_DIR=" .. vim.env.GIT_DIR .. " GIT_WORK_TREE=" .. vim.env.GIT_WORK_TREE,
			vim.log.levels.INFO,
			{ title = "baredot.nvim" }
		);
	else
		vim.notify("Baredot mode off", vim.log.levels.INFO, { title = "baredot.nvim" });
	end
end

function Commands.setup(opt)
	options = opt

	vim.api.nvim_create_user_command("BaredotInfo", Commands.info, { desc = "BaredotInfo" })
	vim.api.nvim_create_user_command("BaredotToggle", Commands.toggle, { desc = "BaredotToggle" })
end

return Commands
