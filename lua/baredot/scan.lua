local Scan = {}

---@type BaredotConfig
local options

-- Modified from ahmedkhalf/project.nvim
local function get_parent(path)
	path = path:match("^(.*)/")
	if path == "" then
		path = "/"
	end
	return path
end

local function get_files(file_dir)
	local files = {}
	local dir = vim.loop.fs_scandir(file_dir)
	if dir == nil then
		return files
	end

	while true do
		local file = vim.loop.fs_scandir_next(dir)
		if file == nil then
			return files
		end

		table.insert(files, file)
	end
end

local function has(dir, pattern)
	for _, file in ipairs(get_files(dir)) do
		if file:match(pattern) ~= nil then
			return true
		end
	end
	return false
end

function Scan.in_work_tree_no_dot_git()
	local search_dir = vim.fn.getcwd()
	local work_tree_root = options.git_work_tree
	if vim.fn.has("win32") > 0 then
		search_dir = search_dir:gsub("\\", "/")
		work_tree_root = work_tree_root:gsub("\\", "/")
	end

	while true do
		if search_dir == work_tree_root then
			return true
		end

		local pattern = options.disable_pattern
		if has(search_dir, pattern) then
			return false
		end

		local parent = get_parent(search_dir)
		if parent == nil or parent == search_dir then
			return false
		end

		search_dir = parent
	end
end

function Scan.setup(opt)
	options = opt
end

return Scan
