# ASKIO Database

## Overview

This repository contains the **fully ready database schema** for **ASKIO**, a Flutter-based Android app with RAG-powered chatbot functionality. The database is built using **PostgreSQL with pgvector** for storing embeddings and **pgcrypto** for UUIDs.

It supports the following core features:

* User accounts and authentication
* Chat sessions with messages
* Document collections and documents
* Multi-dimensional embeddings for RAG chatbot
* Sharing chat sessions with other users

---

## Database Features

| Table                 | Description                                                                              |
| --------------------- | ---------------------------------------------------------------------------------------- |
| `users`               | Stores user accounts with UUID, email, name, and password hash.                          |
| `chat_sessions`       | Stores chat sessions for each user.                                                      |
| `messages`            | Stores messages for each chat session with role (user/assistant) and optional citations. |
| `collections`         | Stores document collections (private or public) for users.                               |
| `documents`           | Stores uploaded documents metadata (filename, type, URL).                                |
| `document_embeddings` | Stores embeddings of document chunks using `pgvector`.                                   |
| `shared_chats`        | Stores shared chat sessions between users with permissions.                              |

---

## Getting Started

### 1. Requirements

* **PostgreSQL 14+** (or Supabase)
* **pgvector extension** for embeddings
* **pgcrypto extension** for UUID generation
* Git for version control

### 2. Setup Database

1. **Clone the repository:**

```bash
git clone https://github.com/ENTISHAR-RASHID-CHOWDHURY/askio-database.git
cd askio-database
```

2. **Run the schema file** (`schema.sql`) in your PostgreSQL or Supabase SQL editor:

```sql
-- Paste the schema.sql content in your SQL editor and execute
```

---

## Testing

You can test the database by inserting sample data. Example:

```sql
-- Insert a sample user
INSERT INTO users (email, password_hash, name) VALUES ('test@example.com', 'hashed_password', 'Test User');

-- Insert a chat session
INSERT INTO chat_sessions (user_id, title) VALUES ((SELECT id FROM users LIMIT 1), 'First Chat');

-- Insert a message
INSERT INTO messages (chat_id, role, content) VALUES ((SELECT id FROM chat_sessions LIMIT 1), 'user', 'Hello, ASKIO!');
```

---

## Project Structure

```
ASKIO-database/
│── schema.sql        # Full database schema
│── README.md         # Project overview and instructions
```

---

## Notes

* The database is designed for **Mini Project 3** of ASKIO.
* The **embeddings table** uses vector dimensions of 1536 (can be adjusted).
* Designed to be **ready for backend integration** with Flutter and RAG chatbot features.

---

## License

This project is **open-source**. Feel free to use it for learning.

---
