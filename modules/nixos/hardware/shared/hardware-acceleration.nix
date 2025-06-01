{pkgs, ...}: {
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };
  # hardware.opengl = {
  #   enable = true;
  #   extraPackages = with pkgs; [
  #     intel-media-driver # LIBVA_DRIVER_NAME=iHD
  #     vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
  #     vaapiVdpau
  #     libvdpau-va-gl
  #   ];
  # };
  hardware.graphics = {
    enable = true;
    # driSupport = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      # intel-video-accel
      vulkan-loader
      vulkan-validation-layers
      vpl-gpu-rt # for newer GPUs on NixOS >24.05 or unstable
    ];
  };
  # Pacotes recomendados para monitoramento
  environment.systemPackages = with pkgs; [
    vulkan-tools # Verificação Vulkan (vulkaninfo)
    # nvtop # Monitor de GPU (suporte Intel)
    clinfo # Verificar OpenCL
  ];
  # Variáveis críticas para OpenCL/Vulkan
  environment.variables = {
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/intel_icd.x86_64.json";
    OCL_ICD_VENDORS = "intel.icd";
  };
}
