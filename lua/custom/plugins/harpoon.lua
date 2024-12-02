return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup {}

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = '[H]arpoon [a]dd file' })

    vim.keymap.set('n', '<leader>hd', function()
      harpoon:list():remove()
    end, { desc = '[H]arpoon [d]elete file' })

    vim.keymap.set('n', '<leader>hc', function()
      harpoon:list():clear()
    end, { desc = '[H]arpoon [c]lear files' })

    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    vim.keymap.set('n', '<leader>ho', function()
      toggle_telescope(harpoon:list())
    end, { desc = '[H]arpoon [o]pen selection window' })
  end,
}
