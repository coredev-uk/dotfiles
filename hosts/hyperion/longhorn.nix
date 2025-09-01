{ config, pkgs, ... }:

{
  # Longhorn storage optimization for Hyperion host

  # Enable required kernel modules for Longhorn
  boot.kernelModules = [
    "iscsi_tcp" # Required for iSCSI connections
    "nvme_tcp" # For NVMe over TCP (if using remote NVMe storage)
    "dm_crypt" # For volume encryption support
    "dm_snapshot" # For snapshot functionality
    "target_core_mod" # iSCSI target support
    "target_core_iblock"
    "target_core_file"
    "iscsi_target_mod"
    "configfs" # Configuration filesystem for targets
  ];

  # Load modules at boot
  boot.extraModulePackages = with config.boot.kernelPackages; [
    # Additional modules will be loaded automatically
  ];

  # Ensure required kernel parameters for storage optimization
  boot.kernelParams = [
    # Optimize for storage workloads
    "elevator=none" # Use no I/O scheduler for NVMe (better for SSDs)
    "transparent_hugepage=madvise" # Better memory management for storage
    "intel_iommu=on" # Enable IOMMU for better device isolation
    "iommu=pt" # Use passthrough mode for better performance
  ];

  # Install required packages for Longhorn
  environment.systemPackages = with pkgs; [
    # Essential packages for Longhorn operation
    openiscsi # iSCSI initiator (correct package name)
    nfs-utils # NFS client for backup targets
    cryptsetup # For volume encryption
    util-linux # General utilities (blkid, lsblk, etc.)
    e2fsprogs # ext4 filesystem tools
    xfsprogs # XFS filesystem tools
    btrfs-progs # btrfs filesystem tools (already in use)
    nvme-cli # NVMe management tools
    smartmontools # SMART monitoring
    hdparm # Hard disk parameter utility
    parted # Partitioning tools
    multipath-tools # Multipath device management
    lvm2 # LVM tools (may be useful for advanced setups)
    iotop # I/O monitoring
    iftop # Network I/O monitoring
    argocd # Argocd for GitOps (if managing Longhorn via GitOps)
  ];

  # Configure iSCSI initiator (extend existing config)
  # Note: Basic iSCSI config is already handled in common/services/iscsi.nix

  # Optimize systemd for storage workloads
  systemd.settings.Manager = {
    # Increase default timeout for storage operations
    DefaultTimeoutStartSec = "300s";
    DefaultTimeoutStopSec = "300s";
  };

  # Configure sysctl parameters for storage optimization
  boot.kernel.sysctl = {
    # Network optimizations for distributed storage
    "net.core.rmem_max" = 67108864; # 64MB receive buffer
    "net.core.wmem_max" = 67108864; # 64MB send buffer
    "net.core.rmem_default" = 67108864;
    "net.core.wmem_default" = 67108864;
    "net.ipv4.tcp_rmem" = "4096 87380 67108864";
    "net.ipv4.tcp_wmem" = "4096 65536 67108864";
    "net.ipv4.tcp_congestion_control" = "bbr"; # Better congestion control
    "net.core.netdev_max_backlog" = 5000;

    # Storage I/O optimizations
    "vm.dirty_ratio" = 15; # Dirty memory ratio
    "vm.dirty_background_ratio" = 5; # Background dirty memory ratio
    "vm.dirty_expire_centisecs" = 12000; # 2 minutes
    "vm.dirty_writeback_centisecs" = 1500; # 15 seconds
    "vm.vfs_cache_pressure" = 50; # Reduce VFS cache pressure
    "vm.swappiness" = 1; # Minimize swapping for storage workloads

    # File descriptor limits
    "fs.file-max" = 2097152; # Max open files
    "fs.nr_open" = 1048576; # Max open files per process

    # Network connection tracking optimizations
    "net.netfilter.nf_conntrack_max" = 1048576;
    "net.netfilter.nf_conntrack_tcp_timeout_established" = 28800;
  };

  # Configure NFS client optimizations
  services.nfs.settings = {
    # NFS client optimizations for backup operations
    nfsmount = {
      vers = "4.1";
      proto = "tcp";
      fsc = true;
      _netdev = true;
    };
  };

  # Enable and configure appropriate filesystems
  boot.supportedFilesystems = [
    "btrfs"
    "ext4"
    "xfs"
    "nfs"
    "nfs4"
  ];

  # Create necessary directories for Longhorn (skip /var/lib/longhorn as it exists)
  systemd.tmpfiles.rules = [
    "d /var/lib/longhorn/replicas 0750 root root -"
    "d /var/lib/longhorn/engines 0750 root root -"
    "d /var/lib/longhorn/backups 0750 root root -"
    "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
  ];

  # Configure logrotate for Longhorn logs
  services.logrotate.settings = {
    "/var/log/longhorn/*.log" = {
      daily = true;
      missingok = true;
      rotate = 7;
      compress = true;
      delaycompress = true;
      copytruncate = true;
    };
  };

  # Firewall rules for Longhorn (already partially configured in k3s.nix)
  networking.firewall = {
    allowedTCPPorts = [
      # Longhorn Manager and UI
      8000 # Longhorn Manager
      9500 # Longhorn Manager metrics

      # Longhorn Engine and Data Plane
      10000 # Longhorn Engine start port (range: 10000-30000)
    ];

    allowedTCPPortRanges = [
      {
        from = 10000;
        to = 30000;
      } # Longhorn Engine port range
    ];
  };

  # Monitoring and alerting setup for storage health
  services.smartd = {
    enable = true;
    autodetect = true;
    notifications = {
      wall.enable = false; # Disable wall notifications in server environment
    };
  };

  # Enable hardware monitoring
  hardware.cpu.intel.updateMicrocode = true;
  powerManagement.cpuFreqGovernor = "performance"; # For consistent storage performance

  # Additional security considerations for storage
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "1048576";
    }
    {
      domain = "*";
      type = "hard";
      item = "nofile";
      value = "1048576";
    }
  ];
}
