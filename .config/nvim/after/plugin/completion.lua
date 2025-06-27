if not pcall(require, "cmp") then
	print("Plugin: cmp not found")
	return
end

if not pcall(require, "lspkind") then
	print("Plugin: lspkind not found")
	return
end

if not pcall(require, "luasnip") then
	print("Plugin: luasnip not found")
	return
end

local cmp = require("cmp")

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
	},
	snippet = {
		expand = function(args)
			-- Lua snippet engine.
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<CR>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			{ "i", "c" }
		),
	},
	--- @diagnostic disable-next-line: missing-fields
	formatting = {
		format = require("lspkind").cmp_format({
			mode = "symbol_text",
			maxwidth = 50,
		}),
	},
})
