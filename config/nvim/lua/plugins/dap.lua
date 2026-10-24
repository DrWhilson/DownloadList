return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    local dap = require "dap"

    dap.adapters.coreclr = {
      type = "executable",
      command = vim.fn.stdpath "data" .. "/mason/bin/netcoredbg",
      args = { "--interpreter=vscode" },
    }

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg (Auto net10.0)",
        request = "launch",
        program = function()
          -- 1. Берем имя текущей папки проекта (обычно совпадает с именем .dll)
          local project_name = vim.fs.basename(vim.fn.getcwd())
          -- 2. Формируем путь до net10.0
          local dll_path = vim.fn.getcwd() .. "/bin/Debug/net10.0/" .. project_name .. ".dll"

          -- 3. Если файл существует, запускаем отладку без вопросов
          if vim.fn.filereadable(dll_path) == 1 then return dll_path end

          -- 4. Если .dll не найдена, показываем окно ввода с подсказкой пути
          return vim.fn.input("DLL not found! Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/net10.0/", "file")
        end,
      },
    }
  end,
}
