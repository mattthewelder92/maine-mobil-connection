# Deployment checklist

## 1. Keep control of every account

Create or use accounts in the business owner's name for GitHub, hosting, Supabase, Stripe, Porkbun and the future Google Play/Apple developer programs. Enable two-factor authentication and save recovery codes.

## 2. Upload this package to GitHub

Extract the ZIP on a computer. In the GitHub repository choose **Add file → Upload files**, then upload the *contents* of `maine-mobil-connection-production` rather than the ZIP itself.

Keep the repository private after the upload. Never commit `.env` files, keys, ID documents, bank details or customer data.

## 3. Deploy a preview

Create a new static-site project in Cloudflare Pages or Vercel from that repository. Confirm the preview works before editing DNS. The current project has no payment processing and no live sign-up, so it is safe to review publicly as a design and information site.

## 4. Connect the domain

Use the DNS records provided by the selected host in Porkbun. Do not remove email records for `support@mainemobilconnection.com`; only add the host records required for the website.

## 5. Add the production backend

Use the SQL schema in `supabase/schema.sql`, then implement and test authentication, uploads, job requests, selected-contractor invitations, bids, contract completion and verified reviews one feature at a time.

## 6. App stores later

Do not submit an app-store build until the web version, legal pages, privacy policy, support process, account deletion process and notification settings are complete. The app-store accounts must be owned by the business, not a site builder.
