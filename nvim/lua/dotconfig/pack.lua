local M = {}

function M.prune()
  local plugins = vim.pack.get(nil, { info = false })
  local stale = vim
    .iter(plugins)
    :filter(function(p)
      return not p.active
    end)
    :map(function(p)
      return p.spec.name
    end)
    :totable()
  -- if init.lua failed before vim.pack.add(), nothing is active and every plugin would look stale
  if #stale == 0 or #stale == #plugins then
    return
  end
  vim.pack.del(stale)
end

return M
