{ lib, rustPlatform, fetchFromGitHub, gcc, cargo, udev, pkg-config }:
rustPlatform.buildRustPackage rec {
  pname = "kbct";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "samvel1024";
    repo = pname;
    rev = "c0d96e480e1b9b1596b0ca88e938a8f38d48a32f";
    sha256 = "sha256-ioJPSJwhcEq2+kzMkS/AF53ahbiVIoAKGIetTTt+x98=";
  };

  cargoHash = "sha256-+dzBPzE9DCrkTRavJTDUWacfSFVvaKSEQtHQ+7fbiC0=";
  nativeBuildInputs = [ gcc cargo pkg-config ];
  buildInputs = [udev];

  meta = with lib; {
    description = "Keyboard keycode mapping utility for Linux supporting layered configuration";
    homepage = "https://github.com/samvel1024/kbct";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
