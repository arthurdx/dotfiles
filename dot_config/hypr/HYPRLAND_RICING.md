# Hyprland Ricing Guide

> Tailored for: Arch Linux, NVIDIA GTX 1050 Ti, Hyprland 0.53.x, 1920x1080 display

---

## 1. NVIDIA-Specific Settings

### Environment Variables
```conf
# Add to hyprland.conf
env = LIBVA_DRIVER_NAME,nvidia
env = XDG_SESSION_TYPE,wayland
env = GBM_BACKEND,nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
env = WLR_NO_HARDWARE_CURSORS,1
```

### Hyprland NVIDIA Options
```conf
opengl {
    nvidia_anti_flicker = 0   # Can help with flickering, experiment
}

cursor {
    no_hardware_cursors = true  # Required for NVIDIA
}
```

### Kernel Module Parameters
Create `/etc/modprobe.d/nvidia.conf`:
```
options nvidia_drm modeset=1
options nvidia NVreg_UsePageAttributeTable=1
```

---

## 2. Performance Optimizations

### Critical Settings for Older Hardware

```conf
misc {
    vfr = true                  # Variable frame rate - only render on changes
    disable_hyprland_logo = true
    force_default_wallpaper = 0
}

debug {
    damage_tracking = 2         # Only redraw changed regions (0=off, 2=full)
}
```

**WARNING:** Your current config has `vfr = 0` and `damage_tracking = 0` which forces constant full redraws - very bad for GTX 1050 Ti performance.

### Blur Performance
```conf
decoration {
    blur {
        enabled = true
        size = 4              # Lower = faster (range: 1-10)
        passes = 2            # Lower = faster (range: 1-4)
        new_optimizations = true
        xray = false          # Disable for performance
    }
}
```

### Animation Performance
```conf
animations {
    enabled = true
    # Faster animations = less GPU work
    animation = global, 1, 5, default   # Speed 5 instead of 10
    animation = windows, 1, 3, default
    animation = fade, 1, 3, default
}
```

---

## 3. Visual Customization

### Color Schemes

**Catppuccin Mocha:**
```conf
$rosewater = rgb(f5e0dc)
$flamingo  = rgb(f2cdcd)
$pink      = rgb(f5c2e7)
$mauve     = rgb(cba6f7)
$red       = rgb(f38ba8)
$maroon    = rgb(eba0ac)
$peach     = rgb(fab387)
$yellow    = rgb(f9e2af)
$green     = rgb(a6e3a1)
$teal      = rgb(94e2d5)
$sky       = rgb(89dceb)
$sapphire  = rgb(74c7ec)
$blue      = rgb(89b4fa)
$lavender  = rgb(b4befe)
$text      = rgb(cdd6f4)
$subtext1  = rgb(bac2de)
$subtext0  = rgb(a6adc8)
$overlay2  = rgb(9399b2)
$overlay1  = rgb(7f849c)
$overlay0  = rgb(6c7086)
$surface2  = rgb(585b70)
$surface1  = rgb(45475a)
$surface0  = rgb(313244)
$base      = rgb(1e1e2e)
$mantle    = rgb(181825)
$crust     = rgb(11111b)
```

**Usage:**
```conf
general {
    col.active_border = $mauve $pink 45deg
    col.inactive_border = $surface0
}
```

### Gaps and Borders
```conf
general {
    gaps_in = 5           # Between windows
    gaps_out = 10         # Screen edges
    border_size = 2

    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)
}
```

### Rounding
```conf
decoration {
    rounding = 10
    rounding_power = 2    # Higher = sharper corners
}
```

---

## 4. Common Tools

### Bars
| Tool | Description |
|------|-------------|
| **waybar** | Most popular, highly configurable |
| **eww** | Widget system, complex but powerful |
| **ags/quickshell** | JS/QML-based, modern (you use noctalia-shell) |
| **ironbar** | Rust-based, good performance |

### Launchers
| Tool | Description |
|------|-------------|
| **rofi-wayland** | Feature-rich, themeable |
| **wofi** | Native Wayland, simple |
| **fuzzel** | Fast, minimal |
| **tofi** | Ultra-minimal, fast |
| **anyrun** | Plugin-based, modern |

### Notifications
| Tool | Description |
|------|-------------|
| **mako** | Lightweight, common choice |
| **dunst** | Feature-rich, supports images |
| **swaync** | Full notification center |

### Wallpaper
| Tool | Description |
|------|-------------|
| **hyprpaper** | Official, simple |
| **swww** | Animated transitions |
| **mpvpaper** | Video wallpapers |

