{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {

        buildInputs = with pkgs; [
          # Compilation stuff
          ninja
          pkg-config

          # Vulkan stuff
          vulkan-loader
          vulkan-headers
          vulkan-validation-layers
          volk
          vulkan-memory-allocator
          renderdoc

          # External graphics handling
          glfw
          tinyobjloader
          ktx-tools
          slang
        ];

        shellHook = ''
          export VULKAN_HEADERS_PATH="${pkgs.vulkan-headers}"
          export VULKAN_LOADER_PATH="${pkgs.vulkan-loader}"
          export VK_LAYER_PATH="${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d"
          export GLM_PATH="${pkgs.glm}"
          export VULKAN_MEMORY_ALLOCATOR_PATH="${pkgs.vulkan-memory-allocator}"
          export KTX_PATH="${pkgs.ktx-tools}"

          echo "May the GPU bursts into flames!"
        '';
      };
    };
}
