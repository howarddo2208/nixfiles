if has('nvim') && executable('nvr')
  " let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
  vim.env.GIT_EDITOR = "nvr --remote-tab-wait +'set bufhidden=delete'"
endif
