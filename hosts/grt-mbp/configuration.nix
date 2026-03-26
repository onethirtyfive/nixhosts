{ pkgs, ... }:
let
  primaryUser = "joshuamorris";
  codeparty-sshd-label = "org.nixos.codeparty-sshd";
  codeparty-sshd-plist = "/Library/LaunchDaemons/${codeparty-sshd-label}.plist";
  codeparty-share-group = "codepartyshare";
  ghostty-terminfo = pkgs.runCommand "ghostty-terminfo" {
    nativeBuildInputs = [ pkgs.ncurses ];
  } ''
    mkdir -p "$out/share/terminfo"
    cat > ghostty.terminfo <<'EOF'
xterm-ghostty|ghostty terminal emulator compatible with xterm-256color,
  use=xterm-256color,
EOF
    tic -x -o "$out/share/terminfo" ghostty.terminfo
  '';

  codeparty-access = pkgs.writeShellScriptBin "codeparty-access" ''
    #!${pkgs.bash}/bin/bash
    set -euo pipefail

    primary_user="${primaryUser}"
    share_group="${codeparty-share-group}"
    tmux_uid="$(id -u "$primary_user")"
    tmux_socket_dir="/tmp/tmux-$tmux_uid"
    tmux_socket="$tmux_socket_dir/default"

    enable_tmux_access() {
      if [[ ! -S "$tmux_socket" ]]; then
        echo "warning: $tmux_socket is not present; start your tmux session first" >&2
        return 0
      fi

      ${pkgs.coreutils}/bin/chgrp "$share_group" "$tmux_socket_dir" "$tmux_socket"
      ${pkgs.coreutils}/bin/chmod 770 "$tmux_socket_dir"
      ${pkgs.coreutils}/bin/chmod 660 "$tmux_socket"
      ${pkgs.tmux}/bin/tmux -S "$tmux_socket" server-access -a codeparty
    }

    disable_tmux_access() {
      if [[ ! -S "$tmux_socket" ]]; then
        return 0
      fi

      ${pkgs.tmux}/bin/tmux -S "$tmux_socket" server-access -d codeparty || true
      ${pkgs.coreutils}/bin/chmod 700 "$tmux_socket_dir" || true
      ${pkgs.coreutils}/bin/chmod 600 "$tmux_socket" || true
    }

    case "''${1:-}" in
      enable|on|up)
        enable_tmux_access
        /bin/launchctl enable system/${codeparty-sshd-label}
        /bin/launchctl bootstrap system ${codeparty-sshd-plist} 2>/dev/null || true
        /bin/launchctl kickstart -k system/${codeparty-sshd-label} 2>/dev/null || true
        echo "codeparty-sshd enabled"
        ;;
      disable|off|down)
        disable_tmux_access
        /bin/launchctl bootout system/${codeparty-sshd-label} 2>/dev/null || true
        /bin/launchctl disable system/${codeparty-sshd-label}
        echo "codeparty-sshd disabled"
        ;;
      status)
        /bin/launchctl print system/${codeparty-sshd-label} 2>/dev/null || true
        /bin/launchctl print-disabled system | ${pkgs.gnused}/bin/sed -n '/"${codeparty-sshd-label}"/p'
        ;;
      *)
        echo "usage: codeparty-access <enable|disable|status>" >&2
        exit 2
        ;;
    esac
  '';
in
{
  services.openssh = {
    enable = false;
  };

  environment.etc."ssh/codeparty_sshd_config".text = ''
    Port 2222
    ListenAddress 0.0.0.0
    ListenAddress ::

    HostKey /etc/ssh/ssh_host_ed25519_key
    HostKey /etc/ssh/ssh_host_ecdsa_key
    HostKey /etc/ssh/ssh_host_rsa_key

    PasswordAuthentication no
    KbdInteractiveAuthentication no
    PubkeyAuthentication yes
    AuthenticationMethods publickey
    PermitRootLogin no
    AllowUsers codeparty
    PermitUserEnvironment no
    X11Forwarding no
    AllowTcpForwarding no
    PermitTunnel no

    AuthorizedKeysCommand /bin/cat /etc/ssh/nix_authorized_keys.d/%u
    AuthorizedKeysCommandUser _sshd

    Match User codeparty
      PermitTTY yes
      PermitUserRC no
      ForceCommand ${pkgs.tmux}/bin/tmux -S /tmp/tmux-$(id -u ${primaryUser})/default attach-session -t codeparty
  '';

  launchd.daemons.codeparty-sshd = {
    serviceConfig = {
      Label = codeparty-sshd-label;
      ProgramArguments = [
        "${pkgs.openssh}/bin/sshd"
        "-D"
        "-e"
        "-f"
        "/etc/ssh/codeparty_sshd_config"
      ];
      KeepAlive = true;
      RunAtLoad = true;
      Disabled = false;
      StandardOutPath = "/var/log/codeparty-sshd.log";
      StandardErrorPath = "/var/log/codeparty-sshd.log";
    };
  };

  homebrew = {
    enable = true;

    casks = [
      "signal"
      "keycastr"
      "obsidian"
      "ghostty"
    ];
  };

  environment.systemPackages = [
    codeparty-access
    ghostty-terminfo
  ];

  users.groups.${codeparty-share-group} = {
    gid = 552;
    members = [
      primaryUser
      "codeparty"
    ];
  };

  system.stateVersion = 5;
}
