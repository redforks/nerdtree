" ============================================================================
" Contain my (RedForks) custom menu item.
"
" ============================================================================

if exists("g:loaded_nerdtree_my_menu")
    finish
endif
let g:loaded_nerdtree_my_menu = 1

call NERDTreeAddMenuItem({'text': 'Git (r)emove current node', 'shortcut': 'r', 'callback': 'NERDTreeGitRemoveCurrent'})

function! NERDTreeGitRemoveCurrent()
    let currentNode = g:NERDTreeFileNode.GetSelected()

    if currentNode.path.isDirectory
      echo "Can not delete directory\n"
      return
    endif

    exec "!git rm " . fnameescape(currentNode.path.str())
    call currentNode.parent.removeChild(currentNode)
    call NERDTreeRender()
    let bufnum = bufnr("^".currentNode.path.str()."$")
    exec "bwipeout! " . bufnum

endfunction

