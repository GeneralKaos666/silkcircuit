# Termux

Color schemes for [Termux](https://termux.dev/) itself, in the
`colors.properties` format the app reads directly.

## Install

Termux's built-in color picker (and the `color-changer` command some setups
ship) only looks in `~/.termux/colors/dark` and `~/.termux/colors/light`, so
that is where these land:

```bash
mkdir -p ~/.termux/colors/dark ~/.termux/colors/light
cp extras/termux/silkcircuit-{neon,vibrant,soft,glow}.properties ~/.termux/colors/dark/
cp extras/termux/silkcircuit-dawn.properties ~/.termux/colors/light/
```

Then pick one with `color-changer`, or by hand:

```bash
ln -sf ~/.termux/colors/dark/silkcircuit-neon.properties ~/.termux/colors.properties
termux-reload-settings
```

The installer sorts variants into `dark/` and `light/` the same way:
`./install.sh`, or `./install.sh --variant neon` for just that one.

## Files

<!-- extras:start target=termux -->

| Variant | File                                           |
| ------- | ---------------------------------------------- |
| neon    | `extras/termux/silkcircuit-neon.properties`    |
| vibrant | `extras/termux/silkcircuit-vibrant.properties` |
| soft    | `extras/termux/silkcircuit-soft.properties`    |
| glow    | `extras/termux/silkcircuit-glow.properties`    |
| dawn    | `extras/termux/silkcircuit-dawn.properties`    |

<!-- extras:end -->
