local exclude = {
  ".git", ".DS_Store", ".idea", ".vscode",
  "build/", "devel/", "install/", "log/", "*.log", "cache/"
}
local function ex() return table.concat(vim.tbl_map(function(i)
  return '--exclude="' .. i .. '"' end, exclude), " ") end

vim.api.nvim_create_user_command("RsyncUp",
  '!rsync -avz --progress ' .. ex() ..
  ' ~/catkin_ws/src/ rdv@host:/home/rdv/path/', {})

vim.api.nvim_create_user_command("RsyncDown",
  '!rsync -avz --progress ' .. ex() ..
  ' rdv@host:/home/rdv/path/ ~/catkin_ws/src/', {})


-- let g:rsync_exclude = [
--     \ ".git",
--     \ ".DS_Store",
--     \ ".idea",
--     \ ".vscode",
--     \ 'build/',
--     \ 'devel/',
--     \ 'install/',
--     \ 'log/',
--     \ '*.log',
--     \ 'cache/'
--     \]
--
-- " 리스트를 --exclude 옵션 문자열로 변환
-- function! RsyncExclude()
--   let l:exclude_str = ''
--   for item in g:rsync_exclude
--     let l:exclude_str .= ' --exclude="' . item . '"'
--   endfor
--   return l:exclude_str
-- endfunction
--
-- " 로컬 → 원격으로 동기화
-- command! RsyncUp execute '!rsync -avz --progress' . RsyncExclude() . ' /home/rdv/catkin_ws/src/ rdv@host:/home/rdv/path/'
-- " command! RsyncUp execute '!rsync -avz -e "ssh -i ~/.ssh/id_rsa" --progress' . RsyncExclude() . ' ./ user@host:/path/to/remote/'
-- " 원격 → 로컬로 동기화
-- command! RsyncDown execute '!rsync -avz --progress' . RsyncExclude() . ' rdv@host:/home/rdv/path/ /home/rdv/catkin_ws/src/'
-- " command! RsyncDown execute '!rsync -avz -e "ssh -i ~/.ssh/id_rsa" --progress' . RsyncExclude() . ' user@host:/path/to/remote/ ./'
--
-- nnoremap <leader>ru :echo "Rsync UP? (y/n)" \| call ConfirmRsync('up')<CR>
-- nnoremap <leader>rd :echo "Rsync DOWN? (y/n)" \| call ConfirmRsync('down')<CR>
--
-- function! ConfirmRsync(direction)
--   let choice = input("Proceed with rsync " . a:direction . "? (y/n): ")
--   if choice == 'y'
--     if a:direction == 'up'
--       execute ':RsyncUp'
--     else
--       execute ':RsyncDown'
--     endif
--   else
--     echo "Rsync canceled"
--   endif
-- endfunction

