{llvmPackages, fetchFromGitHub, cmake, ninja, fmt, nlohmann_json
,pkg-config}:
let
  stdenv = llvmPackages.stdenv;
in
stdenv.mkDerivation {
  pname = "caterpillar";
  version = "0.0.1";
  src = ./.;
  nativeBuildInputs = [ cmake ninja pkg-config ];
  propagatedBuildInputs = [ nlohmann_json fmt ];
  cmakeFlags = [
    "-DCATERPILLAR_TEST=OFF"
  ];
}
