# tddp

This is another repl plugin with a focus on enhancing the TDD
workflow with python. The idea is to use the pytest fixtures
to provide autocomplete when developing the code.

It works by opening an IPython embed instance inside the function 
you are writing and providing commands for the most common actions, 
including tab completion.

![tddp usage](./doc/readme_show.gif)

## Workflow

These steps describe the workflow using the module functions, 
of course you are supposed to assign keymap to those. The 
recommended ones are at the end of the readme.

1. Write the test and a skeleton of a function you want
2. Go to the line of the test you want to call and select it 
   `open_debug_term()`
3. Navigate to the function you want to code 
4. Call `open_debug_term()` to insert the `IPython.embed()` line 
   in the code, call the test and open the terminal
5. Here you have acces to the instance of the test so you can 
   use it as a notebook, you can call `run_selected_text()` to 
   execute selected lines or `complete()` to show the autocomplete
   of the repl of the current line
6. Call `close_debug_term()` to remove the `IPython.embed()` line
   and close the terminal

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
