local function getline(bufnr, lnum)
  return vim.api.nvim_buf_get_lines(bufnr, lnum-1, lnum, false)[1] or ""
end

vim.filetype.add({
  extension = {
    escript = "erlang",
    recipe  = "markdown",
    config  = { "erlang", { priority = 10 } },
    app     = { "erlang", { priority = 10 } },
	conf    = { "systemd", { priority = 10 } }
	},
})
