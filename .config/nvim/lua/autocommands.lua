local M = {}

function M.setup()
    vim.api.nvim_create_autocmd("BufRead", {
      pattern = "/tmp/zsh*",
      callback = function()
        vim.bo.filetype = "bash"
      end,
    })
end

return M
