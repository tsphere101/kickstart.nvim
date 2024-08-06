return { -- Autoformat
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>f',
      function()
        local rt = require('conform').format { async = false, lsp_fallback = true, timeout_ms = 500 }
        print('Formatted buffer: ' .. tostring(rt))
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      c = { 'clangd' },
      cpp = { 'clangd' },
      -- Conform can also run multiple formatters sequentially
      python = { 'isort', 'black' },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      go = { 'gofmt' },
      json = { 'prettier' },
    },
  },
}
