{
  description = "nix doom emacs example";

  inputs = {
    nix-doom-emacs = {
      url = github:vlaci/nix-doom-emacs/develop;
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.doom-emacs.url = github:hlissner/doom-emacs/develop;
      inputs.doom-emacs.flake = false;
      inputs.doom-snippets.url = github:hlissner/doom-snippets;
      inputs.doom-snippets.flake = false;
      inputs.emacs-overlay.url = github:nix-community/emacs-overlay;
      inputs.emacs-so-long.url = github:hlissner/emacs-so-long;
      inputs.emacs-so-long.flake = false;
      inputs.evil-markdown.url = github:Somelauw/evil-markdown;
      inputs.evil-markdown.flake = false;
      inputs.evil-org-mode.url = github:hlissner/evil-org-mode;
      inputs.evil-org-mode.flake = false;
      inputs.evil-quick-diff.url = github:rgrinberg/evil-quick-diff;
      inputs.evil-quick-diff.flake = false;
      inputs.explain-pause-mode.url = github:lastquestion/explain-pause-mode;
      inputs.explain-pause-mode.flake = false;
      inputs.nix-straight.url = github:vlaci/nix-straight.el;
      inputs.nix-straight.flake = false;
      inputs.straight.url = github:raxod502/straight.el/develop;
      inputs.straight.flake = false;
      inputs.nose.url = github:emacsattic/nose;
      inputs.nose.flake = false;
      inputs.ob-racket.url = github:xchrishawk/ob-racket;
      inputs.ob-racket.flake = false;
      inputs.org-mode.url = github:emacs-straight/org-mode;
      inputs.org-mode.flake = false;
      inputs.org-contrib.url = git+https://git.sr.ht/~bzg/org-contrib;
      inputs.org-contrib.flake = false;
      inputs.org.url = github:emacs-straight/org-mode;
      inputs.org.flake = false;
      inputs.org-yt.url = github:TobiasZawada/org-yt;
      inputs.org-yt.flake = false;
      inputs.php-extras.url = github:arnested/php-extras;
      inputs.php-extras.flake = false;
      inputs.revealjs.url = github:hakimel/reveal.js;
      inputs.revealjs.flake = false;
      inputs.rotate-text.url = github:debug-ito/rotate-text.el;
      inputs.rotate-text.flake = false;
    };
    doom-emacs.url = github:hlissner/doom-emacs/develop;
    doom-emacs.flake = false;
    doom-snippets.url = github:hlissner/doom-snippets;
    doom-snippets.flake = false;
    emacs-overlay.url = github:nix-community/emacs-overlay;
    emacs-so-long.url = github:hlissner/emacs-so-long;
    emacs-so-long.flake = false;
    evil-markdown.url = github:Somelauw/evil-markdown;
    evil-markdown.flake = false;
    evil-org-mode.url = github:hlissner/evil-org-mode;
    evil-org-mode.flake = false;
    evil-quick-diff.url = github:rgrinberg/evil-quick-diff;
    evil-quick-diff.flake = false;
    explain-pause-mode.url = github:lastquestion/explain-pause-mode;
    explain-pause-mode.flake = false;
    nix-straight.url = github:vlaci/nix-straight.el;
    nix-straight.flake = false;
    straight.url = github:raxod502/straight.el/develop;
    straight.flake = false;
    nose.url = github:emacsattic/nose;
    nose.flake = false;
    ob-racket.url = github:xchrishawk/ob-racket;
    ob-racket.flake = false;
    org-mode.url = github:emacs-straight/org-mode;
    org-mode.flake = false;
    org-contrib.url = git+https://git.sr.ht/~bzg/org-contrib;
    org-contrib.flake = false;
    org.url = github:emacs-straight/org-mode;
    org.flake = false;
    org-yt.url = github:TobiasZawada/org-yt;
    org-yt.flake = false;
    php-extras.url = github:arnested/php-extras;
    php-extras.flake = false;
    revealjs.url = github:hakimel/reveal.js;
    revealjs.flake = false;
    rotate-text.url = github:debug-ito/rotate-text.el;
    rotate-text.flake = false;

    nixpkgs.url = github:NixOS/nixpkgs;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, nix-doom-emacs, emacs-overlay, ... }:
    (flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            emacs-overlay.overlay
          ];
        };
      in
      {
        packages.emacs = nix-doom-emacs.package."${system}"
          {
            doomPrivateDir = nix-doom-emacs + "/test/doom.d";
            dependencyOverrides = inputs;
            bundledPackages = false;
            emacsPackages = pkgs.emacsPackagesFor pkgs.emacsGcc;
          };
      }
    ));
}
