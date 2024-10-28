{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "vespa-cli";
  version = "8.416.42";
  
  src = fetchFromGitHub {
    owner = "vespa-engine";
    repo = "vespa";
    rev = "v${version}";
    hash = "sha256-XSMY+zZgSYUH1gcK6m8/zIEV50UiKaUjhFle2Dyq0D0=";
  };

  modRoot = "./client/go";
  vendorHash = "sha256-LFcrVGYOFqx9KPf/FCAcYizUxhyjqwI+0NAdh2HeI0k=";
  
  ldflags = [
    "-X github.com/vespa-engine/vespa/client/go/internal/build.Version=${version}"
  ];

  subPackages = [ "internal/cli/cmd/vespa" ];

  installPhase = ''
    runHook preInstall
    install -D $GOPATH/bin/vespa $out/bin/vespa
    runHook postInstall
  '';

  meta = with lib; {
    description = "Vespa CLI tool";
    homepage = "https://vespa.ai/";
    license = licenses.asl20;
    maintainers = with maintainers; [ jasanfarah ];
    mainProgram = "vespa";
  };
}
