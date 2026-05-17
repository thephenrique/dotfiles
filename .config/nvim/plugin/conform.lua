local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		xml = { "xmlformatter" },

		javascript = { "biome", "oxfmt", "prettier", stop_after_first = true },
		javascriptreact = { "biome", "oxfmt", "prettier", stop_after_first = true },
		typescript = { "biome", "oxfmt", "prettier", stop_after_first = true },
		typescriptreact = { "biome", "oxfmt", "prettier", stop_after_first = true },
		css = { "biome", "oxfmt", "prettier", stop_after_first = true },
		html = { "biome", "oxfmt", "prettier", stop_after_first = true },
		json = { "biome", "oxfmt", "prettier", stop_after_first = true },
		jsonc = { "biome", "oxfmt", "prettier", stop_after_first = true },
		yaml = { "biome", "oxfmt", "prettier", stop_after_first = true },
		graphql = { "biome", "oxfmt", "prettier", stop_after_first = true },
		markdown = { "biome", "oxfmt", "prettier", stop_after_first = true },
	},
	formatters = {
		shfmt = {
			prepend_args = { "-i", "2", "-ci", "-bn" },
		},
		biome = {
			condition = function(_, ctx)
				return vim.fs.find({ "biome.json", "biome.jsonc" }, { path = ctx.filename, upward = true })[1] ~= nil
			end,
		},
		oxfmt = {
			condition = function(_, ctx)
				return vim.fs.find({ ".oxfmtrc.json", "oxfmt.json" }, { path = ctx.filename, upward = true })[1] ~= nil
			end,
		},
		prettier = {
			condition = function(_, ctx)
				return vim.fs.find({
					".prettierrc",
					".prettierrc.json",
					".prettierrc.js",
					".prettierrc.cjs",
					".prettierrc.yaml",
					".prettierrc.yml",
					"prettier.config.js",
					"prettier.config.cjs",
					".prettierrc.toml",
				}, { path = ctx.filename, upward = true })[1] ~= nil
			end,
		},
	},
	format_on_save = {
		timeout_ms = 2000,
		lsp_format = "fallback",
	},
})
