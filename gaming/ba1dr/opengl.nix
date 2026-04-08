{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    # Intel VA-API drivers for hardware video decoding (QSV)
    # Used by Jellyfin for hybrid transcoding (Intel decode + NVIDIA encode)
    extraPackages = with pkgs; [
      intel-media-driver # VAAPI driver for Intel (newer, recommended)
      intel-vaapi-driver # VAAPI driver for Intel (legacy fallback)
      libva-vdpau-driver # VAAPI to VDPAU bridge
      libvdpau-va-gl # VDPAU to VAAPI bridge
    ];
  };
}
