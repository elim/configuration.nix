{ pkgs, ... }:

let
  cica = pkgs.callPackage ./packages/cica.nix { };
in
{
  # https://nixos.wiki/wiki/Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      cica

      (google-fonts.override {
        fonts = [
          "BIZUDGothic"
          "BIZUDMincho"
        ];
      })

      fira-code
      fira-code-symbols
      fira-mono
      libertine

      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
    ];

    fontconfig = {
      defaultFonts = {
        serif = [
          "Linux Libertine"
          "BIZ UDMincho"
          "Noto Serif"
          "Noto Serif CJK JP"
        ];
        sansSerif = [
          "Fira Code"
          "BIZ UDGothic"
          "Noto Sans"
          "Noto Sans CJK JP"
        ];
        monospace = [
          "Fira Code"
          "Noto Sans Mono"
          "Noto Sans Mono CJK JP"
        ];
      };
    };
  };
}
