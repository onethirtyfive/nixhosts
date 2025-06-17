{ ... }:
{
  system.activationScripts.excludeFromSpotlight = {
    text = ''
      # Create .metadata_never_index files for code directories
      SPOTLIGHT_IGNORE_DIRS=(
        "$HOME/Code"
        "$HOME/.cache"
        "$HOME/.local"
      )

      for dir in "''${SPOTLIGHT_IGNORE_DIRS[@]}"; do
        if [[ -d "$dir" ]]; then
          echo "Excluding $dir from Spotlight"
          touch "$dir/.metadata_never_index"
        fi
      done
    '';
  };
}
