

local blind_hover_ref = Blind.hover
function Blind:hover()
    if
        (SMODS.Mods.oxmark.config.enable_ingame == OXMARK.config_options.enable_ingame.ENABLED)
        or (
            SMODS.Mods.oxmark.config.enable_ingame == OXMARK.config_options.enable_ingame.ENABLED_SHIFT
            and (G.CONTROLLER.held_keys["lshift"] or G.CONTROLLER.held_keys["rshift"])
        )
    then
        if not G.CONTROLLER.dragging.target or G.CONTROLLER.using_touch then
            if not self.hovering  and self.states.visible and self.children.animatedSprite.states.visible then
                -- self.config.h_popup = OXMARK.ui.blind_ui.create_UIBox_blind_oxmark_popup(self.config.blind)
                -- self.config.h_popup_config = { parent = self, offset = {x=0.1, y=0}, type = "cr" }

                -- Made global so that popup renders over the joker card area instead of under
                local definition = OXMARK.ui.blind_ui.create_UIBox_blind_oxmark_popup(self.config.blind)
                if definition then
                    G.OXMARK_BLIND_H_POPUP = UIBox{
                        definition = definition,
                        config = { instance_type = "POPUP", major = self, parent = nil, align = "cr", offset = {x=0.1,y=0} }
                    }
                    G.OXMARK_BLIND_H_POPUP.attention_text = true -- Required so that the popup renders over the joker card area instead of under
                    G.OXMARK_BLIND_H_POPUP.states.collide.can = false
                    G.OXMARK_BLIND_H_POPUP.states.drag.can = false
                end
            end
        end
    end
    blind_hover_ref(self)
end

local blind_stop_hover_ref = Blind.stop_hover
function Blind.stop_hover(self)
    if G.OXMARK_BLIND_H_POPUP then
        G.OXMARK_BLIND_H_POPUP:remove()
        G.OXMARK_BLIND_H_POPUP = nil
    end
    blind_stop_hover_ref(self)
end


local create_UIBox_blind_popup_ref = create_UIBox_blind_popup
function create_UIBox_blind_popup(blind, discovered, vars)
    if SMODS.Mods.oxmark.config.enable_collection == OXMARK.config_options.enable_collection.ENABLED_SHIFT
        and (G.CONTROLLER.held_keys["lshift"] or G.CONTROLLER.held_keys["rshift"])
    then
        if discovered then
            return OXMARK.ui.blind_ui.create_UIBox_blind_oxmark_popup(blind)
        end
    end

    return create_UIBox_blind_popup_ref(blind, discovered, vars)
end
