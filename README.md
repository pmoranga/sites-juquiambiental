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

## Cloudflare Pages

Cloudflare Pages builds the Hugo source directly from the Git repository. Create
a Git-integrated Pages project with these settings:

| Setting | Value |
| --- | --- |
| Production branch | `main` |
| Framework preset | `Hugo` |
| Build command | `make build-cloudflare` |
| Build output directory | `public` |
| Root directory | `/` (repository root) |

Add this environment variable to both the Production and Preview environments:

```text
HUGO_VERSION=0.164.0
```

The Cloudflare build target uses `https://juquiambiental.com/` as the canonical
production URL and the deployment-specific `CF_PAGES_URL` for branch previews.
Local builds use the production URL.

After the first deployment succeeds, add `juquiambiental.com` under the Pages
project's **Custom domains** tab. Because this is an apex domain, the domain must
be an active zone in the same Cloudflare account and use Cloudflare nameservers.
Cloudflare will create the DNS record and TLS certificate during activation.

Cloudflare rebuilds the production site whenever `main` is updated and creates
preview deployments for other branches and pull requests.

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

Static hosting cannot process form submissions by itself. When `params.form_endpoint` is empty, the page opens the visitor's mail app with the form fields prefilled in a new email. For a better user experience, configure a hosted HTTPS form endpoint.

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
