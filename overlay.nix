final: prev:
{
  # this key should be the same as the simpleFlake name attribute.
  caterpillar = rec {
    defaultPackage = final.callPackage ./. {};
    devShell = final.mkShell.override {stdenv = final.llvmPackages.stdenv;} {
      buildInputs = [defaultPackage];
      nativeBuildInputs = [final.cmake final.ninja];
    };
  };
}
