command CphReceive lua require 'receive'.pass()
command -nargs=* CphTest lua require 'test_wrapper'.wrapper(<f-args>)
command -nargs=* CphRetest lua require 'test_wrapper'.retest_wrapper(<f-args>)
command -nargs=+ CphDelete lua require 'modify_tc'.deletetc(<f-args>)
command -nargs=1 CphEdit lua require 'modify_tc'.edittc(<f-args>)
highlight Underlined gui=underline cterm=underline
