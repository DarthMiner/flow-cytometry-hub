# Flow Cytometry Hub — Project Guide

## Overview
A comprehensive, static HTML educational website for flow cytometry. No build step, no frameworks, no external dependencies. All CSS and JS are inline per page.

## Live Site
- **URL:** https://flowcytometry.net
- **Hosting:** Railway (auto-deploys on push to `main`)
- **Repo:** https://github.com/DarthMiner/flow-cytometry-hub
- **Analytics:** Google Analytics GA4 — Measurement ID: `G-Q2TCYGV0LY`

## Tech Stack
- **Frontend:** Vanilla HTML, inline CSS, inline JavaScript (no frameworks or libraries)
- **Server:** nginx:alpine Docker container
- **Deployment:** Railway with auto-deploy from GitHub `main` branch
- **Port:** Railway sets `PORT` env variable (currently 8080); `start.sh` injects it into nginx config at runtime

## File Structure (flat — all files at root level)

### Pages (19 HTML files)
| File | Purpose |
|------|---------|
| `index.html` | Homepage hub — links to all sections via anchor IDs (#learning, #usecases, #instruments, #reagents, #protocols) |
| `learn-fluidics.html` | Fluidics & hydrodynamic focusing |
| `learn-optics.html` | Optical systems & detection |
| `learn-compensation.html` | Spectral compensation |
| `learn-data-analysis.html` | Data analysis techniques |
| `usecase-immunophenotyping.html` | Immunophenotyping applications |
| `usecase-cell-cycle.html` | Cell cycle analysis |
| `usecase-apoptosis.html` | Apoptosis detection |
| `usecase-cell-sorting.html` | Cell sorting (FACS) |
| `usecase-ics.html` | Intracellular cytokine staining |
| `usecase-phospho-flow.html` | Phospho-flow cytometry |
| `usecase-microbiology.html` | Microbiology applications |
| `usecase-stem-cells.html` | Stem cell characterization |
| `usecase-platelets-rbc.html` | Platelet & RBC analysis |
| `usecase-clinical-diagnostics.html` | Clinical diagnostics |
| `usecase-drug-discovery.html` | Drug discovery |
| `usecase-environmental.html` | Environmental monitoring |
| `fluorophore-guide.html` | Searchable fluorophore database (100+ dyes, vendor-neutral) |
| `spectrum-viewer.html` | Interactive canvas-based spectrum viewer tool |

### Deployment Files
| File | Purpose |
|------|---------|
| `Dockerfile` | nginx:alpine container — copies HTML files and start.sh |
| `nginx.conf` | Nginx config with gzip, SPA fallback routing (`try_files $uri $uri/ /index.html`) |
| `start.sh` | Startup script — injects Railway's `$PORT` into nginx config via sed, then starts nginx |
| `.gitignore` | Excludes .DS_Store, vim swap files, .env, CLAUDE-PROMPT.md |
| `.dockerignore` | Excludes .git, Dockerfile, markdown files from Docker build |

## Design System

### CSS Variables (defined in every page's `<style>` block)
```css
--primary: #1a5276;        /* Deep blue — headings, nav */
--primary-light: #2980b9;  /* Medium blue — links, buttons */
--primary-dark: #0e2f44;   /* Dark blue — nav background */
--accent: #27ae60;         /* Green — tips, positive info */
--accent-light: #2ecc71;   /* Light green */
--warning: #e67e22;        /* Orange — cautions */
--danger: #e74c3c;         /* Red — alerts, warnings */
--bg: #f4f6f9;             /* Page background */
--bg-card: #ffffff;        /* Card background */
--text: #2c3e50;           /* Body text */
--text-light: #7f8c8d;     /* Secondary text */
--border: #dce1e8;         /* Borders */
--radius: 10px;            /* Border radius */
```

### Font
`'Segoe UI', system-ui, -apple-system, sans-serif`

### Common CSS Classes
- `.top-nav` / `.nav-container` / `.nav-logo` — fixed header navigation
- `.hero` — gradient header sections (each page has unique gradient)
- `.content` — max-width wrapper (1000px for content pages, 1400px for tables)
- `.content-section` — white cards with left colored border (4px)
- `.content-section.accent-1` through `.accent-5` — cycling accent colors (green, orange, red, purple, teal)
- `.tip` / `.caution` / `.key-point` — colored info boxes
- `.data-table` — dark header tables with hover rows
- `.comparison-grid` — CSS Grid auto-fit layout
- `.protocol-card` — collapsible accordion sections
- `.breadcrumb` — navigation breadcrumbs on sub-pages
- `.details-link` — small button-style links
- `.quick-links` / `.quick-link` — prominent navigation buttons

### Responsive Breakpoint
`@media (max-width: 768px)` — reduces font sizes, padding, switches to single column

## Page Architecture Patterns

### Sub-page template (learn-* and usecase-* pages):
1. `<head>` with GA4 script, inline `<style>` with full design system
2. `.top-nav` with logo + "Back to Main" link
3. `.breadcrumb` navigation
4. `.hero` with gradient background and page title
5. `.content` wrapper with multiple `.content-section` cards
6. Info boxes (`.tip`, `.caution`, `.key-point`) for callouts
7. `.data-table` for structured data
8. Footer with links

### Adding a new page:
1. Copy any existing `learn-*.html` or `usecase-*.html` as a template
2. The full CSS design system is inline in each page (no external stylesheet to import)
3. Keep the same nav structure with "Back to Main" link
4. Add GA4 script in `<head>` (same snippet as all other pages)
5. Add a link card on `index.html` in the appropriate section
6. Commit and push — Railway auto-deploys

## Interactive Tools

### spectrum-viewer.html
- **Canvas-based** spectrum visualization using HTML5 Canvas 2D API
- **~100 fluorophores** in the `FLUOROPHORES` array, each with: `name`, `exMax`, `emMax`, `laser`, `color`, `type`, `vendor`, `exWidth`, `emWidth`
- **Gaussian curve modeling** for excitation/emission spectra
- **Laser line categories:** UV (355nm), Violet (405nm), Blue (488nm), Yellow-Green (561nm), Red (633nm)
- **Features:** search filtering, laser-type filtering, multi-select comparison, fill toggle, normalization modes, laser line overlay, tooltip on hover, info table
- **Layout:** CSS Grid — 320px sidebar + flexible chart area
- **Known issue:** viewport fitting — uses JS `setAppHeight()` to calculate available height dynamically. May need further testing on different screen sizes.

### fluorophore-guide.html
- **Searchable database** of 100+ fluorophores organized by laser line
- **12 sections:** Overview, UV/Violet/Blue/YG/Red laser dyes, Viability dyes, Tandem dyes, Brightness guide, Cross-vendor equivalents, Spectrum tool link, Troubleshooting
- **Vendor badges** with colors: Thermo Fisher (green), BD (blue), BioLegend (purple), Beckman Coulter (orange), Cytek (teal), Bio-Rad (pink), Sony (purple), Miltenyi (blue)
- **Brightness ratings** using a 5-dot indicator system

## Google Analytics

Every HTML file includes this identical snippet at the top of `<head>`:
```html
<!-- Google Analytics (GA4) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-Q2TCYGV0LY"></script>
<script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag("js", new Date());
    gtag("config", "G-Q2TCYGV0LY");
</script>
```

When adding new pages, always include this snippet.

## Deployment Workflow

```bash
# Make changes locally, then:
git add <changed-files>
git commit -m "Description of changes"
git push
# Railway auto-deploys from main branch in ~30-60 seconds
```

## Future Plans (not yet implemented)
- **Giscus integration** — GitHub Discussions-powered Q&A/comments (requires public repo + HTTPS, both ready)
- **Community Q&A page** — dedicated page for user-submitted questions
- **Spectrum viewer layout refinement** — sidebar scrolling may need further testing on various viewport sizes
