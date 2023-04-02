{
  description = "Using leaked data";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.utils.url = "github:numtide/flake-utils";

  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      formatter = pkgs.alejandra;
      apps.default = utils.lib.mkApp {
        drv = pkgs.writeShellApplication {
          name = "show-slides";
          runtimeInputs = with pkgs; [vlc];

          text = ''
            cd ${self.packages.${system}.default}
            ${pkgs.pympress}/bin/pympress slides.pdf
          '';
        };
      };
      packages.default =
        pkgs.runCommand "slides.pdf" {
          src = pkgs.lib.sources.sourceFilesBySuffices ./. [
            ".tex"
          ];
        } ''
          ln -sf ${self.packages.${system}.images} img
          ${pkgs.texlive.combined.scheme-medium}/bin/pdflatex $src/slides.tex
          mkdir $out
          mkdir $out/img
          cp slides.pdf $out/
          ln -sv ${self.packages.${system}.images}/*.mp4 $out/img/
        '';
      packages.images =
        pkgs.runCommand "slides.pdf-images" {
          src = pkgs.lib.sources.sourceFilesBySuffices ./. [
            ".jpg"
            ".mp4"
            ".png"
          ];
        } ''
          mkdir -p $out
          cp -v $src/img/* $out/
        '';
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [mat2 texlive.combined.scheme-medium];
      };
    });
}
