-- Schéma appliqué au projet dédié TechTalk Revision.
create table public.revision_events (
 id uuid primary key,
 user_id uuid not null references auth.users(id) on delete cascade,
 at timestamptz not null,
 payload jsonb not null check (jsonb_typeof(payload) = 'object' and octet_length(payload::text) < 200000),
 created_at timestamptz not null default now()
);
create index revision_events_owner_at on public.revision_events(user_id, at, id);
alter table public.revision_events enable row level security;
grant select, insert on public.revision_events to authenticated;
revoke all on public.revision_events from anon;
create policy own_revision_events_read on public.revision_events for select to authenticated using ((select auth.uid()) = user_id);
create policy own_revision_events_insert on public.revision_events for insert to authenticated with check ((select auth.uid()) = user_id);
