{...}: {
  services.espanso = {
    enable = true;
    matches = {
      others = {
        matches = [
          {
            trigger = ":now";
            replace = "It's {{currentdate}}";
            vars = [
              {
                name = "currentdate";
                type = "date";
                params = {format = "%H:%M";};
              }
            ];
          }
        ];
      };
    };
  };
}
