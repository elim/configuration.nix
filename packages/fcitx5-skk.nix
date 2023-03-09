# copied from https://github.com/nyarla/nixos-configurations/blob/bcf5e63bdad961f23a7a58892e42980c5dd8750d/pkgs/fcitx5-skk/default.nix
# copied from https://github.com/NixOS/nixpkgs/issues/167872 and modified
{ lib
, stdenv
, fetchFromGitHub
, fcitx5
, fcitx5-qt
, cmake
, extra-cmake-modules
, gettext
, gcc
, pkg-config
, qt5
, libskk
, skk-dicts
, enableQt ? true
}:

stdenv.mkDerivation rec {
  pname = "fcitx5-skk";
  version = "5.0.13";

  src = fetchFromGitHub {
    owner = "fcitx";
    repo = pname;
    rev = version;
    sha256 = "sha256-INY7Wkv4fYZBsX9CDe2zT9WWZbd0mDHvk8le/9u/03I=";
  };

  cmakeFlags = [
    "-DENABLE_QT=${toString enableQt}"
    "-DSKK_DEFAULT_PATH=${skk-dicts}/share/SKK-JISYO.combined"
  ];

  nativeBuildInputs = [ cmake extra-cmake-modules gettext gcc pkg-config ];

  buildInputs = [ libskk fcitx5 fcitx5-qt ] ++ lib.optional enableQt qt5.full;

  meta = with lib; {
    description =
      "fcitx5-skk is an input method engine for Fcitx5, which uses libskk as its backend.";
    homepage = "https://github.com/fcitx/fcitx5-skk";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}