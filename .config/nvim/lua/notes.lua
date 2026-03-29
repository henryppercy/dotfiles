local M = {}

local NOTES_PERSONAL = vim.fn.expand("~/notes/personal")
local NOTES_WORK = vim.fn.expand("~/notes/work")
local NOTE_BIN = "note"

function M.exec(args)
    local cmd = NOTE_BIN .. " " .. table.concat(args, " ")
    local output = vim.fn.system(cmd)

    if vim.v.shell_error ~= 0 then
        vim.notify(output, vim.log.levels.ERROR)
        return nil
    end

    local path = vim.trim(output)
    vim.cmd.edit(path)
    return path
end

function M.prompt_and_exec(prompts, cmd_builder)
    local inputs = {}

    local function collect(i)
        if i > #prompts then
            local args = cmd_builder(inputs)
            M.exec(args)
            return
        end

        local p = prompts[i]
        vim.ui.input({ prompt = p.prompt }, function(val)
            if val == nil then return end
            if p.required and val == "" then return end
            inputs[i] = val
            collect(i + 1)
        end)
    end

    collect(1)
end

function M.setup()
    local register = require("mappings").register

    register({ "<leader>n", group = "notes" })

    -- create / open
    register({ "<leader>nd", function() M.exec({ "daily" }) end, desc = "Open today's daily note" })
    register({
        "<leader>nD",
        function()
            vim.ui.input({ prompt = "Date (YYYY-MM-DD): " }, function(date)
                if not date or date == "" then return end
                M.exec({ "daily", date })
            end)
        end,
        desc = "Daily note for date",
    })
    register({ "<leader>nw", function() M.exec({ "work" }) end, desc = "Open today's work note" })
    register({
        "<leader>nW",
        function()
            vim.ui.input({ prompt = "Date (YYYY-MM-DD): " }, function(date)
                if not date or date == "" then return end
                M.exec({ "work", date })
            end)
        end,
        desc = "Work note for date",
    })
    register({ "<leader>nr", function() M.exec({ "weekly" }) end, desc = "Weekly review" })
    register({ "<leader>nR", function() M.exec({ "monthly" }) end, desc = "Monthly review" })
    register({
        "<leader>nm",
        function()
            M.prompt_and_exec({
                { prompt = "Client: ",                      required = true },
                { prompt = "Topic: ",                       required = true },
                { prompt = "Date (YYYY-MM-DD, optional): ", required = false },
            }, function(inputs)
                local args = { "meeting", inputs[1], inputs[2] }
                if inputs[3] and inputs[3] ~= "" then
                    table.insert(args, inputs[3])
                end
                return args
            end)
        end,
        desc = "Create meeting note",
    })
    register({
        "<leader>nt",
        function()
            M.prompt_and_exec({
                { prompt = "Client: ", required = true },
                { prompt = "Task: ",   required = true },
            }, function(inputs)
                return { "task", inputs[1], inputs[2] }
            end)
        end,
        desc = "Create task note",
    })

    -- find / search
    -- register({
    --     "<leader>nf",
    --     function() require("snacks.picker").files({ dirs = { NOTES_PERSONAL, NOTES_WORK } }) end,
    --     desc = "Find all notes",
    -- })
    -- register({
    --     "<leader>ns",
    --     function() require("snacks.picker").grep({ dirs = { NOTES_PERSONAL, NOTES_WORK } }) end,
    --     desc = "Grep all notes",
    -- })
    -- register({
    --     "<leader>n1",
    --     function() require("snacks.picker").files({ dirs = { NOTES_PERSONAL .. "/daily" } }) end,
    --     desc = "Find personal daily",
    -- })
    -- register({
    --     "<leader>n2",
    --     function() require("snacks.picker").files({ dirs = { NOTES_WORK .. "/daily" } }) end,
    --     desc = "Find work daily",
    -- })
    -- register({
    --     "<leader>n3",
    --     function() require("snacks.picker").files({ dirs = { NOTES_WORK .. "/tasks" } }) end,
    --     desc = "Find work tasks",
    -- })
    -- register({
    --     "<leader>n4",
    --     function() require("snacks.picker").files({ dirs = { NOTES_WORK .. "/meetings" } }) end,
    --     desc = "Find work meetings",
    -- })
end

return M
