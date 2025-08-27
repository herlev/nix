{ lib, rustPlatform, fetchFromGitHub }:
rustPlatform.buildRustPackage rec {
  pname = "hypr-tools";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "herlev";
    repo = pname;
    rev = "a7bb6fccabbe048785aad717f1af8dcfcef54a2e";
    sha256 = "sha256-5N8hw2p/PuzwLdonxXmfSW7BnobivjjzldzKjrd5s2U=";
  };

  cargoHash = "sha256-i02VelcXVW4NJKmIb4vIreZVK1a4DosZeMOn2hum8Cc=";

  meta = with lib; {
    description = "";
    homepage = "https://github.com/herlev/hypr-tools";
    platforms = platforms.unix;
  };
}
