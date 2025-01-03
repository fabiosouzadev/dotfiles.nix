{
  inputs,
  pkgs,
  username,
  ...
}: let
  passwordStoreDir = "/home/${username}/.password-store";
in {
  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [
      # support for one-time-password (OTP) tokens
      # NOTE: Saving the password and OTP together runs counter to the purpose of secondary verification!
      # exts.pass-otp

      exts.pass-import # a generic importer tool from other password managers
      exts.pass-update # an easy flow for updating passwords
    ]);
    settings = {
      PASSWORD_STORE_DIR = passwordStoreDir;
      PASSWORD_STORE_ENABLE_EXTENSIONS = "true";
      PASSWORD_STORE_CLIP_TIME = "60";
      PASSWORD_STORE_GENERATED_LENGTH = "15";
      # Overrides the default gpg key identification set by init.
      # Hexadecimal key signature is recommended.
      # Multiple keys may be specified separated by spaces.
      PASSWORD_STORE_KEY = pkgs.lib.strings.concatStringsSep " " [
        "0x9D79F9FD64781516"
      ];
      PASSWORD_STORE_SIGNING_KEY = pkgs.lib.strings.concatStringsSep " " [
        "0x9D79F9FD64781516"
      ];
    };
  };
}
