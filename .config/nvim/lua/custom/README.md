## NvChad-LMD

<img width="1062" alt="Screenshot 2023-12-19 at 4 01 31 PM" src="https://github.com/LawnmowerDave/nvchad-custom/assets/19471665/0110b81e-13ab-4fc2-b6f7-674230a541c7">

## Fresh Server Install (Linux)
```
# Remove previous install (which can cause errors)
rm -rf ~/.local/share/nvim/lazy
# NvChad only supports Neovim >0.5
wget -q "https://github.com/neovim/neovim/releases/download/stable/nvim.appimage" -O /usr/bin/nvim
chmod +x /usr/bin/nvim
chown root:root /usr/bin/nvim
sudo apt-get install git -y
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && rm -rf ~/.config/nvim/lua/custom && git clone https://github.com/LawnmowerDave/nvchad-custom/ ~/.config/nvim/lua/custom && nvim
```

## Easy Install (Linux/MacOS)

```
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && rm -rf ~/.config/nvim/lua/custom && git clone https://github.com/LawnmowerDave/nvchad-custom/ ~/.config/nvim/lua/custom && nvim
```

### MacOS note:
Because MacOS's built-in terminal doesn't natively support full color mode, you need to use an alternative such as Alacrity or iTerm. For either of these terminals, you need to set the font to ['hack nerd'](https://www.nerdfonts.com/font-downloads) so Neovim is formatted correctly.

Additionally, you can set the transparent background by going to Preferences -> Profiles -> Window

<img width="940" alt="Screenshot 2023-12-05 at 3 10 06 PM" src="https://github.com/LawnmowerDave/nvchad-custom/assets/19471665/b29c3ad8-41ea-481a-b7ae-65090a1fa41d">

Based on https://github.com/NvChad/nvcommunity
