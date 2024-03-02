-- fuzzy file finder.
return {
	{ 
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = function()
		return {
			defaults = {
				preview = false,
				vimgrep_arguments = {
					"rg",
					"-L",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				prompt_prefix = "   ",
				initial_mode = "insert",
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = {
						mirror = false,
					},
					width = 0.4,
					height = 0.40,
					preview_cutoff = 120,
				},
				hidden = true,
				file_ignore_patterns = { "node_modules" },
				color_devicons = true,
				mappings = {
					i = {
						["<ESC>"] = require("telescope.actions").close,
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
					},
				},
			},
		}
	end,
},
{
	 "nvim-telescope/telescope-ui-select.nvim",
	config = function()
		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown {
					}
				}
			}
		})
		require("telescope").load_extension("ui-select")
	end
	},
}
