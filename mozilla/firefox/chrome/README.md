# Minimal Firefox CSS

This is a small collection of custom stylesheets for Firefox. I built these because I wanted a browsing experience that gets out of the way—no extra padding, no distracting borders, just the web.

It’s not a complete overhaul that will break with every update. It’s just enough CSS to strip away the visual noise while keeping the browser functional.

## What's Included

This repo contains a few different "flavors" I've tweaked:

*   **`style-reddit.css` (Default):** My daily driver. Translucent background, centered tabs, and auto-hiding UI. It feels native on macOS but cleaner.
*   **`style-gwfox.css`:** A port of the [GWFox theme](https://github.com/tahfizhabib/gwfox-css) layout (URL bar on the left, Tabs on the right) but modified to be translucent.
*   **`style-original.css`:** A bare-bones, stripped-down setup.

## How to Use

1.  Go to `about:support` in Firefox and find the **"Profile Directory"** row. Click "Show in Finder/Explorer".
2.  Open the `chrome` folder there (create one if it’s missing).
3.  Copy the files from this repo into that folder.
4.  Rename the style you want to use to **`userChrome.css`**.
    *   *Example:* If you want the default look, rename `style-reddit.css` -> `userChrome.css`.
5.  Restart Firefox.

## Switching Themes

I use a simple naming convention. If you want to switch styles, just rename the files.

- Want the side-by-side layout? Rename `style-gwfox.css` to `userChrome.css`.
- Want to go back? Rename `style-reddit.css` to `userChrome.css`.

## A Note on Transparency

If you use the translucent themes (`style-reddit.css`), they work best if your OS supports window transparency. On macOS, this usually "just works" if you have `widget.macos.vibrancy` enabled in `about:config`.

---

*This is a personal project. Use it, break it, modify it. If Firefox updates and something looks weird, it probably just needs a small CSS tweak.*
