OXMARK = {
    mod = SMODS.current_mod,
    -- Subfolders
    ui = {},
}
assert(SMODS.load_file("src/ui/blind_ui.lua"))()
assert(SMODS.load_file("src/ui/config_tab.lua"))()
assert(SMODS.load_file("src/ui/mod_custom_ui.lua"))()
assert(SMODS.load_file("src/ui/ui.lua"))()
assert(SMODS.load_file("src/overrides.lua"))()

SMODS.current_mod.config_tab = OXMARK.ui.config_tab
SMODS.current_mod.description_loc_vars = OXMARK.ui.description_loc_vars
SMODS.current_mod.custom_ui = OXMARK.ui.mod_custom_ui
