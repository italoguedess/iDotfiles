{ pkgs ? import <nixpkgs> {} }:

let
  myEmacs = pkgs.emacs;
  emacsWithPackages = (pkgs.emacsPackagesFor myEmacs).emacsWithPackages;
in
  emacsWithPackages ((with pkgs.emacsPackages; [ 
    # From main packages set
    emacs
    use-package
    bind-key
    # bling
    modus-themes
    doom-modeline
    all-the-icons
    # completion
    counsel
    ivy-rich
    which-key
    helpful
    # IDEmacs
    evil
    evil-collection
    annalist
    evil-smartparens
    projectile
    magit
    # adding modes
    julia-mode
    ob-julia-vterm
    nix-mode
    # orgmode
    org
    org-re-reveal
    org-bullets
    # lsp plugins and language servers
    lsp-mode
    company
    flycheck
    yasnippet
    yasnippet-snippets
    smartparens
  ])

  ++ (with pkgs; [
    nil
    ccls
    texlab
    pylyzer
    gdb
]))
