OXMARK.ui.blind_ui = {}


function OXMARK.ui.blind_ui.create_UIBox_blind_oxmark_popup(blind)
    if not G.localization.descriptions.Oxmarks[blind.key] then return nil end

    local loc_txt = {}
    localize({type='descriptions', set = 'Oxmarks', key = blind.key,
        vars = {
            colours = {
                G.C.UI.TEXT_DARK,
                loc_colour("purple"),
                loc_colour("blue"),
                loc_colour("green"),
                loc_colour("attention"),
            },
        },
        nodes = loc_txt,
    })



    return {n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR, instance_type = 'POPUP'}, nodes={
        {n=G.UIT.C, nodes={
            {n=G.UIT.R, config={padding = 0.05, r = 0.12, colour = lighten(G.C.JOKER_GREY, 0.5), emboss = 0.07}, nodes={
                {n=G.UIT.R, config={align = "cm", padding = 0.07, r = 0.1, colour = adjust_alpha(darken(G.C.BLACK, 0.1), 0.8)}, nodes={
                    name_from_rows(localize({type = 'name', set = 'Oxmarks', key = blind.key, nodes = {}}), nil),
                    desc_from_rows(loc_txt),
                }}
            }}
        }},
    }}
end
