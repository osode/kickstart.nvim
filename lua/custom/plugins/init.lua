-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G', 'Gdiffsplit', 'Gvdiffsplit', 'Gread', 'Gwrite', 'Ggrep', 'GMove', 'GDelete', 'GBrowse' },
    keys = {
      { '<leader>gs', '<cmd>Git<cr>', desc = 'Git: Status (fugitive)' },
      { '<leader>gD', '<cmd>Gvdiffsplit<cr>', desc = 'Git: Diff split (fugitive)' },
      { '<leader>gb', '<cmd>Git blame<cr>', desc = 'Git: Blame' },
      { '<leader>gl', '<cmd>Git log --oneline<cr>', desc = 'Git: Log' },
      -- Visual mode diffput/diffget for line-by-line staging
      { 'dp', ':diffput<cr>', mode = 'v', desc = 'Diff: Put selection (stage)' },
      { 'do', ':diffget<cr>', mode = 'v', desc = 'Diff: Obtain selection (restore)' },
    },
  },
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diffview: Open' },
      {
        '<leader>gm',
        function()
          -- Find merge-base to show only changes on current branch
          local base = vim.fn.system('git merge-base origin/main HEAD'):gsub('%s+', '')
          if vim.v.shell_error == 0 then
            vim.cmd('DiffviewOpen ' .. base .. '...HEAD')
          else
            -- Fallback to master if main doesn't exist
            base = vim.fn.system('git merge-base origin/master HEAD'):gsub('%s+', '')
            if vim.v.shell_error == 0 then
              vim.cmd('DiffviewOpen ' .. base .. '...HEAD')
            else
              vim.notify('Could not find merge-base with main or master', vim.log.levels.ERROR)
            end
          end
        end,
        desc = 'Diffview: Branch changes',
      },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Diffview: File history' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = 'Diffview: Branch history' },
      { '<leader>gc', '<cmd>DiffviewClose<cr>', desc = 'Diffview: Close' },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = {
          layout = 'diff2_horizontal',
        },
      },
    },
  },
}
