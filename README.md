**Minimal Neovim configuration**

`MiniVim` is a small, clean, and reproducible configuration for Neovim.

Think of it as a minimal, inspectable foundation for Neovim, not a distribution.

---

## Who is this for?

MiniVim is for developers who:

- Want a minimal Neovim setup
- Prefer understanding their config over using a framework
- Like small, inspectable Lua configurations
- Want fast startup times
- Want a clean base to extend themselves
- Dislike over-engineered distributions

MiniVim is not meant to compete with large ecosystems like LazyVim or AstroNvim.

It is intentionally small.

---

## Features

- Pure Lua configuration
- Minimal plugin set
- Clean directory structure
- Sensible defaults
- Fast startup
- No hidden abstractions
- Easy to extend

---

## Installation

### Backup existing config

```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

### Clone MiniVim

```bash
git clone https://github.com/kyanjeuring/minivim.git ~/.config/nvim
```

### Start Neovim

```bash
nvim
```

Plugins will install automatically on first launch.

### Alternative: Symlink (recommended for contributors)

If you want to contribute or modify MiniVim while keeping it in a separate directory:

```bash
git clone https://github.com/kyanjeuring/minivim.git
ln -s "$(pwd)/minivim" ~/.config/nvim
```

Now changes in the repo immediately reflect in Neovim.

---

## Updating

```bash
cd ~/.config/nvim
git pull
```

---

## Uninstall

```bash
rm -rf ~/.config/nvim
```

Restart Neovim.

---

## Extending MiniVim

Add plugins inside:

```
lua/plugins.lua
```

Add keymaps inside:

```
lua/keymaps.lua
```

Modify settings inside:

```
lua/settings.lua
```

---

## What MiniVim is NOT

- Not a framework
- Not plugin-heavy
- Not preconfigured for every language
- Not meant to abstract Neovim away

If you want a feature-complete distribution, consider:

- LazyVim
- AstroNvim
- NvChad

MiniVim stays minimal by design.

---

## Contributing

Contributions are welcome!

Please read [CONTRIBUTING.md](CONTRIBUTING.md) before submitting a PR.

---

## Support

If you found this project useful and would like to support my work:

[https://buymeacoffee.com/kyanjeuring](https://buymeacoffee.com/kyanjeuring)

## License

MIT License

---
