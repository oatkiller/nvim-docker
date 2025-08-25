# Update Aug 25 2025

Bugs:

* When typing `:grep pattern **` (to begin selecting files) it freezes. Whats the correct way to use this? At a minimum, I need to be able to type commands on the command line without it freezing. I didn't run that command, just typed ** and on the second *, nvim froze. I'm sure its trying to load every single file or something crazy. Maybe the answer is to not use :grep? can :FZF or :FZFLua or something do this already?
* when opening a new file for the first time, if I open it via some sort of picker, e.g. grep, copen, or fzflua, it gives this error:

```
[Fzf-lua] ':e packages/prequel-log-viewer/package.json' failed: vim/_editor.lua:0: nvim_exec2()[1]..BufReadPost Autocommands for "*": Vim(append):Error executing lua callback: Vim:E484: Can't open file v:true
stack traceback:
        [C]: in function 'readfile'
        ...k/none-ls-config/start/none-ls-config/plugin/none_ls.lua:24: in function 'condition'
        .../pack/none-ls/start/none-ls.nvim/lua/null-ls/sources.lua:81: in function 'try_register'
        ...im/pack/none-ls/start/none-ls.nvim/lua/null-ls/state.lua:86: in function <...im/pack/none-ls/start/none-ls.nvim/lua/null-ls/state.lua:85>
        vim/shared.lua: in function 'tbl_map'
        ...im/pack/none-ls/start/none-ls.nvim/lua/null-ls/state.lua:85: in function 'register_conditional_sources'
        ...m/pack/none-ls/start/none-ls.nvim/lua/null-ls/client.lua:289: in function <...m/pack/none-ls/start/none-ls.nvim/lua/null-ls/client.lua:288>
        [C]: in function 'resume'
LSP [jsonls] attached to buffer 1
```

Also sometimes null-ls flips out. Whats this for anyway? eslint? i'm not using ES anymore except in react code. And I'm moving away from react in many places. I should be able to configure null-ls for only .tsx files.

# TODOs are now managed in the `tasks/` directory.

All outstanding work items have been converted into individual markdown files in the `tasks/` directory.

Please refer to [`tasks_list.md`](mdc:tasks_list.md) for a complete, prioritized, and categorized list of all tasks and their dependencies.