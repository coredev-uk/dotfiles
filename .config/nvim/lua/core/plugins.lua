local lazy = {}

function lazy.bootstrap()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)
end

function lazy.load_plugins()
  for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath('config') .. '/lua/plugins', [[v:val =~ '\.lua$']])) do
    require('plugins.' .. file:gsub('%.lua$', ''))
  end
  require('lazy').setup({
    lazy.plugs,
  })
end

function lazy.load(plugin)
  if not lazy.plugs then
    lazy.plugs = {}
  end
  for k,v in ipairs(plugin) do
    table.insert(lazy.plugs, v)
 end 
end

return lazy
