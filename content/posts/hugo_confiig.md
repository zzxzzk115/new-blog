---
date: '2025-11-04T21:04:32Z'
title: 'Hugo PaperMod Customization'
tags: ["Hugo"]
categories: ["Tips"]
summary: How to customize Hugo with theme PaperMod? Here are the instructions.
---

## MathJax

### Step 1

Create `layouts/partials/extend_head.html`:

```html
{{ if or .Params.math .Site.Params.math }}
<script>
  MathJax = {
    tex: {
      inlineMath: [['\\(', '\\)'], ['$', '$']],
      displayMath: [['$$', '$$'], ['\\[', '\\]']],
      processEscapes: true,
      processEnvironments: true
    },
    options: {
      skipHtmlTags: ['script', 'noscript', 'style', 'textarea', 'pre']
    }
  };
</script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
{{ end }}
```

### Step 2

Create `layouts/_default/baseof.html`:

```html
{{ partial "extend-head.html" . }}
```

### Step 3

Edit `hugo.yaml`, add `markup->goldmark` section and enable math:

```yaml
markup:
  goldmark:
    renderer:
      unsafe: true
    extensions:
      passthrough:
        delimiters:
          block:
          - - \[
            - \]
          - - $$
            - $$
          inline:
          - - \(
            - \)
          - - $
            - $
        enable: true

params:
  math: true
```

## Favicon

https://favicon.io/emoji-favicons/

Put images into `static/images/favicon/`

Edit `hugo.yaml`:

```yaml
params:
  assets:
      favicon: "images/favicon/favicon.ico"
      favicon16x16: "images/favicon/favicon-16x16.png"
      favicon32x32: "images/favicon/favicon-32x32.png"
      apple_touch_icon: "images/favicon/apple-touch-icon.png"
      # safari_pinned_tab: "images/favicon/safari-pinned-tab.svg"
```