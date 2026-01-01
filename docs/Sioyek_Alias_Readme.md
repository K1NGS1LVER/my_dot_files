# Sioyek PDF Alias

To open PDFs directly from your terminal using Sioyek in a new window, a Zsh function has been added to your `~/.zshrc`.

## Usage

```bash
pdf filename.pdf
```

## How it works

The following function was added to your `~/.zshrc`:

```bash
# Open PDF in Sioyek (New Window)
pdf() {
    /Applications/sioyek.app/Contents/MacOS/sioyek --new-window "$@" &> /dev/null &|
}
```

- `--new-window`: Forces a new instance.
- `&> /dev/null`: Silences output.
- `&|`: Detaches the process so closing the terminal doesn't close the PDF.

## Setup

If you haven't already, run this to apply the changes:

```bash
source ~/.zshrc
```
