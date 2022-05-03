" lua <<EOF
" require'nvim-treesitter.configs'.setup {
"     ensure_installed = { "cpp", "vim" },
"     highlight = {
"         enable = false
"         },
"     indent = { enable = true },
" }
" EOF
