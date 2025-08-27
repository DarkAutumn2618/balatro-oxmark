OXMARK.ui.blind_ui = {}


function OXMARK.ui.blind_ui.create_UIBox_blind_oxmark_popup(blind)
    if not G.localization.descriptions.Oxmark[blind.key] then return nil end

    local desc_nodes = {}
    localize({type='descriptions', set = 'Oxmark', key = blind.key,
        nodes = desc_nodes,
    })

    ---@type UINode|nil
    local unlock = nil
    if G.localization.descriptions.Oxmark[blind.key].unlock then
        local unlock_nodes = {}
        localize({type='unlocks', set = 'Oxmark', key = blind.key,
            nodes = unlock_nodes,
        })
        unlock = desc_from_rows(unlock_nodes)
        for _, n in ipairs(unlock.nodes[1].nodes) do
            n.config.align = "cl"
        end
    end

    return {n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR, instance_type = 'POPUP'}, nodes={
        {n=G.UIT.C, align = "cm", nodes={
            {n=G.UIT.R, config={padding = 0.05, r = 0.12, colour = lighten(G.C.JOKER_GREY, 0.5), emboss = 0.07}, nodes={
                {n=G.UIT.R, config={align = "cm", padding = 0.07, r = 0.1, colour = adjust_alpha(darken(G.C.BLACK, 0.1), 0.8)}, nodes={
                        name_from_rows(localize({type = 'name', set = 'Oxmark', key = blind.key, nodes = {}}), nil),
                        desc_from_rows(desc_nodes),
                        unlock,
                    },
                }
            }}
        }},
    }}
end
