_:
let
  defaultBtrfsOpts = [
    "defaults"
    "compress=zstd:1"    # Fast compression good for storage workloads
    "ssd"
    "noatime"            # Disable access time updates for better performance
    "nodiratime"         # Disable directory access time updates
    "space_cache=v2"     # Use v2 space cache for better performance
    "autodefrag"         # Automatic defragmentation for better performance
    "commit=30"          # Commit interval optimization
    "discard=async"      # Async discard for SSD optimization
  ];
in
{

  disko.devices = {
    disk = {
      # 1TB root/boot drive. Configured with:
      # - A FAT32 ESP partition for systemd-boot
      # - A LUKS container which containers multiple btrfs subvolumes for nixos install
      nvme0 = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              start = "0%";
              end = "1GB";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                # Override existing partition
                extraArgs = [ "-f" ];
                subvolumes = {
                  "@" = {
                    mountpoint = "/";
                    mountOptions = defaultBtrfsOpts;
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = defaultBtrfsOpts;
                  };
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = defaultBtrfsOpts;
                  };
                  "@var" = {
                    mountpoint = "/var";
                    mountOptions = defaultBtrfsOpts;
                  };
                  "@snapshots" = {
                    mountpoint = "/.snapshots";
                    mountOptions = defaultBtrfsOpts;
                  };
                  "@longhorn" = {
                    mountpoint = "/var/lib/longhorn";
                    mountOptions = defaultBtrfsOpts ++ [
                      "nodatacow"      # Disable copy-on-write for better database performance
                      "nodatasum"      # Disable checksums for raw storage performance
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
