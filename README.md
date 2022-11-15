# tddp

This is another repl plugin with a focus on enhancing the TDD
workflow with python. The idea is to use the pytest fixtures
to provide autocomplete when developing the code.

It works by opening an IPython embed instance inside the function 
you are writing and providing commands for the most common actions, 
including tab completion.

![tddp usage](./doc/readme_show.gif)

All commands showed in the video are present in the recommended 
keymap.

## Install

With Packer:
```lua
use 'petrusboniatus/tddp'
```

## Requirements
```shell
pip install pytest ipython
```

## Recomended keymap
```lua

vim.api.nvim_set_keymap('n', '<leader>to', ':lua require"tddp".open_debug_term()<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>tc', ':lua require"tddp".close_debug_term()<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ti', ':lua require"tddp".inspect()<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>tt', ':lua require"tddp".set_command_to_test_of_current_line()<cr>', {noremap = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', '<ESC>:lua require"tddp".complete()<cr>A', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-e>', '<ESC>:lua require"tddp".execute()<cr>A<Cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-e>', '<ESC>:lua require"tddp".execute()<cr>j', {noremap = true})
vim.api.nvim_set_keymap('v', '<leader>e', '<ESC>:lua require"tddp".run_selected_text()<cr>', {noremap = true})

```
