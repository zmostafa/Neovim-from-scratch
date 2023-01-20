local neogen_ok, neogen = pcall(require, "neogen")
if not neogen_ok then
  return
end

neogen.setup{
  enabled = true,
  input_after_comment = true,
  languages = {
    cpp = {
      template = {
        annotation_convention = "doxygen"
      }
    },
  },
}

local opts = {noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap

keymap("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", opts)
