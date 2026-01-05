{ ... }:
{
  enable = true;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;
  globals = {
    leader = " ";
  };
  clipboard = {
    register = "unnamedplus";
    clipboard.providers.wl-copy.enable = true;
  };
  lsp = {
    inlayHints.enable = true;
    keymaps = [
      {
        key = "gd";
	lspBufAction = "definition";
      }
      { 
        key = "gD";
	lspBufAction = "references";
      }
      {
        key = "gt";
        lspBufAction = "type_definition";
      }
      {
        key = "gi";
	lspBufAction = "implementation";
      }
      {
        key = "K";
        lspBufAction = "hover";
      }
    ];
    lsp.servers = {
      nil_ls = {
        enable = true;
      };
    };
  };
  colorschemes.catppuccin.enable = true;
  extraConfigLua = ''
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true,
      float = {
        transparent = true,
	solid = false,
      }
    })

    vim.cmd.colorscheme "catppuccin"
  '';
}
