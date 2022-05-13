function! utils#IsInGitRepo()
    call system('git rev-list -1 HEAD >/dev/null 2>&1')
    return v:shell_error == 0
endfunction

