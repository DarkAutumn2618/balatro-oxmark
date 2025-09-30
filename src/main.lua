OXMARK = {
    mod = SMODS.current_mod,
    -- Submodules
    ui = {},
    overrides = {},
}
assert(SMODS.load_file("src/api.lua"))()
assert(SMODS.load_file("src/ui/alphabet_tab.lua"))()
assert(SMODS.load_file("src/ui/blind_ui.lua"))()
assert(SMODS.load_file("src/ui/config_tab.lua"))()
assert(SMODS.load_file("src/ui/mod_custom_ui.lua"))()
assert(SMODS.load_file("src/ui/ui.lua"))()
assert(SMODS.load_file("src/content.lua"))()
assert(SMODS.load_file("src/overrides.lua"))()

SMODS.current_mod.config_tab = OXMARK.ui.config_tab
SMODS.current_mod.description_loc_vars = OXMARK.ui.description_loc_vars
SMODS.current_mod.custom_ui = OXMARK.ui.mod_custom_ui

function SMODS.current_mod.extra_tabs()
    return {
        OXMARK.ui.alphabet_tab(),
    }
end

SMODS.Atlas({ key = "modicon", atlas_table = "ANIMATION_ATLAS", path = "modicon.png", px = 34, py = 34, frames = 42 })
