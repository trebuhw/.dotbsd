if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting
starship init fish | source
set -g STARSHIP_COMMAND_TIMEOUT 10
set -gx EDITOR nvim
set -gx GDK_BACKEND x11
# set -gx QT_QPA_PLATFORMTHEME gnome
# set -Ux QT_QPA_PLATFORMTHEME kvantum
# set -Ux QT_QPA_PLATFORMTHEME qt5ct
set -Ux QT_QPA_PLATFORMTHEME qt6ct

set -Ux SAL_USE_VCLPLUGIN gtk3
set -Ux GDK_DPI_SCALE 1.0

fish_add_path /usr/local/bin
fish_add_path ~/.local/bin
fish_add_path ~/.local/share/bin
fish_add_path ~/.config/bspwm/scripts
fish_add_path /usr/bin

set -gx MICRO_TRUECOLOR 1

# Catppucin Mocha FZF color
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"


# add zoxide
zoxide init fish --hook prompt --cmd j | source

# add aliases
if test -f $HOME/.dotbsd/fish/.config/fish/alias.fish
    source $HOME/.dotbsd/fish/.config/fish/alias.fish
end

# Alias do klonowania z github po ssh wpisać tylko właściciela i nazwę repo> zastosownie np: gcs trebuhw/.dotfiles.git 
function gcs
    set repo $argv[1]
    git clone --depth=1 git@github.com:$repo
end

