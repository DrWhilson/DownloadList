return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
  },
  {
    "rbong/vim-flog",
    cmd = { "Flog", "Flogsplit" },
    dependencies = { "tpope/vim-fugitive" },
  },
}
