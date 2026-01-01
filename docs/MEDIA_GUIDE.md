# Media & Entertainment Workflow

Your system is optimized for consuming media directly from the terminal or via quick launchers, keeping you in the flow.

## 🎬 Video Playback

Two players are integrated: **MPV** (for speed/CLI) and **IINA** (for comfort/GUI).

### 1. Terminal Commands
| Command | Action | Details |
| :--- | :--- | :--- |
| `play <file>` | Open in **MPV** | Runs inside terminal/CLI. Fast. Vim keybindings. |
| `watch <file>` | Open in **IINA** | Opens native Mac app window. Best for movies/relaxing. |

### 2. Yazi (File Manager) Integration
When browsing video files (`.mp4`, `.mkv`, etc.) in Yazi:
-   **Press `Enter`**: Opens video in **MPV** (Blocking mode).
-   **Press `o` (Open With)**: Select `play_iina` to launch GUI player.

### 3. MPV Keybindings (Vim-like)
Your `~/.config/mpv/input.conf` is customized for Vim users:

| Key | Action |
| :--- | :--- |
| `h` / `l` | Seek -5s / +5s |
| `Shift` + `h` / `l` | Seek -60s / +60s |
| `j` / `k` | Volume Down / Up |
| `q` | Quit |
| `Space` | Pause/Play |

---

## 📚 Reading (E-Books)

| Command | Action |
| :--- | :--- |
| `read <file.epub>` | Open in **Apple Books** |
| `Yazi` + `Enter` | Open `.epub` in Apple Books automatically |

### Vim Mode for Apple Books
**Karabiner** is configured to map Vim keys *only* when Apple Books is focused:
-   `l` / `h`: Next / Prev Page
-   `j` / `k`: Scroll

---

## 💬 Communication
| Command | Service | Notes |
| :--- | :--- | :--- |
| `nchat` | WhatsApp | Terminal-based WhatsApp client. Supports standard shortcuts. |
