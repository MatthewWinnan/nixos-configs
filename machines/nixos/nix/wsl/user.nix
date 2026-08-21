# WSL user account.
#
# This used to be a near-verbatim copy of nix/user/default.nix and drifted from
# it - the declared SSH keys were added there and missed here, which would have
# left this host with PasswordAuthentication = false and no keys at all.
#
# The only difference the copy ever had was omitting the openocd udev rules,
# and those are guarded on the personal/gaming profiles while this host is on
# work - so they never applied here anyway. Importing the shared module is
# exactly equivalent, minus the drift.
{...}: {
  imports = [../../../../nix/user];
}
