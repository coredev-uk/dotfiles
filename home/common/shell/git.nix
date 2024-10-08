{ pkgs, lib, ... }:
{
  home.file.".config/git/allowed_signers".text = ''
    core@coredev.uk ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIHUzKGICI1VKmixsiWZnXCRZRdEHYfMcFY3sleAASu/ED/yeLwwtl3ACC+aDIESwYmq1oxTHmXEmy0+Pjc+TLg= YK5C-1
    core@coredev.uk ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBNhfvWTRZU1BxawHJ5RRHF9TTvhBuLOzh5h9cL2MMttYCxIJPPASJSLrj71E44pdlPFfJDKrkDIbmge3CibKGbg== YK5C-2

    core@cider.sh ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIHUzKGICI1VKmixsiWZnXCRZRdEHYfMcFY3sleAASu/ED/yeLwwtl3ACC+aDIESwYmq1oxTHmXEmy0+Pjc+TLg= YK5C-1
    core@cider.sh ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBNhfvWTRZU1BxawHJ5RRHF9TTvhBuLOzh5h9cL2MMttYCxIJPPASJSLrj71E44pdlPFfJDKrkDIbmge3CibKGbg== YK5C-2

    pt357@kent.ac.uk ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIHUzKGICI1VKmixsiWZnXCRZRdEHYfMcFY3sleAASu/ED/yeLwwtl3ACC+aDIESwYmq1oxTHmXEmy0+Pjc+TLg= YK5C-1
    pt357@kent.ac.uk ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBNhfvWTRZU1BxawHJ5RRHF9TTvhBuLOzh5h9cL2MMttYCxIJPPASJSLrj71E44pdlPFfJDKrkDIbmge3CibKGbg== YK5C-2
  '';

  home.packages = with pkgs; [ gh ];

  programs = {
    git = {
      enable = true;

      userEmail = "core@coredev.uk";
      userName = "Core";

      includes = [
        {
          condition = "hasconfig:remote.*.url:*github.com*ciderapp/**";
          contents.user.email = "core@cider.sh";
        }
        {
          condition = "hasconfig:remote.*.url:git@git.cs.kent.ac.uk:*/**";
          contents.user.email = "pt357@kent.ac.uk";
          contents.user.name = "Paul Thompson";
        }
      ];

      aliases = {
        lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };

      extraConfig = {
        branch = {
          sort = "-committerdate";
        };
        pull = {
          rebase = true;
        };
        init = {
          defaultBranch = "main";
        };
        gpg = {
          format = "ssh";
          ssh = {
            defaultKeyCommand = "sh -c 'echo key::$(ssh-add -L | head -n1)'";
            allowedSignersFile = "~/.config/git/allowed_signers";
          };
        };
        commit = {
          gpgSign = true;
        };
        tag = {
          gpgSign = true;
        };
        url = {
          "git@github.com:" = {
            insteadOf = "https://github.com";
          };
        };
      };
    };
  };
}
