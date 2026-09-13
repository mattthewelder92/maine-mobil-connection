-- Run this in the Supabase SQL editor after creating a project owned by Maine Mobil Connection.
-- Authentication users are stored by Supabase Auth; do not store passwords in these tables.
create extension if not exists "uuid-ossp";

create type public.user_role as enum ('customer','contractor','admin');
create type public.job_status as enum ('draft','submitted','matched','awarded','in_progress','completed','cancelled');
create type public.bid_status as enum ('submitted','accepted','declined','withdrawn');

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  role public.user_role not null,
  display_name text not null,
  phone text,
  created_at timestamptz not null default now()
);

create table public.businesses (
  id uuid primary key default uuid_generate_v4(),
  owner_id uuid not null references public.profiles(id) on delete cascade,
  business_name text not null,
  description text,
  phone text,
  email text,
  website text,
  city text not null,
  state text not null default 'ME',
  postal_code text not null,
  service_categories text[] not null default '{}',
  service_area_zips text[] not null default '{}',
  price_level smallint check (price_level between 1 and 4),
  verified boolean not null default false,
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table public.job_requests (
  id uuid primary key default uuid_generate_v4(),
  customer_id uuid not null references public.profiles(id) on delete cascade,
  title text not null,
  service_category text not null,
  description text not null,
  postal_code text not null,
  timing text,
  budget_range text,
  serious_confirmed boolean not null default false,
  status public.job_status not null default 'submitted',
  created_at timestamptz not null default now()
);

create table public.job_photos (
  id uuid primary key default uuid_generate_v4(),
  job_id uuid not null references public.job_requests(id) on delete cascade,
  storage_path text not null,
  created_at timestamptz not null default now()
);

create table public.job_invites (
  job_id uuid not null references public.job_requests(id) on delete cascade,
  business_id uuid not null references public.businesses(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (job_id,business_id)
);

create table public.bids (
  id uuid primary key default uuid_generate_v4(),
  job_id uuid not null references public.job_requests(id) on delete cascade,
  business_id uuid not null references public.businesses(id) on delete cascade,
  amount numeric(12,2),
  message text not null,
  status public.bid_status not null default 'submitted',
  created_at timestamptz not null default now(),
  unique(job_id,business_id)
);

create table public.reviews (
  id uuid primary key default uuid_generate_v4(),
  job_id uuid not null unique references public.job_requests(id) on delete cascade,
  business_id uuid not null references public.businesses(id) on delete cascade,
  customer_id uuid not null references public.profiles(id) on delete cascade,
  rating numeric(2,1) not null check (rating >= 1 and rating <= 5.5),
  pricing_fair boolean,
  final_cost numeric(12,2),
  comment text,
  created_at timestamptz not null default now()
);

alter table public.profiles enable row level security;
alter table public.businesses enable row level security;
alter table public.job_requests enable row level security;
alter table public.job_photos enable row level security;
alter table public.job_invites enable row level security;
alter table public.bids enable row level security;
alter table public.reviews enable row level security;

create policy "Public can read active verified businesses" on public.businesses for select using (active = true and verified = true);
create policy "Owners manage their profile" on public.profiles for all using (auth.uid() = id) with check (auth.uid() = id);
create policy "Business owners manage their business" on public.businesses for all using (auth.uid() = owner_id) with check (auth.uid() = owner_id);
create policy "Customers manage their jobs" on public.job_requests for all using (auth.uid() = customer_id) with check (auth.uid() = customer_id);
create policy "Public can read reviews" on public.reviews for select using (true);
