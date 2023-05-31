final: prev:
{
  # this key should be the same as the simpleFlake name attribute.
  caterpillar = rec {
    defaultPackage = final.callPackage ./. {};
    devShell = final.mkShell{
      buildInputs = [defaultPackage];
      nativeBuildInputs = [final.cmake final.ninja];
    };
  };
}
