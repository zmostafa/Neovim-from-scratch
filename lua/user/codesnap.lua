local codesnap_status_ok, codesnap = pcall(require, "codesnap")

if not codesnap_status_ok then
	return
end

codesnap.setup({
	mac_window_bar = true,
	title = "CodeSnap.nvim",
	code_font_family = "CaskaydiaCove Nerd Font",
	watermark_font_family = "Pacifico",
	watermark = "",
	bg_theme = "default",
	breadcrumbs_separator = "/",
	has_breadcrumbs = true,
})
