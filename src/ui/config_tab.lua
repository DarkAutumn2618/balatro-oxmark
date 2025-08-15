OXMARK.config_options = {}

---@enum ConfigOptionEnableIngame
OXMARK.config_options.enable_ingame = {
    DISABLED = 1,
    ENABLED = 2,
    ENABLED_SHIFT = 3,
}

---@enum ConfigOptionEnableCollection
OXMARK.config_options.enable_collection = {
    DISABLED = 1,
    ENABLED_SHIFT = 2,
}


function OXMARK.ui.config_tab()
    return {n=G.UIT.ROOT, config={ emboss = 0.05, minh = 6, r = 0.1, minw = 6, align = "tm", padding = 0.2, colour = G.C.BLACK }, nodes={
        {n=G.UIT.R, nodes = {
            create_option_cycle({
                label = localize("b_oxmark_enable_ingame"),
                w = 5,
                scale = 0.8,
                options = {
                    localize("b_oxmark_enable_ingame_1"),
                    localize("b_oxmark_enable_ingame_2"),
                    localize("b_oxmark_enable_ingame_3"),
                },
                current_option = SMODS.Mods.oxmark.config.enable_ingame,
                opt_callback = "oxmark_config_set_enable_ingame",
            }),
        }},
        {n=G.UIT.R, nodes={
            create_option_cycle({
                label = localize("b_oxmark_enable_collection"),
                w = 5,
                scale = 0.8,
                options = {
                    localize("b_oxmark_enable_collection_1"),
                    localize("b_oxmark_enable_collection_2"),
                },
                current_option = SMODS.Mods.oxmark.config.enable_collection,
                opt_callback = "oxmark_config_set_enable_collection",
            }),
        }},
    }}
end


---@param e OptCallbackPayload
function G.FUNCS.oxmark_config_set_enable_ingame(e)
    SMODS.Mods.oxmark.config.enable_ingame = e.to_key
end

---@param e OptCallbackPayload
function G.FUNCS.oxmark_config_set_enable_collection(e)
    SMODS.Mods.oxmark.config.enable_collection = e.to_key
end
