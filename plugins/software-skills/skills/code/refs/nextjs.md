# Next.js Anti-Patterns

- Never add `"use client"` to a component by reflex - components are server by default and server components are cheaper; only mark client when you need hooks, event handlers, or browser APIs.
- Do not use `getServerSideProps` or `getStaticProps` in the App Router - they do not exist there; use `async` server components with `fetch` instead.
- Never call `fetch` in a server component without an explicit cache strategy (`cache: 'no-store'` or `next: { revalidate: N }`) - the default behavior changed across versions (cached by default pre-15, uncached by default in 15+), so being explicit avoids surprises either way.
- Do not use `<img>` for images - use `next/image` to get automatic optimization, lazy loading, and CLS prevention.
- Avoid `useRouter().push()` for navigation when a `<Link>` component suffices - `<Link>` prefetches automatically.
- Never put secrets in `NEXT_PUBLIC_` env vars - they are inlined into the client bundle and publicly visible.
- Do not import server-only modules (database clients, `fs`, etc.) into `"use client"` components - it will either fail at build time or leak server logic to the client.
- Avoid deeply nested route groups that exist only for URL aesthetics; prefer flat routes for maintainability.
