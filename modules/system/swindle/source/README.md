## Swindle

> "It's so bad it's not even funny!" -kantiankant, 2026


Swindle is a fork of [dwl](https://codeberg.org/dwl/dwl) that was designed from the start with one goal: to make it feel like the poor man's Hyprland. It has the following:

* NO cool vfx (yet)
* nearly NO documentation
* ZERO good original code
* only ONE tiling layout (dwindle)
 
> Fun fact: I actually took some parts of [MangoWM](https://github.com/mangowm/mango) (such as the ext-workspaces implementation). hence why the LICENSE.mangowm exists

## Dependencies

* libinput
* wayland
* wlroots-0.20 (compiled with the libinput backend)
* xkbcommon
* wayland-protocols (compile-time only)
* pkg-config (compile-time only)

Install these (and their `-devel` versions if your distro has separate
development packages) and run `make` followed by `doas/sudo make install`, if you wish to install it (installs to /usr/local/bin/ by default). 

## Things that are good to have

* [foot](https://codeberg.org/dnkl/foot)


## Known Issues

N/A

## Configuration

read example/config.lua. It should give you a basic idea of how configuring swindle works. 

> note: it's best to copy /etc/swindle/config.lua into XDG_HOME_DIR/.config/swindle/ before you attempt to 
start swindle because it (swindle) won't start without it

## Checklist

- [ ] separate the trackpad scroll from the mousee scroll 
- [ ] Add ability to change your keymap
- [ ] Add animations via [scenefx](https://github.com/wlrfx/scenefx) when 0.5 drops (in another branch)
- [ ] Add the ability for the compositor to read a custom path for configs
- [ ] Add /etc/swindle/config.lua as a fallback path if $HOME/.config/swindle/config.lua is not found 


## License

GPL-v3, probably
