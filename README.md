# MY7QUOTES | The Unspoken Ethics

> **Hard truths for quiet nights.**
> A digital library of life, love, and the inevitable breakups. Curated for those who prefer truth over comfort.

[**Live Demo**](https://my7quotes.netlify.app/)

---

## 01. Overview
MY7QUOTES is a minimalist, serverless web application designed to archive and present "hard truths." The project focuses on a "Zero Emotion State"—providing resonance through shared human experience rather than traditional motivation.

## 02. Technical Architecture
The repository is built with a focus on speed, typography, and secure data handling:

* **Frontend:** HTML5, Tailwind CSS (Utility-first styling).
* **Animations:** GSAP (GreenSock Animation Platform) for fluid transitions and the "Falling Dust" particle engine.
* **Backend:** Supabase (PostgreSQL) for real-time data retrieval.
* **Deployment:** Netlify with secure Environment Variable injection for API protection.
* **Typography:** Inter & Baskervville (Google Fonts).

## 03. Core Features
* **The Archive:** A searchable grid of fragments pulled directly from a Supabase database.
* **Quick Insight:** A random discovery engine for immediate reflection.
* **Responsive Design:** Fully optimized for mobile and desktop "quiet night" viewing.
* **Clipboard Integration:** One-click sharing of specific record fragments.

## 04. Setup & Installation
1. Clone the repository.
2. Create a `quotes` table in a Supabase project with `id` and `content` columns.
3. For local testing, create an `env-config.js` (not included in repo) to store your keys:
   ```javascript
   window.env = {
     SUPABASE_URL: "your_url",
     SUPABASE_ANON_KEY: "your_key"
   };
4. Deploy to Netlify and use Snippet Injection for production keys.

### 📄 License
Distributed under the **Apache License 2.0**.
