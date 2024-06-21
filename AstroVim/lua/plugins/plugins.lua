return {

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
  },
   
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm",
      transparent = true,
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent", -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
      },
    },
  },

    {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.everforest_background = "hard"
      vim.g.everforest_transparent_background = 2
      vim.g.everforest_enable_italic = true
      --  vim.cmd.colorscheme("everforest")
    end,
  },

  {
    "andweeb/presence.nvim",
    opts = {
      auto_update = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
      neovim_image_text = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
      main_image = "file", -- Main image display (either "neovim" or "file")
      client_id = "793271441293967371", -- Use your own Discord application client id (not recommended)
      log_level = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
      debounce_timeout = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
      enable_line_number = false, -- Displays the current line number instead of the current project
      blacklist = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
      buttons = false, -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
      file_assets = { js = { "JavaScript", "javascript" } }, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
      show_time = false, -- Show the timer

      -- Rich Presence text options
      editing_text = "Editing some stuff", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
      file_explorer_text = "Browsing file", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
      git_commit_text = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
      plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
      reading_text = "Reading", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
      workspace_text = function()
        return nil
      end, -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
      line_number_text = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
    },
  },
  
-- {
--   "rebelot/heirline.nvim",
--   opts = function(_, opts)
--     local status = require("astroui.status")
--
--     opts.statusline = { -- statusline
--       hl = { fg = "fg", bg = "bg" },
--       status.component.mode({
--         mode_text = { padding = { left = 1, right = 1 } },
--       }), -- add the mode text
--       status.component.git_branch(),
--       status.component.file_info(),
--       status.component.git_diff(),
--       status.component.diagnostics(),
--       status.component.fill(),
--       status.component.cmd_info(),
--       status.component.fill(),
--       status.component.lsp(),
--       status.component.virtual_env(),
--       status.component.treesitter(),
--       status.component.nav(),
--     }
--
--     opts.winbar = { -- winbar
--       init = function(self)
--         self.bufnr = vim.api.nvim_get_current_buf()
--       end,
--       fallthrough = false,
--       { -- inactive winbar
--         condition = function()
--           return not status.condition.is_active()
--         end,
--         status.component.separated_path(),
--         status.component.file_info({
--           file_icon = {
--             hl = status.hl.file_icon("winbar"),
--             padding = { left = 0 },
--           },
--           filename = {},
--           filetype = false,
--           file_read_only = false,
--           hl = status.hl.get_attributes("winbarnc", true),
--           surround = false,
--           update = "BufEnter",
--         }),
--       },
--       { -- active winbar
--         status.component.breadcrumbs({
--           hl = status.hl.get_attributes("winbar", true),
--         }),
--       },
--     }
--
--     opts.tabline = { -- tabline
--       { -- file tree padding
--         condition = function(self)
--           self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
--           self.winwidth = vim.api.nvim_win_get_width(self.winid)
--           return self.winwidth ~= vim.o.columns -- only apply to sidebars
--             and not require("astrocore.buffer").is_valid(
--               vim.api.nvim_win_get_buf(self.winid)
--             ) -- if buffer is not in tabline
--         end,
--         provider = function(self)
--           return (" "):rep(self.winwidth + 1)
--         end,
--         hl = { bg = "tabline_bg" },
--       },
--       status.heirline.make_buflist(status.component.tabline_file_info()), -- component for each buffer tab
--       status.component.fill({ hl = { bg = "tabline_bg" } }), -- fill the rest of the tabline with background color
--       { -- tab list
--         condition = function()
--           return #vim.api.nvim_list_tabpages() >= 2
--         end, -- only show tabs if there are more than one
--         status.heirline.make_tablist({ -- component for each tab
--           provider = status.provider.tabnr(),
--           hl = function(self)
--             return status.hl.get_attributes(
--               status.heirline.tab_type(self, "tab"),
--               true
--             )
--           end,
--         }),
--         { -- close button for current tab
--           provider = status.provider.close_button({
--             kind = "TabClose",
--             padding = { left = 1, right = 1 },
--           }),
--           hl = status.hl.get_attributes("tab_close", true),
--           on_click = {
--             callback = function()
--               require("astrocore.buffer").close_tab()
--             end,
--             name = "heirline_tabline_close_tab_callback",
--           },
--         },
--       },
--     }
--
--     opts.statuscolumn = { -- statuscolumn
--       init = function(self)
--         self.bufnr = vim.api.nvim_get_current_buf()
--       end,
--       status.component.foldcolumn(),
--       status.component.numbercolumn(),
--       status.component.signcolumn(),
--     }
--   end,
-- },
--
{
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    lazy = false,
    opts = {
    panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<M-l>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 18.x
  server_opts_overrides = {},
    },
  },

  {
  "zbirenbaum/copilot-cmp",
  config = function ()
    require("copilot_cmp").setup()
  end
  },


  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    cmd = "CopilotChat",
    opts = function()
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        model = "gpt-4",
        auto_insert_mode = true,
        show_help = true,
        question_header = "  " .. user .. " ",
        answer_header = "  Copilot ",
        window = {
          width = 0.4,
        },
        selection = function(source)
          local select = require("CopilotChat.select")
          return select.visual(source) or select.buffer(source)
        end,
      }
    end,
    keys = {
      { "<leader>a", "", desc = "+ai" },
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input)
          end
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      require("CopilotChat.integrations.cmp").setup()

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      chat.setup(opts)
    end,
  },

    -- Telescope integration
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    keys = {
      -- Show help actions with telescope
      {
        "<leader>ad",
        function()
          local actions = require("CopilotChat.actions")
          local help = actions.help_actions()
          -- if not help then
          --   LazyVim.warn("No diagnostics found on the current line")
          --   return
          -- end
          require("CopilotChat.integrations.telescope").pick(help)
        end,
        desc = "Diagnostic Help (CopilotChat)",
        mode = { "n", "v" },
      },
      -- Show prompts actions with telescope
      {
        "<leader>ap",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "Prompt Actions (CopilotChat)",
        mode = { "n", "v" },
      },
    },
  },

  {
    "ibhagwan/fzf-lua",
    optional = true,
    keys = {
      -- Show help actions with fzf-lua (if installed in extras)
      {
        "<leader>ad",
        function()
          local actions = require("CopilotChat.actions")
          local help = actions.help_actions()
          -- if not help then
          --   LazyVim.warn("No diagnostics found on the current line")
          --   return
          -- end
          require("CopilotChat.integrations.fzflua").pick(help)
        end,
        desc = "Diagnostic Help (CopilotChat)",
      },
      -- Show prompts actions with fzf-lua (if installed in extras)
      {
        "<leader>ap",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.fzflua").pick(actions.prompt_actions())
        end,
        desc = "Prompt Actions (CopilotChat)",
      },
    },
  },
  -- Edgy integration
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        ft = "copilot-chat",
        title = "Copilot Chat",
        size = { width = 50 },
      })
    end,
  },




  

}
