-- return {
--   cmd = { "jetls", "serve" },
--   autostart = true,
--   filetypes = { "julia" },
--   root_markers = { "Project.toml" },
-- }
return {
  cmd = {
    "julia",
    "--startup-file=no",
    "--history-file=no",
    "--project=~/.julia/dev/JETLS", -- your release-based checkout
    "-m",
    "JETLS",
    "serve",
  },
  autostart = true,
  filetypes = { "julia" },
  root_markers = { "Project.toml" },
}
