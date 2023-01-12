local M = {}

local inlayHints_ok, inlayHints = pcall(require,"lsp-inlayhints")
if not inlayHints_ok then
  return
end

inlayHints.setup()

M.on_attach = function (client, bufnr)
  inlayHints.on_attach(client,bufnr)
end

return M
