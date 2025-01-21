#
#  Power Management
#
{
  config,
  lib,
  ...
}: {
  # Thermald proactively prevents overheating on Intel CPUs and works well with other tools
  config = lib.mkMerge [
    (lib.mkIf (config.gnome.enable == false) {
      services = {
        thermald.enable = true;
        #TLP
        tlp = {
          enable = true;
          settings = {
            CPU_SCALING_GOVERNOR_ON_AC = "performance";
            CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

            CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
            CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

            CPU_MIN_PERF_ON_AC = 0;
            CPU_MAX_PERF_ON_AC = 100;
            CPU_MIN_PERF_ON_BAT = 0;
            CPU_MAX_PERF_ON_BAT = 20;

            #Optional helps save long term battery health
            START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
            STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
          };
        };

        #auto-cpufreq
        auto-cpufreq.enable = true;
        auto-cpufreq.settings = {
          battery = {
            governor = "powersave";
            turbo = "never";
          };
          charger = {
            governor = "performance";
            turbo = "auto";
          };
        };
      };
    })
    (lib.mkIf (config.gnome.enable) {
      services = {
        thermald.enable = true;
        auto-cpufreq.enable = false;
        tlp.enable = false; # Power Efficiency
      };
    })
  ];
}
