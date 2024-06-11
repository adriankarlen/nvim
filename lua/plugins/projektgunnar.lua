return {
  "JesperLundberg/projektgunnar.nvim",
  dependencies = {
    "echasnovski/mini.pick",
  },
  event = "VeryLazy",
  keys = {
    { "<leader>pap", "<cmd>AddNugetToProject<cr>", desc = "projektgunnar - add nuget packages to project" },
    { "<leader>par", "<cmd>AddProjectToProject<cr>", desc = "projektgunnar - add project reference to other project" },
    { "<leader>pup", "<cmd>UpdateNugetsInProject<cr>", desc = "projektgunnar - update packages in project" },
    { "<leader>pus", "<cmd>UpdateNugetsInSolution<cr>", desc = "projektgunnar - update packages in solution" },
  },
}
