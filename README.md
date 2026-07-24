# JuquiAmbiental Static Site

Static version of the JuquiAmbiental page built with [Hugo](https://gohugo.io/).

## Local development

Install Hugo, then run:

```bash
make install-hugo
```

Start the local server:

```bash
make serve
```

Build the site into `public/`:

```bash
make build
```

## GitHub Pages

The `.github/workflows/pages.yml` workflow builds Hugo and deploys the generated `public/` directory with GitHub Pages Actions.

Before the first deploy, open the repository on GitHub and set **Settings > Pages > Source** to **GitHub Actions**.

The custom domain file is at `static/CNAME` and contains:

```text
juquiambiental.com
```

For GitHub Pages using a custom Actions workflow, also set `juquiambiental.com` in **Settings > Pages > Custom domain**. For the apex domain, configure your DNS provider with GitHub Pages `A` records. Add a `www` CNAME only if you also want `www.juquiambiental.com`.

## Static build branch

The `.github/workflows/static-branch.yml` workflow builds the same Hugo site and pushes only the generated static files to a branch.

Defaults:

```text
branch: static-build
base_url: https://juquiambiental.com/
```

You can run it manually from GitHub Actions and change the branch or base URL. This is useful when a separate static webserver pulls prebuilt HTML/CSS/images from a branch instead of running Hugo.

## Articles

Add articles as Markdown files under `content/artigos/`.

Example:

```text
content/artigos/nome-do-artigo.md
```

Each article appears in three places:

- the article cards on the home page;
- the `/artigos/` listing page;
- its own URL, such as `/artigos/nome-do-artigo/`.

## Contact form

Static hosting cannot process form submissions by itself. The page keeps the contact form markup ready, but you need to configure a hosted form endpoint.

Recommended low-friction options:

- Formspree: create a form and paste its endpoint into `params.form_endpoint` in `hugo.yaml`.
- Basin: similar hosted endpoint model with spam protection and integrations.
- Netlify Forms: easiest if you host the site on Netlify; it detects annotated static HTML forms.
- Self-hosted/API option: use a Cloudflare Worker, AWS Lambda, or small API endpoint that accepts `POST` and sends email or writes to a sheet/CRM.

Example:

```yaml
params:
  form_endpoint: "https://formspree.io/f/your-form-id"
```
