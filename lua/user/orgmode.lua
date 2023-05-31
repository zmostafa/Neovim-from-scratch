local orgmode_ok, orgmode = pcall(require, "orgmode")
if not orgmode_ok then
  return
end

local treesitter_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_ok then
  return
end

orgmode.setup_ts_grammar()

treesitter.setup {
    -- If TS highlights are not enabled at all, or disabled via `disable` prop,
    -- highlighting will fallback to default Vim syntax highlighting
    highlight = {
        enable = true,
        -- Required for spellcheck, some LaTex highlights and
        -- code block highlights that do not have ts grammar
        additional_vim_regex_highlighting = { 'org' },
    },
    ensure_installed = { 'org' }, -- Or run :TSUpdate org
}

orgmode.setup({
    org_agenda_files = { '~/Dropbox/org/*', '~/my-orgs/**/*' },
    org_default_notes_file = '~/Dropbox/org/refile.org',
})
