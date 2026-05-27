local M = {}

function M.setup()
    -- nvim-treesitter stores queries under runtime/queries/ not queries/
    -- so we need to add the runtime/ subdirectory to the runtimepath
    local ts_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/nvim-treesitter/runtime"
    if vim.fn.isdirectory(ts_path) == 1 then
        vim.opt.runtimepath:append(ts_path)
    end

    require("mappings").register({ "<leader>It", "<cmd>TSUpdate<cr>", desc = "Update parsers" })
    require("mappings").register({ "<leader>IT", "<cmd>TSInstall all<cr>", desc = "Install parsers (all)" })

    local function enable_treesitter(buf)
        if not pcall(vim.treesitter.start, buf) then
            return
        end
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end

    vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
            enable_treesitter(args.buf)
        end,
    })

    -- Re-trigger for buffers that already have a filetype set before this autocmd was registered
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].filetype ~= "" and vim.api.nvim_buf_is_loaded(buf) then
            enable_treesitter(buf)
        end
    end
end

return M
