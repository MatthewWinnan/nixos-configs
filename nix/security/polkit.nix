_: {
  security.polkit = {
    enable = true;

    # TODO: On nixos-unstable, use `extraArgs = ["--log-level=debug"];` for debug logging
    extraConfig = ''
      /* Log authorization checks. */
      polkit.addRule(function(action, subject) {
        polkit.log("user " +  subject.user + " is attempting action " + action.id + " from PID " + subject.pid);
      });
    '';
  };
}
