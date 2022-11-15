# tddp
This is another repl plugin with a focus on enhancing the TDD
workflow with ipython. The idea is to use the test instances
to provide

The proposed 

## Requirements
```
pip install pytest ipython
```

## Recomended keymap
```lua

local function keymap(key, cmd)
	vim.api.nvim_set_keymap("n", key, cmd, { noremap = true })
end

keymap('<leader>to', ':lua require"tddp".open_debug_term()<cr>')
keymap('<leader>tc', ':lua require"tddp".close_debug_term()<cr>')
keymap('<leader>ti', ':lua require"tddp".inspect()<cr>')
keymap('<leader>tt', ':lua require"tddp".term_command=')

vim.api.nvim_set_keymap('i', '<S-Tab>', '<ESC>:lua require"tddp".complete()<cr>A', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-e>', '<ESC>:lua require"tddp".execute()<cr>A<Cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-e>', '<ESC>:lua require"tddp".execute()<cr>j', {noremap = true})
vim.api.nvim_set_keymap('v', '<leader>e', '<ESC>:lua require"tddp".run_selected_text()<cr>', {noremap = true})

```
