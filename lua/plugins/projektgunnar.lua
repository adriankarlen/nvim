return {
  "JesperLundberg/projektgunnar.nvim",
  dependencies = {
    "echasnovski/mini.pick",
  },
  event = "VeryLazy",
  keys = {
    { "<leader>pna", "<cmd>AddNugetToProject<cr>", desc = "add nuget packages to project" },
    { "<leader>pnp", "<cmd>AddProjectToProject<cr>", desc = "add project reference to other project" },
    { "<leader>pnu", "<cmd>UpdateNugetsInProject<cr>", desc = "update packages in project" },
    { "<leader>pnU", "<cmd>UpdateNugetsInSolution<cr>", desc = "update packages in solution" },
  },
}
