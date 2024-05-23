local helpers = {}

-- common width/height used for ui components
helpers.width = 30
helpers.height = 12

-- used to grab the current available python path
helpers.get_python_path = function()
  if vim.fn.executable("python3") == 1 then
    return vim.fn.exepath("python3")
  end
  return vim.fn.exepath("python")
end

-- disable hover for ruff in favor of pyright
helpers.ruff_lsp_on_attach = function(client, _)
  client.server_capabilities.hoverProvider = false
end

-- sorts completion items with one or more underscores
-- helpful in python especially
helpers.get_cmp_under_comparator = function(entry1, entry2)
  local _, entry1_under = entry1.completion_item.label:find("^_+")
  local _, entry2_under = entry2.completion_item.label:find("^_+")
  entry1_under = entry1_under or 0
  entry2_under = entry2_under or 0
  if entry1_under > entry2_under then
    return false
  elseif entry1_under < entry2_under then
    return true
  end
end

-- used to check if a register is being recorded
helpers.get_reg = function()
  local reg = vim.fn.reg_recording()
  if reg == "" then
    return ""
  end
  return "recording @" .. reg
end

return helpers
