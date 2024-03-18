# dotfiles.nix

## System Components
|                   |   NixOS - i3-Xorg   |   Darwin  |
|:-----------------:|:-------------------:|:---------:|
| **DM**            | None+i3             | /         |
| **WM/DE**         | i3                  | Yabai     |
| **Compositor**    | Picom (jonaburg)    | /         |
| **Bar**           | Polybar             | /         |
| **Hotkeys**       | /                   | Skhd      |
| **Launcher**      | Rofi                | /         |
| **GTK Theme**     | /                   | /         |
| **Notifications** | Dunst               | /         |
| **Terminal**      | Alacritty           | Alacritty |
| **Used by host**  | VM & Probook        | Macbook   |


Components relevant to all hosts:
| **Shell**    | Zsh        |
|--------------|------------|
| **Terminal** | Alacritty  |
| **Editors**  | Neovim     |

## NixOS Installation Guide



```sh
#sudo nixos-rebuild switch --flake <path>#<host>

sudo nixos-rebuild switch --flake .#notezapay
# or
sudo nixos-rebuild switch --flake .#vm
```

### Get secrets
```sh
git clone git@github.com:fabiosouzadev/secrets.git ~/.password-store
```
