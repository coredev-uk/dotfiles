local wk = require("which-key")

wk.setup()

wk.register({

    -- Telescope
    ["<A-p>"] = {"<cmd>Telescope find_files<CR>", "Search files"},
    ["<A-f>"] = {"<cmd>Telescope live_grep<CR>", "Live search"},

    -- Buffers
    ["<A-Left>"] = {"<cmd>BufferLineCyclePrev<CR>", "Previous buffer"},
    ["<A-Right>"] = {"<cmd>BufferLineCycleNext<CR>", "Next buffer"},
    ["<A-S-Left>"] = {"<cmd>BufferLineMovePrev<CR>", "Move buffer left"},
    ["<A-S-Right>"] = {"<cmd>BufferLineMoveNext<CR>", "Move buffer right"},
    ["<A-c>"] = {"<cmd>bdelete<CR>", "Close buffer"},
    ["<A-1>"] = {"<cmd>BufferLineGoToBuffer 1<CR>", "Go to buffer 1"},
    ["<A-2>"] = {"<cmd>BufferLineGoToBuffer 2<CR>", "Go to buffer 2"},
    ["<A-3>"] = {"<cmd>BufferLineGoToBuffer 3<CR>", "Go to buffer 3"},
    ["<A-4>"] = {"<cmd>BufferLineGoToBuffer 4<CR>", "Go to buffer 4"},
    ["<A-5>"] = {"<cmd>BufferLineGoToBuffer 5<CR>", "Go to buffer 5"},
    ["<A-6>"] = {"<cmd>BufferLineGoToBuffer 6<CR>", "Go to buffer 6"},
    ["<A-7>"] = {"<cmd>BufferLineGoToBuffer 7<CR>", "Go to buffer 7"},
    ["<A-8>"] = {"<cmd>BufferLineGoToBuffer 8<CR>", "Go to buffer 8"},
    ["<A-9>"] = {"<cmd>BufferLineGoToBuffer 9<CR>", "Go to buffer 9"},

    -- Nvim Tree
    ["<A-m>"] = {"<cmd>NvimTreeToggle<CR>", "Toggle NvimTree"},
    ["<leader>trf"] = {"<cmd>NvimTreeRefresh<CR>", "Refresh NvimTree"},

    -- Move Lines
    ["<A-Down>"] = {"<cmd>m +1<CR>", "Move line down"},
    ["<A-Up>"] = {"<cmd>m -2<CR>", "Move line up"},

    -- Diagnostics
    ["<A-d>"] = {"<cmd>TroubleToggle<CR>", "Toggle Trouble"},

    ["<leader>"] = {

        d = {
            name = "Lsp Definition",
            g = {"<cmd>Lspsaga goto_definition<CR>", "Goto definition"},
            f = {"<cmd>Lspsaga peek_definition<CR>", "Peek definition"}
        },

        ["K"] = {"<cnd>Lspsage hover_doc<CR>", "Hover documentation"},
        r = {
            n = {"<cmd>Lspsaga rename<CR>", "Rename"}
        },
        c = {
            a = {"<cmd>Lspsaga code_action<CR>", "Code Actions"}
        }
    }
})
