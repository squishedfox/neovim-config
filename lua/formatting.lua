-- Setup formatting for all styles

return require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "ruff", "isort" },
    -- Use a sub-list to run only the first available formatter
    javascript = { "prettier" },
    typescript = { "prettier" },
    go = { "gofmt", "goimports" },
    ["*"] = { "codespell" },
    ["_"] = { "trim_whitespace" },
  },
  notify_on_error = true,
  format_after_save = {
	  lsp_format = "fallback",
  }
})
