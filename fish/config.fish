if status is-interactive
    starship init fish | source
    alias vadim='$HOME/.config/hypr/scripts/vadim.sh'
    alias ls="exa --icons"
    alias lla="exa --icons -a"
    alias lst="exa -l -g -T --icons -L=2"
    alias ll="exa -l -g --icons"

    alias g="git"
    alias gc="git clone"

    set -gx EDITOR nvim
end
