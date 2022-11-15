local M = {
	text_win = nil,
	term_win = nil,
	term_buf = nil,
	term_id = nil,
	term_command = 'pytest -s test.py',
	break_point_string = "import IPython; IPython.embed()",
	how_to_open = 'vsplit',
	exit_command = 'exit()',
	print_command = "print",
	cancel_command_char_sequence = '\x03', -- CTRL + C
	start_multiline_char_sequence = '\x0f', -- CTRL + O
	end_multiline_char_sequence = '\n\n\n' -- alt + enter 
}


local function all_trim(s)
   return s:match( "^%s*(.-)%s*$" )
end


local function add_break_point()
	local current_row_number = tonumber(vim.api.nvim_win_get_cursor(0)[1])
	local line_string = vim.fn.getline(current_row_number)
	local tab_prefix = line_string:match("%s*")
	vim.api.nvim_buf_set_lines(
		0,
		current_row_number - 1,
		current_row_number - 1,
		false,
		{tab_prefix .. all_trim(M.break_point_string)  }
	)
	vim.api.nvim_buf_set_lines(
		0,
		current_row_number,
		current_row_number,
		false,
		{tab_prefix}
	)
	vim.cmd("normal! k")
	vim.cmd("w")
end

local function open_debug_terminal()
	M.text_win = vim.api.nvim_get_current_win()
	vim.cmd(M.how_to_open)
	M.term_win = vim.api.nvim_get_current_win()
	M.term_buf = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_win_set_buf(M.term_win, M.term_buf)
	M.my_term_id = vim.fn.termopen(M.term_command)
	vim.api.nvim_set_current_win(M.text_win)
end

local function close_term()
	vim.fn.chansend(M.my_term_id, "\n" .. M.exit_command .. "\n")
	vim.api.nvim_win_close(M.term_win, true)
	M.text_win = nil
	M.term_win = nil
	M.term_buf = nil
	M.term_id = nil
end

local function remove_break_point()
	vim.cmd("g/" .. M.break_point_string .. "/d" ) --remove lines containing string
	vim.cmd("noh") -- clear the hilight
	vim.cmd("w")
end


local function get_visual_selection()
	local s_start = vim.fn.getpos("'<")
	local s_end = vim.fn.getpos("'>")
	local n_lines = math.abs(s_end[2] - s_start[2]) + 1
	local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
	lines[1] = string.sub(lines[1], s_start[3], -1)
	if n_lines == 1 then
		lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
	else
		lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
	end
	return table.concat(lines, '\n')
end



local function current_line_trimed()
	local row_number = tonumber(vim.api.nvim_win_get_cursor(0)[1])
	local line_string = vim.fn.getline(row_number)
	return all_trim(line_string)
end

function M.open_debug_term()
	add_break_point()
	open_debug_terminal()
end


function M.close_debug_term()
	close_term()
	remove_break_point()
end

function M.run_selected_text()
	vim.fn.chansend(M.my_term_id, M.cancel_command_char_sequence)
	vim.fn.chansend(M.my_term_id, M.cancel_command_char_sequence)
    vim.fn.chansend(M.my_term_id, M.start_multiline_char_sequence
		.. get_visual_selection():gsub("\n+", "\n")
		.. M.end_multiline_char_sequence)
end


function M.complete()
	vim.fn.chansend(M.my_term_id, M.cancel_command_char_sequence)
	vim.fn.chansend(M.my_term_id, M.cancel_command_char_sequence)
    vim.fn.chansend(M.my_term_id, current_line_trimed() .. "\t")
end

function M.execute()
	vim.fn.chansend(M.my_term_id, M.cancel_command_char_sequence)
	vim.fn.chansend(M.my_term_id, M.cancel_command_char_sequence)
    vim.fn.chansend(M.my_term_id, current_line_trimed() .. "\n")
end

function M.inspect()
	vim.fn.chansend(M.my_term_id, M.cancel_command_char_sequence)
	vim.fn.chansend(M.my_term_id, M.cancel_command_char_sequence)
    vim.fn.chansend(M.my_term_id, "\nprint(" .. current_line_trimed() .. ")\n")
end



return M
