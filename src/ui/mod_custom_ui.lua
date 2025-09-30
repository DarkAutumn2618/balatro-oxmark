---@param self Mod|table
function OXMARK.ui.description_loc_vars(self)
    return {
        shadow = true,
        scale = (0.75 * 0.5) / 0.32, -- desc tab text scale & undo scaling from desc_from_rows
        text_colour = G.C.UI.TEXT_LIGHT,
        background_colour = G.C.CLEAR,
    }
end

---@param nodes UINode[]
function OXMARK.ui.mod_custom_ui(nodes)
    local desc = nodes[2] -- description node

    -- undo styling from desc_from_rows
    desc.config.r = nil
    desc.config.padding = 0.2 - 0.07 -- original desc tab padding with compensation from later
    desc.config.minw = nil
    desc.config.minh = nil
    desc.config.emboss = nil
    desc.config.filler = nil
    desc.config.align = "tl"

    desc.nodes[1].config.align = "tl"
    desc.nodes[1].config.padding = 0.07 -- needed to get the lines to match original desc tab
    for _, n in ipairs(desc.nodes[1].nodes) do
        n.config.align = "tl"
    end


    ---@type UINode
    local sources = {n=G.UIT.R, config={align = "tl", padding = 0.2 - 0.07}, nodes={
        {n=G.UIT.R, config={align = "tl", padding = 0.07}, nodes={
            {n=G.UIT.R, config={align = "tl"}, nodes={
                {n = G.UIT.T, config = {shadow = true, scale = 0.75 * 0.5, colour = G.C.UI.TEXT_LIGHT, text = localize("oxmark_desc_sources") }},
            }},
        }},
    }}

    local source_links = sources.nodes[1].nodes
    local source_link_labels = localize("oxmark_desc_source_link_labels")
    local source_link_urls= localize("oxmark_desc_source_link_urls")
    local clickable_link_title = localize("oxmark_clickable_link")
    for i, _ in ipairs(source_link_labels) do
        table.insert(source_links, {n=G.UIT.R, config={align = "tl"}, nodes={
            {n = G.UIT.T, config = {shadow = true, scale = 0.75 * 0.5, colour = G.C.BLUE, underline = G.C.BLUE,
                button = "oxmark_clickable_link",
                text = source_link_labels[i],
                tooltip = {
                    title = clickable_link_title,
                    ---@diagnostic disable-next-line: assign-type-mismatch
                    text = { { ref_table = { value = source_link_urls[i] }, ref_value = "value" } },
                },
            }},
        }})
    end

    table.insert(nodes, sources)
end
