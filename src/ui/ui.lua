---@param e UIElement|{ config: UINode.config }
function G.FUNCS.oxmark_clickable_link(e)
    if ((e.config.tooltip or {}).text or {})[1] then
        local url = e.config.tooltip.text[1].ref_table.value
        love.system.openURL(url)
    end
end
