{
  plugins.lightline = {
    enable = true;
    settings = {
      colorscheme = "one";
      active = {
        left = [
          [
            "mode"
            "paste"
          ]
          [
            "gitbranch"
            "readonly"
            "filename"
            "modified"
          ]

        ];
        right = [
          [ "lineinfo" ]
          [ "percent" ]
          [
            "fileformat"
            "fileencoding"
            "filetype"
          ]
        ];
      };
    };
  };
}
