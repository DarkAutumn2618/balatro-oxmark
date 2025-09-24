---@return { label: string, tab_definition_function: fun(): UINode }
function OXMARK.ui.alphabet_tab()
    return {
        label = localize("oxmark_b_alphabet_tab"),
        tab_definition_function = function()
            ---@type SMODS.Blind[][]
            local blind_matrix = { {}, {} }
            local row_size = #blind_matrix
            local col_size = math.ceil(#OXMARK.content.alphabet_blinds/row_size)

            for i, blind_key in ipairs(OXMARK.content.alphabet_blinds) do
                local col_index = math.floor((i-1)/col_size)+1
                local row_index = ((i-1) % col_size)+1

                ---@type SMODS.Blind
                local blind = G.P_BLINDS[blind_key]
                local discovered = true --blind.discovered

                local temp_blind = AnimatedSprite(0,0,0.66,0.66,
                    discovered and G.ANIMATION_ATLAS[blind.atlas] or G.ANIMATION_ATLAS["blind_chips"],
                    discovered and blind.pos or G.b_undiscovered.pos)
                temp_blind:define_draw_steps({ {shader = "dissolve", shadow_height = 0.05}, {shader = "dissolve"} })
                temp_blind.float = true
                temp_blind.states.hover.can = true
                temp_blind.states.drag.can = false
                temp_blind.states.collide.can = true
                temp_blind.config = {blind = blind, force_focus = true}
                temp_blind.hover = function()
                    if not G.CONTROLLER.dragging.target or G.CONTROLLER.using_touch then
                        if not temp_blind.hovering and temp_blind.states.visible then
                            temp_blind.hovering = true
                            temp_blind.hover_tilt = 3
                            temp_blind:juice_up(0.05, 0.02)
                            play_sound("chips1", math.random()*0.1 + 0.55, 0.12)


                            oxmark_popup = OXMARK.ui.blind_ui.create_UIBox_blind_oxmark_popup(blind)
                            oxmark_popup = oxmark_popup.nodes[1].nodes[1]
                            info_boxes = { OXMARK.overrides.create_UIBox_blind_popup_original(blind, blind.discovered) }
                            temp_blind.config.h_popup = {n=G.UIT.ROOT, config = {align = "cm", colour = G.C.CLEAR, instance_type = "POPUP"}, nodes={
                                {n=G.UIT.C, config={align = "cm", func = "show_infotip", object = Moveable(),ref_table = next(info_boxes) and info_boxes or nil}, nodes={
                                    oxmark_popup,
                                }},
                            }}
                            temp_blind.config.h_popup_config = {align=temp_blind.T.y > G.ROOM.T.h/2 and "tm" or "bm", offset = {x=0,y=temp_blind.T.y > G.ROOM.T.h/2 and -0.1 or 0.1}, parent = temp_blind}

                            Node.hover(temp_blind)
                        end
                    end
                    temp_blind.stop_hover = function() temp_blind.hovering = false; Node.stop_hover(temp_blind); temp_blind.hover_tilt = 0 end
                end

                -- Each line in the localization should turn into a new column
                -- But for now there is only one column
                --- @type UINode[][]
                local info_cols = {}
                localize({type="descriptions", set = "Oxmark_Alphabet", key = blind_key, vars = {}, default_col = G.C.UI.TEXT_LIGHT, nodes = info_cols})

                ---@type UINode
                local blind_box = {n=G.UIT.R, config={ outline = 1 }, nodes = {
                    {n=G.UIT.C, config={ padding = 0.05 }, nodes = {
                        {n=G.UIT.O, config={object = temp_blind, focus_with_object = true}},
                    }},
                    {n=G.UIT.C, config={ align = "cl", padding = 0.1 }, nodes = {
                        {n=G.UIT.R, config={ align = "cl" }, nodes=info_cols[1]}
                    }},
                }}

                blind_matrix[col_index][row_index] = blind_box
            end


            return {n=G.UIT.ROOT, config={ emboss = 0.05, minh = 6, r = 0.1, minw = 6, align = "tm", padding = 0.2, colour = G.C.BLACK }, nodes={
                {n=G.UIT.R, config={ padding = 0.2 }, nodes = {
                    {n=G.UIT.C, config={ outline = 1 }, nodes = blind_matrix[1]},
                    {n=G.UIT.C, config={ outline = 1 }, nodes = blind_matrix[2]},
                }},
            }}
        end,
    }
end
