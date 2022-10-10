local line_ok, feline = pcall(require, "feline")
if not line_ok then
	return
end

local catppuccin = {
	fg = "#c6d0f5",
	bg = "#303446",
	green = "#81c8be",
	yellow = "#e5c890",
	purple = "#ca9ee6",
	orange = "#ef9f76",
	peanut = "#ea999c",
	red = "#ea999c",
	aqua = "#85c1dc",
	darkblue = "#8caaee",
	dark_red = "#e78284 ",
  grey_bg = "#626880",
  grey_fg = "#babbf1",
  flamingo = "#eebebe"
}

local material = {
	fg = "#222221",
	bg = "#fafafa",
	green = "#7aba39",
	yellow = "#fee92e",
	purple = "#a94dbb",
	orange = "#f5971d",
	peanut = "#f5971d",
	red = "#e83a3f",
	aqua = "#16aec9",
	darkblue = "#134eb2",
	dark_red = "#b7141e",
  grey_bg = "#d8d8d8",
  grey_fg = "#424242"
}

local vi_mode_colors = {
	NORMAL = "flamingo",
	OP = "green",
	INSERT = "purple",
	VISUAL = "darkblue",
	LINES = "orange",
	BLOCK = "orange",
	REPLACE = "red",
	COMMAND = "aqua",
}

local c = {
	vim_mode = {
		provider = {
			name = "vi_mode",
			opts = {
				show_mode_name = true,
				-- padding = "center", -- Uncomment for extra padding.
			},
		},
		hl = function()
			return {
				bg = require("feline.providers.vi_mode").get_mode_color(),
				fg = "bg",
				style = "bold",
				name = "NeovimModeHLColor",
			}
		end,
		left_sep = "left_rounded",
		right_sep = "block",
	},
	gitBranch = {
		provider = "git_branch",
		hl = {
			fg = "fg",
			bg = "bg",
			style = "bold",
		},
		left_sep = "block",
		right_sep = "block",
	},
	gitDiffAdded = {
		provider = "git_diff_added",
		hl = {
			fg = "green",
			bg = "bg",
		},
		left_sep = "block",
		right_sep = "",
	},
	gitDiffRemoved = {
		provider = "git_diff_removed",
		hl = {
			fg = "red",
			bg = "bg",
		},
		left_sep = "block",
		right_sep = "block",
	},
	gitDiffChanged = {
		provider = "git_diff_changed",
		hl = {
			fg = "fg",
			bg = "bg",
		},
		left_sep = "block",
		right_sep = "right_rounded",
	},
	separator = {
		provider = "",
	},
	fileinfo = {
		provider = {
			name = "file_info",
			opts = {
				type = "relative-short",
			},
		},
		hl = {
			style = "bold",
		},
		left_sep = " ",
		right_sep = " ",
	},
	diagnostic_errors = {
		provider = "diagnostic_errors",
		hl = {
			fg = "red",
      bg = "grey_fg"
		},
    right_sep = "block",
	},
	diagnostic_warnings = {
		provider = "diagnostic_warnings",
		hl = {
			fg = "yellow",
      bg = "grey_fg"
		},
    right_sep = "block"
	},
	diagnostic_hints = {
		provider = "diagnostic_hints",
		hl = {
			fg = "aqua",
      bg = "grey_fg"
		},
    right_sep = "block"
	},
	diagnostic_info = {
		provider = "diagnostic_info",
	},
	lsp_client_names = {
		provider = "lsp_client_names",
		hl = {
			fg = "grey_fg",
			bg = "grey_bg",
			style = "bold",
		},
		left_sep = "block",
		right_sep = "block",
	},
	file_type = {
		provider = {
			name = "file_type",
			opts = {
				filetype_icon = true,
				case = "titlecase",
			},
		},
		hl = {
			fg = "red",
			bg = "darkblue",
			style = "bold",
		},
		left_sep = "block",
		right_sep = "block",
	},
	file_encoding = {
		provider = "file_encoding",
		hl = {
			fg = "grey_fg",
			bg = "grey_bg",
			style = "italic",
		},
		left_sep = "block",
		right_sep = "right_rounded",
	},
	position = {
		provider = "position",
		hl = {
			fg = "grey_fg",
			bg = "grey_bg",
			style = "bold",
		},
		left_sep = "block",
		right_sep = "block",
	},
	line_percentage = {
		provider = "line_percentage",
		hl = {
			fg = "grey_fg",
			bg = "grey_bg",
			style = "bold",
		},
		left_sep = "block",
		right_sep = "right_rounded",
	},
	scroll_bar = {
		provider = "scroll_bar",
		hl = {
			fg = "yellow",
			style = "bold",
		},
	},
}

local left = {
	c.vim_mode,
  c.lsp_client_names,
	c.diagnostic_errors,
	c.diagnostic_warnings,
	c.diagnostic_info,
	c.diagnostic_hints,
	c.position,
	-- c.line_percentage,
  c.file_encoding,
}

local middle = {
	-- c.fileinfo,
	-- c.separator,
}

local right = {
  c.separator,
  c.separator,
  c.gitBranch,
	c.gitDiffAdded,
  c.gitDiffRemoved,
	c.gitDiffChanged,
	--c.scroll_bar,
}

local components = {
	active = {
		left,
		middle,
		right,
	},
	inactive = {
		left,
		middle,
		right,
	},
}

feline.setup({
	components = components,
	theme = catppuccin,
	vi_mode_colors = vi_mode_colors,
})
