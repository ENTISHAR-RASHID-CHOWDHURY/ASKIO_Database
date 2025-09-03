-- 1. Create extensions schema (if not exists)
CREATE SCHEMA IF NOT EXISTS extensions;

-- 2. Enable pgcrypto (UUID generation)
CREATE EXTENSION IF NOT EXISTS pgcrypto SCHEMA extensions;

-- 3. Enable pgvector (vector storage)
CREATE EXTENSION IF NOT EXISTS vector SCHEMA extensions;

-- USERS
create table users (
    id uuid primary key default gen_random_uuid(),
    email text unique not null,
    name text,
    password_hash text not null,
    created_at timestamp default now()
);

-- CHAT SESSIONS
create table chat_sessions (
    id uuid primary key default gen_random_uuid(),
    user_id uuid references users(id) on delete cascade,
    title text,
    is_active boolean default true,
    created_at timestamp default now()
);

-- MESSAGES
create table messages (
    id uuid primary key default gen_random_uuid(),
    chat_id uuid references chat_sessions(id) on delete cascade,
    role text check (role in ('user','assistant')) not null,
    content text not null,
    created_at timestamp default now(),
    citation jsonb
);

-- DOCUMENT COLLECTIONS
create table collections (
    id uuid primary key default gen_random_uuid(),
    owner_id uuid references users(id) on delete cascade,
    name text not null,
    visibility text check (visibility in ('private','public')) default 'private',
    created_at timestamp default now()
);

-- DOCUMENTS
create table documents (
    id uuid primary key default gen_random_uuid(),
    collection_id uuid references collections(id) on delete cascade,
    filename text not null,
    file_url text,
    file_type text,
    uploaded_at timestamp default now()
);

-- EMBEDDINGS
create table document_embeddings (
    id uuid primary key default gen_random_uuid(),
    document_id uuid references documents(id) on delete cascade,
    embedding vector(1536),
    chunk_index int,
    text_chunk text not null
);

-- SHARED CHATS
create table shared_chats (
    id uuid primary key default gen_random_uuid(),
    chat_session_id uuid references chat_sessions(id) on delete cascade,
    shared_with_user_id uuid references users(id) on delete cascade,
    can_edit boolean default false,
    shared_at timestamp default now()
);