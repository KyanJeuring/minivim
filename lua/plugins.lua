-- ==================================================
-- lazy.nvim bootstrap
-- ==================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- ==================================================
-- Plugins
-- ==================================================

require("lazy").setup({
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
  },

  -- ==================================================
  -- BUFFERLINE
  -- ==================================================

  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          always_show_bufferline = true,
          separator_style = { "|", "|" },
          diagnostics = false,
          close_command = "bdelete %d",
          right_mouse_command = "bdelete %d",
          show_buffer_icons = false,
          show_buffer_close_icons = true,
          show_close_icon = true,
          buffer_close_icon = " x ",
          close_icon = " x ",
          modified_icon = " * ",
          left_trunc_marker = "<",
          right_trunc_marker = ">",

          offsets = {
            {
              filetype = "NvimTree",
              text = "",
              highlight = "BufferLineFill",
              separator = false,
            },
          },

          custom_filter = function(bufnr)
            return vim.bo[bufnr].buftype ~= "terminal"
          end,
        },
      })
    end,
  },

  -- ==================================================
  -- LUALINE
  -- ==================================================

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local FG_LIGHT = "#d7dae0"
      local FG_DARK  = "#1e222a"
      local BG_DARK  = "#21252b"

      require("lualine").setup({
        options = {
          globalstatus = true,
          icons_enabled = false,
          section_separators = "",
          component_separators = "",
          theme = {
            normal = {
              a = { fg = FG_LIGHT, bg = BG_DARK },
              b = { fg = FG_LIGHT, bg = BG_DARK },
              c = { fg = FG_LIGHT, bg = BG_DARK },
            },
            inactive = {
              a = { fg = "#7f848e", bg = BG_DARK },
              b = { fg = "#7f848e", bg = BG_DARK },
              c = { fg = "#7f848e", bg = BG_DARK },
            },
          },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(mode)
                return " " .. mode .. " "
              end,
              color = function()
                local mode = vim.fn.mode()

                -- ======================================================
                -- Colors for different modes
                -- Customize these colors as you like
                -- ======================================================

                local colors = {
                  n = { bg = "#21252b", fg = "#abb2bf" }, -- NORMAL
                  i = { bg = "#ff7700", fg = FG_DARK },   -- INSERT
                  v = { bg = "#61afef", fg = FG_DARK },   -- VISUAL
                  V = { bg = "#61afef", fg = FG_DARK },
                  ["\22"] = { bg = "#61afef", fg = FG_DARK },
                  R = { bg = "#e06c75", fg = FG_DARK },   -- REPLACE
                  c = { bg = "#98c379", fg = FG_DARK },   -- COMMAND
                  t = { bg = "#e5c07b", fg = FG_DARK },   -- TERMINAL
                }
                return colors[mode] or { bg = "#21252b", fg = "#abb2bf" }
              end,
            },
          },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "filename",
              path = 1,
              symbols = {
                modified = " [+]",
                readonly = " [RO]",
                unnamed = "",
              },
            },
          },
          lualine_x = { "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },

  -- ==================================================
  -- File tree
  -- ==================================================

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
      local api = require("nvim-tree.api")

      require("nvim-tree").setup({
        view = {
          width = 30,
          adaptive_size = false,
        },

        actions = {
          open_file = {
            quit_on_open = false,
            resize_window = false,
            window_picker = {
              enable = false,
            },
          },
        },

        on_attach = function(bufnr)
          local function open_node()
            api.node.open.edit()
          end

          vim.keymap.set("n", "<CR>", open_node, {
            buffer = bufnr,
            silent = true,
            nowait = true,
            desc = "Open",
          })
        end,

        renderer = {
          group_empty = true,
          add_trailing = true,
          icons = {
            webdev_colors = false,
            git_placement = "after",
            show = {
              file = false,
              folder = false,
              folder_arrow = false,
              git = false,
            },
            glyphs = {
              default = " ",
              symlink = "@",

              folder = {
                default = ">",
                open = "v",
                empty = ">",
                empty_open = "v",
                symlink = ">@",
                symlink_open = "v@",
                arrow_open = "v",
                arrow_closed = ">",
              },

              git = {
                unstaged = "~",
                staged = "+",
                unmerged = "!",
                renamed = ">",
                untracked = "?",
                deleted = "x",
                ignored = ".",
              },
            },
          },
        },

        update_focused_file = { enable = false },
        filters = { dotfiles = false },
        git = { enable = false },
      })

      -- Lock NvimTree window width
      local function lock_tree_width()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].filetype == "NvimTree" then
            pcall(vim.api.nvim_win_set_width, win, 30)
            pcall(vim.api.nvim_win_set_option, win, "winfixwidth", true)
          end
        end
      end

      local grp = vim.api.nvim_create_augroup("NvimTreeWidthLock", { clear = true })

      -- Lock width on VimResized, WinEnter, and BufWinEnter to handle resizing and new windows
      vim.api.nvim_create_autocmd({ "VimResized", "WinEnter", "BufWinEnter" }, {
        group = grp,
        callback = lock_tree_width,
      })

      -- Also lock immediately when the tree buffer is created
      vim.api.nvim_create_autocmd("FileType", {
        group = grp,
        pattern = "NvimTree",
        callback = lock_tree_width,
      })

      -- Keymaps
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
      vim.keymap.set("n", "<leader>f", function()
        -- Open tree if closed
        if not api.tree.is_visible() then
          api.tree.open()
        end

        -- Reveal current file and focus tree
        api.tree.find_file({
          open = true,
          focus = true,
        })
      end, { silent = true, desc = "Focus tree on current file" })
    end,
  },
})
