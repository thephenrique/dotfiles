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
	},
	snippet = {
		expand = function(args)
			-- Lua snippet engine.
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-n>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
			else
				cmp.complete()
			end
		end),
		["<C-p>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
			else
				cmp.complete()
			end
		end),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.config.disable,
	},
	--- @diagnostic disable-next-line: missing-fields
	formatting = {
		format = require("lspkind").cmp_format({
			mode = "symbol_text",
			maxwidth = 50,
		}),
	},
})
