{ ... }: {
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "sinavir";
        email = "sinavir@sinavir.fr";
      };
      alias = {
        co = "checkout";
        ci = "commit";
        br = "branch --all -v";
        st = "status";
        lg =
          "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all";
      };
    };
  };
}
