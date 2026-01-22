{
  description = "@illotum's env setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }: {
    packages."aarch64-darwin".default =
      let
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";
      in
      pkgs.buildEnv {
        name = "home-packages";
        paths = with pkgs; [
          # basics
          git
          jujutsu
          fish
          fd
          zoxide
          fzf
          ripgrep
          tree
          hyperfine
          diffr
          cloc
          # jdk
          
          # infra
          taplo
          awscli2
          google-cloud-sdk
          # docker
          # dockerfile-language-server-nodejs
          # docker-compose
          # docker-compose-language-service
          # podman
          # qemu
          # libvirt
          opentofu
          terraform-ls
          kubectl
          yaml-language-server
          kubernetes-helm
          helm-ls
          ansible
          ansible-language-server

          # network
          curl
          wget
          nmap
          ipcalc

          # tools
          rakudo
          zef
          go

          # files
          cfssl
          angle-grinder
          yq
          imagemagick
          pandoc
          ffmpeg
          gnused
          graphviz

          helix
          nil
        ];
      };
  };
}
