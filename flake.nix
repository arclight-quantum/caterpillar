{
  description = "Caterpillar";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.simpleFlake {
      inherit self nixpkgs;
      name = "caterpillar";
      overlay = ./overlay.nix;
    };
}
