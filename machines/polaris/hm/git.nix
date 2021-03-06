{ ... }:
{
  programs.git = {
    enable = true;
    userName  = "sinavir";
    userEmail = "sinavir@sinavir.fr";
    aliases = {
      co = "checkout";
      ci = "commit";
      br = "branch --all -v";
      st = "status";
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all";
    };
  };
}
