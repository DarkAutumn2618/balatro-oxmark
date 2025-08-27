OXMARK.ui.blind_ui = {}


function OXMARK.ui.blind_ui.create_UIBox_blind_oxmark_popup(blind)
    if not G.localization.descriptions.Oxmark[blind.key] then return nil end

    local loc_vars = {
        colours = {
            blind.boss_colour,
        },
    }
    if (OXMARK.api.Oxmarks[blind.key] or {}).loc_vars then loc_vars = OXMARK.api.Oxmarks[blind.key].loc_vars(blind, loc_vars) end

    local parts = { name_node = nil, desc_node = nil, unlock_node = nil }

    parts.name_node = name_from_rows(localize({type = 'name', set = 'Oxmark', key = blind.key, vars = loc_vars, nodes = {}}), nil)

    local desc_nodes = {}
    localize({type='descriptions', set = 'Oxmark', key = blind.key, vars = loc_vars, nodes = desc_nodes})
    parts.desc_node = desc_from_rows(desc_nodes)

    parts.unlock_node = nil
    if G.localization.descriptions.Oxmark[blind.key].unlock then
        local unlock_nodes = {}
        localize({type='unlocks', set = 'Oxmark', key = blind.key, vars = loc_vars, nodes = unlock_nodes})
        parts.unlock_node = desc_from_rows(unlock_nodes)
    end

    local full_ui_node = {n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR, instance_type = 'POPUP'}, nodes={
        {n=G.UIT.C, align = "cm", nodes={
            {n=G.UIT.R, config={padding = 0.05, r = 0.12, colour = lighten(G.C.JOKER_GREY, 0.5), emboss = 0.07}, nodes={
                {n=G.UIT.R, config={align = "cm", padding = 0.07, r = 0.1, colour = adjust_alpha(darken(G.C.BLACK, 0.1), 0.8)}, nodes={
                        parts.name_node,
                        parts.desc_node,
                        parts.unlock_node,
                    },
                }
            }}
        }},
    }}

    if (OXMARK.api.Oxmarks[blind.key] or {}).generate_ui then
        local result = OXMARK.api.Oxmarks[blind.key].generate_ui(blind, full_ui_node, parts)
        if result ~= true then full_ui_node = result end
    end

    return full_ui_node
end
