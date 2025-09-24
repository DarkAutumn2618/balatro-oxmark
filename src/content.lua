OXMARK.content = {}

OXMARK.content.alphabet_blinds = {
    "bl_ox", "bl_house", "bl_club", "bl_fish", "bl_window", "bl_hook", "bl_manacle", "bl_wall", "bl_wheel", "bl_arm", "bl_psychic",
    "bl_goad", "bl_water", "bl_serpent", "bl_pillar", "bl_eye", "bl_mouth", "bl_plant", "bl_needle", "bl_head", "bl_tooth", "bl_mark",
}


---@type fun(blind: table, full_ui_node: UINode, parts: { name_node: UINode, desc_node: UINode, unlock_node: UINode|nil }): UINode|true|nil
function OXMARK.content.vanilla_blind_generate_ui(blind, full_ui_node, parts)
    if parts.unlock_node then
        for _, n in ipairs(parts.unlock_node.nodes[1].nodes) do
            n.config.align = "cl"
        end
    end

    return true
end


for _, blind_key in ipairs(OXMARK.content.alphabet_blinds) do
    OXMARK.api.Oxmarks[blind_key] = { generate_ui = OXMARK.content.vanilla_blind_generate_ui }
end

OXMARK.api.Oxmarks["bl_flint"] = {
    loc_vars = function(blind, loc_vars)
        loc_vars[1] = localize("k_unknown")
        return loc_vars
    end
}
