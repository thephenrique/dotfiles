# keyd

[keyd](https://github.com/rvaiya/keyd) configuration.

## Setup

keyd only reads configs from `/etc/keyd`, so symlink them:

```bash
sudo ln -s ~/.config/keyd/default.conf /etc/keyd/default.conf
sudo ln -s ~/.config/keyd/hhkb.conf /etc/keyd/hhkb.conf
```

Reload after editing:

```bash
sudo keyd reload
```

## Files

- `default.conf` — built-in / default keyboard
- `hhkb.conf` — HHKB
