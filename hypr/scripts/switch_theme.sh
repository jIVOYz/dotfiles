#!/bin/sh

# getting json values
THEME_CONFIG="~/.config/hypr/themes/$1/$1.json"
GTK_THEME=$(cat ~/.config/hypr/themes/$1/$1.json | jq -r ".gtkTheme")
ICON_THEME=$(cat ~/.config/hypr/themes/$1/$1.json | jq -r ".iconTheme")
KVANTUM_THEME=$(cat ~/.config/hypr/themes/$1/$1.json | jq -r ".kvantumTheme")
COLOR_SCHEME=$(cat ~/.config/hypr/themes/$1/$1.json | jq -r ".colorScheme")
THEME_NAME=$(cat ~/.config/hypr/themes/$1/$1.json | jq -r ".themeName")
NVIM_THEME=$(cat ~/.config/hypr/themes/$1/$1.json | jq -r ".nvimTheme")
KITTY_THEME=$(cat ~/.config/hypr/themes/$1/$1.json | jq -r ".kittyTheme")

# waybar
killall waybar
sed -i "/^@import/c\@import url(\"./themes/$THEME_NAME.css\");" ~/.config/waybar/style.css
waybar &
disown

# kvantum themes
kvantummanager --set $KVANTUM_THEME

# gtk 3.0
sed -i "/^gtk-theme-name=/c\gtk-theme-name=${GTK_THEME}" ~/.config/gtk-3.0/settings.ini
sed -i "/^gtk-icon-theme-name=/c\gtk-icon-theme-name=${ICON_THEME}" ~/.config/gtk-3.0/settings.ini

# gtk 4.0
gsettings set org.gnome.desktop.interface gtk-theme $GTK_THEME
gsettings set org.gnome.desktop.interface icon-theme $ICON_THEME
sed -i "/^env = GTK_THEME/c\env = GTK_THEME,${GTK_THEME}" ~/.config/hypr/hyprland.conf

# rofi
killall rofi
sed -i "/^@theme/c\@theme \"./themes/$THEME_NAME.rasi\"" ~/.config/rofi/config.rasi

# dunst
if [ $THEME_NAME = "Light" ]; then
	sed -i "/^background=/c\background=\"#dfe2ee\"" ~/.config/dunst/dunstrc
	sed -i "/^foreground=/c\foreground=\"#646985\"" ~/.config/dunst/dunstrc

elif [ $THEME_NAME = "Dark" ]; then
	sed -i "/^background=/c\background=\"#2f312c\"" ~/.config/dunst/dunstrc
	sed -i "/^foreground=/c\foreground=\"#dfe2ee\"" ~/.config/dunst/dunstrc
fi
killall dunst
notify-send -a "Theme Switch" $THEME_NAME

# neovim
cp ~/.config/nvim/lua/plugins/themes/$NVIM_THEME.lua ~/.config/nvim/lua/plugins/colorscheme.lua
sed -i "/^colorscheme = \"/c\colorscheme=\"$NVIM_THEME\"" ~/.config/nvim/lua/config/lazy.lua

# kitty terminal
sed -i "/^include/c\include $KITTY_THEME.conf" ~/.config/kitty/kitty.conf
