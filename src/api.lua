OXMARK.api = {}


---@class OxmarkPopupConfig
---@field loc_vars? fun(blind: table, loc_vars: table): table
---@field generate_ui? fun(blind: table, full_ui_node: UINode, parts: { name_node: UINode, desc_node: UINode, unlock_node: UINode|nil }): UINode|true|nil

---@type { [string]: OxmarkPopupConfig }
OXMARK.api.Oxmarks = {}
