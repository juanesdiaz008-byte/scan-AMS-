-- DAKOTA tournament registration storage for Supabase (Postgres)
-- Run this in Supabase Dashboard > SQL Editor.
-- Public users may INSERT a consented registration, but cannot read, update, or delete entries.
-- Only user IDs explicitly allow-listed in public.tournament_organizers may read registrations.

create table if not exists public.tournament_entries (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  username text not null check (char_length(btrim(username)) between 1 and 24),
  tournament_code text not null check (char_length(btrim(tournament_code)) between 1 and 32),
  declared_platform text not null check (declared_platform in (
    'No indicado',
    'Roblox Player (sitio web)',
    'Aplicación de Roblox para Windows',
    'Dispositivo móvil',
    'Consola',
    'Otra / no estoy seguro'
  )),
  note text check (note is null or char_length(note) <= 300),
  consent boolean not null check (consent = true)
);

create table if not exists public.tournament_organizers (
  user_id uuid primary key references auth.users(id) on delete cascade,
  created_at timestamptz not null default now()
);

alter table public.tournament_entries enable row level security;
alter table public.tournament_organizers enable row level security;

revoke all on public.tournament_entries from anon, authenticated;
revoke all on public.tournament_organizers from anon, authenticated;
grant insert (username, tournament_code, declared_platform, note, consent)
  on public.tournament_entries to anon, authenticated;
grant select on public.tournament_entries to authenticated;
grant select on public.tournament_organizers to authenticated;

 drop policy if exists "Allow consented tournament registration" on public.tournament_entries;
create policy "Allow consented tournament registration"
  on public.tournament_entries for insert to anon, authenticated
  with check (consent = true);

drop policy if exists "Organizers can read tournament registrations" on public.tournament_entries;
create policy "Organizers can read tournament registrations"
  on public.tournament_entries for select to authenticated
  using (exists (
    select 1 from public.tournament_organizers organizer
    where organizer.user_id = (select auth.uid())
  ));

drop policy if exists "Organizers can read their own allow-list entry" on public.tournament_organizers;
create policy "Organizers can read their own allow-list entry"
  on public.tournament_organizers for select to authenticated
  using (user_id = (select auth.uid()));

-- Do not add a public INSERT policy for tournament_organizers. Manage that allow-list
-- from the Supabase SQL Editor using the authenticated user's UUID.
