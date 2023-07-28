require'cmp'.register_source('confluence_vimwiki', require'cmp-confluence-vimwiki'.new(function(id, title, space)
  return '[['..id..'|'..title ..']]'
end))