### Screenshots
| Tool | Description |
|------|-------------|
| **hyprshot** | Hyprland-native (you use this) |
| **grim + slurp** | Classic combo |
| **flameshot** | GUI editor (XWayland) |

### Lock Screen
| Tool | Description |
|------|-------------|
| **hyprlock** | Official, GPU-accelerated |
| **swaylock-effects** | Blur effects |

### Clipboard
| Tool | Description |
|------|-------------|
| **cliphist** | History manager (you use this with noctalia) |
| **wl-clipboard** | Core clipboard tools |

---

## 5. Window Rules

### New v2 Syntax (Hyprland 0.41+)
```conf
# Float specific apps
windowrule = float, class:^(pavucontrol)$
windowrule = float, class:^(nm-connection-editor)$
windowrule = float, title:^(Open File)$
windowrule = float, title:^(Save As)$

# Size constraints
windowrule = size 800 600, class:^(pavucontrol)$
windowrule = center, class:^(pavucontrol)$

# Workspace assignment
windowrule = workspace 2, class:^(firefox)$
windowrule = workspace 3, class:^(code)$

# Opacity per app
windowrule = opacity 0.95, class:^(kitty)$
windowrule = opacity 1.0, class:^(firefox)$

# Gaming - disable blur/animations
windowrule = noblur, class:^(steam_app_.*)$
windowrule = fullscreen, class:^(steam_app_.*)$
windowrule = immediate, class:^(steam_app_.*)$  # No VSync

# XWayland fixes
windowrule = nofocus, class:^$, title:^$, xwayland:1, floating:1
```

### Suppress Maximize (Electron apps)
```conf
windowrule = suppressevent maximize, class:.*
```

---

## 6. Keybindings Best Practices

### Bind Types
| Type | Description |
|------|-------------|
| `bind` | Normal keybind |
| `bindm` | Mouse bind |
| `bindl` | Locked (works on lockscreen) |
| `bindle` | Locked + repeat |
| `binde` | Repeat on hold |
| `bindr` | On release |

### Resize Submap Pattern
```conf
bind = $mainMod, R, submap, resize

submap = resize
binde = , right, resizeactive, 10 0
binde = , left, resizeactive, -10 0
binde = , up, resizeactive, 0 -10
binde = , down, resizeactive, 0 10
bind = , escape, submap, reset
submap = reset
```

### Move Windows
```conf
bind = $mainMod SHIFT, left, movewindow, l
bind = $mainMod SHIFT, right, movewindow, r
bind = $mainMod SHIFT, up, movewindow, u
bind = $mainMod SHIFT, down, movewindow, d
```

---

## 7. Troubleshooting

### Black Screen on Start
```bash
# Check logs
cat ~/.local/share/hyprland/hyprland.log

# Try with basic config
Hyprland -c /dev/null
```

### Flickering/Tearing
```conf
# Try these in hyprland.conf
opengl {
    nvidia_anti_flicker = 1  # or 0, experiment
}

misc {
    vfr = true
    no_direct_scanout = true  # May help with tearing
}
```

### Cursor Issues
```conf
cursor {
    no_hardware_cursors = true
}

env = WLR_NO_HARDWARE_CURSORS,1
env = XCURSOR_SIZE,24
```

### XWayland Apps Blurry
```conf
xwayland {
    force_zero_scaling = true
}

# Also set in env
env = GDK_SCALE,1
env = QT_SCALE_FACTOR,1
```

### Screen Sharing
```bash
# Install required packages
sudo pacman -S xdg-desktop-portal-hyprland pipewire wireplumber

# Add to hyprland.conf autostart
exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
```

### Debug Commands
```bash
hyprctl monitors          # Display info
hyprctl clients           # Window list
hyprctl layers            # Layer info
hyprctl version           # Version info
hyprctl reload            # Reload config
```

---

## 8. Your Specific Setup Notes

### Current Issues Identified
1. `vfr = 0` - Change to `true` for better performance
2. `damage_tracking = 0` - Change to `2` for partial redraws

### Ultrawide Emulation
Your `addreserved` approach works for window placement but apps still render at 1080p. Alternatives:
- **Gamescope** for specific apps: `gamescope -w 1920 -h 810 -W 1920 -H 1080 -- app`
- **Window rules** with maxsize for Electron apps
- Native virtual output splitting is **not supported** in Hyprland (closed as "not planned")

---

## Resources

- [Hyprland Wiki](https://wiki.hypr.land/)
- [Hyprland GitHub](https://github.com/hyprwm/Hyprland)
- [r/hyprland](https://reddit.com/r/hyprland)
- [Catppuccin for Hyprland](https://github.com/catppuccin/hyprland)
