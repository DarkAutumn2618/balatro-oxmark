OXMARK = {
    mod = SMODS.current_mod,
    -- Subfolders
    ui = {},
}
assert(SMODS.load_file("src/ui/blind_ui.lua"))()
assert(SMODS.load_file("src/ui/config_tab.lua"))()
assert(SMODS.load_file("src/overrides.lua"))()

SMODS.current_mod.config_tab = OXMARK.ui.config_tab
