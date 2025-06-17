{ primaryUser, ... }:
{
  users.users.${primaryUser} = {
    home = "/Users/${primaryUser}";

    openssh.authorizedKeys.keys =
      [
      ];
  };
}
