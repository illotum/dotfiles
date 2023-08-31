vim.filetype.add({
  extension = {
    escript = "erlang",
    recipe  = "markdown",
    config  = { "erlang", { priority = 10 } },
    app     = { "erlang", { priority = 10 } },
    conf    = { "systemd", { priority = 10 } }
  },
})
