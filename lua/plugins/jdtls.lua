return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  config = function()
    local config = {
      cmd = { "jdtls" },
      root_dir = vim.fs.dirname(
        vim.fs.find({ "pom.xml", "build.gradle", ".git" }, { upward = true })[1]
      ),
      settings = {
        java = {
          configuration = {
            runtimes = {
              { name = "JavaSE-21", path = vim.fn.expand("~/.sdkman/candidates/java/current") },
            },
          },
        },
      },
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function()
        require("jdtls").start_or_attach(config)
      end,
    })
  end,
}
