local inlayHints_ok, inlayHints = pcall(require,"lsp-inlayhints")
if not inlayHints_ok then
  return
end
inlayHints.setup()
-- inlayHints.on_attach(client, bufnr)
