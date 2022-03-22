{ config, lib, pkgs, ... }:

{
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "qt";
    defaultCacheTtl = 3600;
  };

  systemd.user.services.gpg-agent = {
    Unit = {
      Description = "GnuPG cryptographic agent and passphrase cache";
      Documentation = "man:gpg-agent(1)";
      Requires = "gpg-agent.socket";
      After = "gpg-agent.socket";
      # This is a socket-activated service:
      RefuseManualStart = true;
    };

    Service = {
      ExecStart = "${pkgs.gnupg}/bin/gpg-agent --supervised";
      ExecReload = "${pkgs.gnupg}/bin/gpgconf --reload gpg-agent";
    };
  };
}
