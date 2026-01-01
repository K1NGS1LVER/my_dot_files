# Terminal Output Capture Guide

These tools allow you to seamlessly capture, record, and copy terminal output.

## 1. Capture Specific Command (`cap`)
Captures the output of a single command to a timestamped file.
- **Command:** `cap <any_command>`
- **Behavior:** Displays output on screen and saves to `capture_YYYYMMDD_HHMMSS.txt`.
- **Example:** `cap brew list`

## 2. Record Session (`rec`)
Records your entire terminal session, including interactive prompts.
- **Command:** `rec`
- **Behavior:** Starts a `script` recording. Type `exit` or press `Ctrl+D` to stop.
- **Result:** Saves to `recording_YYYYMMDD_HHMMSS.txt`.

## 3. Copy to Clipboard (`C`)
A global alias that pipes output directly to your system clipboard (`pbcopy`).
- **Command:** `<any_command> C`
- **Behavior:** Shows output in terminal AND copies it to your clipboard.
- **Example:** `cat config.json C`

## 4. Copying from Gemini CLI (in Tmux)
Since you are using `tmux` with `Ctrl+A` prefix, use these methods:

### Method A: Tmux Copy Mode
1. Press `Ctrl+A` then `[` to enter Copy Mode.
2. Scroll up to the answer.
3. Press `Space` to start selecting, move cursor, then `Enter` to copy.

### Method B: Terminal Override
- **Mac:** Hold `Option` while selecting text with the mouse to bypass tmux/cli controls. Then `Cmd+C`.

### Method C: Ask Gemini to Save
- Simply ask: "Save that answer to `response.md`". Gemini will write the file for you.

---
*Added on 2025-12-22*
