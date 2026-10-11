# Rajdeep Mandal (RJD) — Portfolio Website

Personal portfolio for **Rajdeep Mandal** (aka **RJD**) — Class 9 student (~16),
cricket all-rounder (batting & bowling), philosophy & sports enthusiast.

**Live target:** `rajdeep.wedigitalmitra.com`

## Stack

- **Pure static site** — HTML + CSS + JS, **zero build dependencies** (no npm, no Node, no framework).
  This keeps builds instant and avoids all VM/sandbox package-manager issues.
- Brand palette: WDM **Deep Navy `#0F2D52`** + **Saffron Amber `#F29318`**.
- Fonts: Poppins (display) + Inter (body) via Google Fonts CDN with system-font fallback.
- Mobile-first responsive, dark navy hero with floating sport emojis, scroll-reveal
  cards, sticky nav with mobile hamburger menu.

## Project structure

```
rajdeep-portfolio/
├── src/                    # editable source
│   ├── index.html          # all content (Hero, About, Interests, Education, Contact)
│   ├── css/styles.css
│   └── js/main.js
├── public/
│   └── images/
│       └── profile.jpg     # ★ THE swappable photo asset (see below)
├── dist/                   # build output (generated — deploy THIS)
├── build.sh                # build script
├── vercel.json             # Vercel static config
└── README.md
```

## Build

```bash
cd ~/workspace/rajdeep-portfolio
./build.sh
```

- Cleans and regenerates `dist/`: copies `src/` → `dist/`, copies
  `public/images/*` → `dist/images/`.
- Validates that required files exist, warns if a photo/email placeholder leaked,
  reports file count + total size.

## Preview locally

```bash
python3 -m http.server 8080 --directory ~/workspace/rajdeep-portfolio/dist
# open http://localhost:8080
```

## Deploy

`dist/` is plain static files — any of these work:

| Host | How |
|---|---|
| **Vercel** | `vercel --prod` from project root (config in `vercel.json`; build = `./build.sh`, output = `dist/`) — set custom domain `rajdeep.wedigitalmitra.com` in dashboard |
| Netlify / Cloudflare Pages / GitHub Pages | drag-and-drop or CI pointing at `dist/` |
| Any web server (Nginx/Apache) | copy `dist/` contents to the web root |

## Swapping the profile photo (one-file operation)

1. Replace `public/images/profile.jpg` with the new photo (keep the same filename).
2. Re-run `./build.sh` — the new photo lands in `dist/images/profile.jpg` automatically.

> **Note (2026-10-11):** the current `profile.jpg` appears to be a childhood photo,
> not a current photo of a 16-year-old. Swap in a recent photo when available.
> The `<img>` tag in `src/index.html` (hero section) references `images/profile.jpg`
> with a comment marking it as the single swappable asset.

## Content placeholders

Clearly marked `[PLACEHOLDER: ...]` comments remain for content not yet available:

- `[PLACEHOLDER: social links]` — social media URLs (Contact section)
- `[PLACEHOLDER: bio]` — real bio paragraph (About)
- `[PLACEHOLDER: school name]` — school name (Education)
- `[PLACEHOLDER: cricket details]`, `[PLACEHOLDER: philosophy details]`,
  `[PLACEHOLDER: sports details]` — interest details (Interests)

Real data used: name "Rajdeep Mandal", aka "RJD", Class 9, ~16, interests
Cricket (batting, bowling) / Philosophy / Sports, email
**rajdeep@wedigitalmitra.com** (mailto links in Contact + Quick Facts).
No other personal details have been invented.
