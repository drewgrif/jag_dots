-- for enable the indent markers.
return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = "BufEnter",
	opts = {
		scope = { enabled = false },
	},
}
