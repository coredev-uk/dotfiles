local nls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local completion = nls.builtins.completion

require("null-ls").setup({
    sources = {
        completion.vsnip,
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.formatting_sync()
                end,
            })
        end
    end,
})
