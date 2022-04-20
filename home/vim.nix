{ pkgs, ... }:

let
  inherit (pkgs) fetchFromGitHub vimUtils;
  inherit (vimUtils) buildVimPlugin;
  customPlugins = {
    ryuki-snippets = buildVimPlugin {
      name = "ryuki-snippets";
      src = fetchFromGitHub {
        owner = "iRyukizo";
        repo = "snippets";
        rev = "7ce071c554c56e4f619bc74a26fe8057cf34940b";
        sha256 = "2soBRVsKAf/11SMsm6TiALTLJM+VhUdbDL5FfDr2fYI=";
      };
    };
    tiger-syntax = buildVimPlugin {
      name = "tiger-syntax";
      src = fetchFromGitHub {
        owner = "iRyukizo";
        repo = "tiger-syntax";
        rev = "c7304360d9e2914eea19bb9a3b7805a7ab171a6d";
        sha256 = "IWdEYadkWOKtuE+dueV9qSbXWGE5K/d6rkMNkKvZXZU=";
      };
    };
  };
in
{
  programs.vim = {
    enable = true;
    packageConfigurable = pkgs.vim_configurable.override {
      #      python = pkgs.python36Full;
      perl = pkgs.perl;
    };
    plugins = with pkgs.vimPlugins // customPlugins; [
      nerdtree
      solarized
      fzfWrapper
      fzf-vim
      ryuki-snippets
      tiger-syntax
      UltiSnips
      vim-airline
      vim-airline-themes
      vim-clang-format
      vim-gitgutter
      vim-nix
      vim-operator-user
      vim-snippets
    ];
    settings = {
      number = true;
      expandtab = true;
      background = "light";
      mouse = "a";
    };
    extraConfig = ''
      let mapleader = ","
      set autoindent
      set smartindent
      set smarttab
      set cc=80
      set cursorline
      set hlsearch
      set list
      set ruler

      set tabstop=8
      set shiftwidth=4
      set softtabstop=4

      scriptencoding utf-8
      set encoding=utf8

      " set listchars=tab:>-,eol:¬,trail:-
      set listchars=tab:»·,trail:·
      highlight SpecialKey ctermfg=7 ctermbg=7 guifg=Brown

      set nobackup
      set nowb
      set noswapfile

      if has("syntax")
        syntax on
      endif

      filetype on
      filetype plugin on
      filetype indent on

      colorscheme solarized
      hi clear SignColumn
      let g:solarized_termcolors = 256
      let g:solarized_termtrans = 1
      " let g:solarized_bold = 0
      let g:solarized_visibility = "low"
      " ------------------------------------------------

      set t_Co=256
      let g:airline_powerline_fonts = 1
      let g:airline_theme='solarized'
      let g:airline#extensions#whitespace#show_message = 0
      set laststatus=1

      " Weird bug where plugins are not loaded correctly, obliged to manually
      " update the `runtimepath`, must create an issue on home-manager.
      set runtimepath^=${pkgs.vimPlugins.vim-airline}
      let g:airline_section_z = airline#section#create(["\uE0A1" . '%{line(".")}' . "\uE0A3" . '%{col(".")}'])
      set guifont=Iosevka\ Nerd\ Font\ 10
      map <Leader>h :noh <CR>

      " toggle NerdTree
      map <C-n> :NERDTreeToggle <CR>
      " Toggle FZF
      nmap <Leader>t :FZF<CR>
      nmap <Leader><space> :FZF<CR>

      " Set Clang-Format
      autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
      autocmd FileType c,cpp set comments+=s0:/*,mb:**,ex:*/

      " Set ultisnips triggers
      " let g:UltiSnipsExpandTrigger="<tab>"
      " let g:UltiSnipsJumpForwardTrigger="<tab>"
      " let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
      " let g:UltiSnipsListSnippets="<c-tab>"
      " let g:snips_author="iRyukizo"
    '';
  };
}
