{ config, lib, ... }:

let
  cfg = config.systemSettings.performance;
in
{
  options.systemSettings.performance.enable = lib.mkEnableOption "quality-of-life performance tuning";

  config = lib.mkIf cfg.enable {
    # Compressed RAM swap instead of (or alongside) a disk swap partition —
    # avoids flash wear on USB media and gives a cushion against OOM.
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 50;
    };

    # BBR + fq noticeably improves throughput/latency under load versus the
    # kernel's default congestion control
    boot.kernel.sysctl = {
      "net.core.default_qdisc" = "fq";
      "net.ipv4.tcp_congestion_control" = "bbr";
    };

    services.fstrim.enable = lib.mkDefault true;
  };
}
