local helpers = {}

-- used to grab the current available python path
helpers.get_python_path = function()
  if vim.fn.executable("python3") == 1 then
    return vim.fn.exepath("python3")
  end
  return vim.fn.exepath("python")
end

-- prioritize pyright hover
helpers.get_on_attach_ruff = function(client, _)
  client.server_capabilities.hoverProvider = false
end

-- compares based on two or more underscores
helpers.get_compare_underscore = function(a, b)
  local _, us1 = a.completion_item.label:find("^_+")
  local _, us2 = b.completion_item.label:find("^_+")
  us1 = us1 or 0
  us2 = us2 or 0
  if us1 > us2 then
    return false
  elseif us1 < us2 then
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
