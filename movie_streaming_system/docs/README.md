# 🎬 Movie Streaming System

![Database Schema](/movie_streaming_system/docs/ER_Diagram.png)

A comprehensive movie streaming platform with user profiles, content management, and subscription billing.

## 📋 Table of Contents
- [Features](#-features)
- [Database Schema](#-database-schema)
- [Tech Stack](#-tech-stack)
- [Setup](#-setup)
- [API Endpoints](#-api-endpoints)
- [License](#-license)

## ✨ Features
- **User Management**: Registration, authentication, and profile customization
- **Multi-Profile System**: Up to 4 profiles per account (Adult/Child/Guest)
- **Content Catalog**: Movies with genres, ratings, and actor information
- **Watch Tracking**: Resume playback from last watched position
- **Subscription Plans**: Monthly/Yearly billing with tiered privileges
- **Admin Dashboard**: Full system management capabilities

## 🗄️ Database Schema

### Core Entities
| Entity          | Description                          | Key Attributes                     |
|-----------------|--------------------------------------|------------------------------------|
| `User`          | Registered account                   | id, email, password, created_at   |
| `Profile`       | Viewing profile (max 4 per user)     | id, name, type (Child/Adult/Guest)|
| `Movie`         | Streaming content                    | id, title, year, duration, rating |
| `Billing`       | Subscription plan                    | id, plan_type, privilege_level    |

### Key Relationships
```mermaid
erDiagram
    USER ||--o{ PROFILE : "1 to 4"
    USER ||--o| BILLING : "1 to 1"
    PROFILE ||--o{ WATCH_HISTORY : "1 to many"
    MOVIE }|--|| GENRE : "many to 1"
    MOVIE }|--o{ ACTOR : "many to many"