# TODO

- [ ] Come up with a better way to work with nvim and cursor at the same time. I need a command that refreshing all open buffers when i switch back to nvim. i also need a command that applies formatting to all open buffers when i do `:wall`.
- [ ] Update docs for all packs 
- [ ] Move nvim-tree keymap config from init.lua to its pack config
- [ ] Move which-key config from init.lua to its pack config
- [ ] Move helptags autogen code from init.lua to a new pack (doc management)
- [ ] Deal with missing deps for CopilotChat (see checkhealth for this plugin) 
- [ ] come up with a way to detect and fix mapping conflicts

# Done

- [x] get typescript and tsx motions working
- [x] Sometimes the <Leader>oi mapping isn't available, even when the related command is. 
- [x] Add code to the installer and dockerfile to pre-install needed treesitter parsers