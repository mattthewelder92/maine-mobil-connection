# Maine Mobil Connection — Production Package

This package is the independent production replacement for the Floot demo.

## Ownership

- **Domain:** mainemobilconnection.com (Porkbun)
- **Source code:** GitHub repository owned by mattthewelder92
- **Hosting:** Cloudflare Pages or Vercel account owned by the business
- **Data, accounts and photo storage:** Supabase account owned by the business
- **Payments:** Stripe account owned by the business
- **Support email:** support@mainemobilconnection.com

No credentials, tax documents, customer photos, or Stripe secret keys are stored in this project.

## Production scope

1. Public service search by ZIP code and 60-mile range
2. Contractor listings and shareable digital business cards
3. Customer/contractor account creation and confirmation email
4. Customer job requests with photos, timing, budgets and serious-lead checks
5. Contractor quote requests, bids, contract acceptance and verified reviews
6. Public opportunity feed with source links and visible last-checked time
7. Dealer and supplier directory
8. Stripe only for platform fees or promoted listings after the business bank is approved

## Implementation order

The public website and navigation come first. The next delivery adds the Supabase schema and authentication, followed by jobs, bids, reviews, source-backed opportunities and payments. The demo content will not be treated as real production listings.

## Run the public site

This first delivery is a static, mobile-first public site. It needs no build step.

1. Upload the contents of this folder to a GitHub repository.
2. In a hosting account you own, create a static-site project from that repository.
3. Set the site root to the repository root and publish directory to `/`.
4. Connect `mainemobilconnection.com` only after the preview looks correct.

## Turn on real accounts and data

1. Create a Supabase project owned by the business.
2. Run `supabase/schema.sql` in its SQL editor.
3. Create a storage bucket named `job-photos` and configure its upload policies.
4. Put the project URL and **anon** key (never a service-role key) in `config.js`.
5. Replace the temporary UI notices in `app.js` with Supabase Auth and database calls.

The current pages intentionally do not pretend that account creation, job submission, uploads, bids, or payments are live until those services are actually connected.

## Before enabling payments

- Finish Stripe tax verification with the exact IRS legal name.
- Wait for the business bank account to be approved and connect it to Stripe.
- Create clear Terms of Use, Privacy Policy, contractor rules and fee disclosures.
- Test a real account confirmation email, job request, photo upload and completed-job review.
