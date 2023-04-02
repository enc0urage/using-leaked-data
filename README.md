Slides from a data journalism class I gave on working with leaked datasets.

Includes fragments of UK Channel 4 documentaries "Hackers in Wonderland" and
"Walk on the Wild Side - Hackers and Phreakers", a CNBC news report and snippets
of various news articles under fair use for educational purposes.

Feel free to use, share, repurpose, remix, recycle.

## Building PDF

```bash
pdflatex slides.tex
```

Or if you're a nix user:

```bash
nix build
```

## Presenting

For the embedded videos to play without using an external player, you can use
[pympress](https://github.com/Cimbali/pympress/) to show the presentation.

Or if you're a nix user, just:

```bash
nix run
```
