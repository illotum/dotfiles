{
  description = "@illotum's generic env setup";

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
          jdk
          awscli

          # network
          curl
          wget
          nmap
          ipcalc

          # tools
          rakudo
          zef
          picat
          spicetify-cli

          # files
          cfssl
          angle-grinder
          yq
          imagemagick
          pandoc
          ffmpeg
          gnused
          graphviz

          # rabbitmq
          erlang_26
          elixir_1_16
          erlang-ls
          bazelisk

          # editor
          helix
          nil
        ];
      };
  };
}
