# Node.js Anti-Patterns

- Never use synchronous fs or crypto methods (`fs.readFileSync`, etc.) on the request path — they block the event loop.
- Do not use `process.exit()` inside request handlers or library code; throw or reject instead.
- Never pass user-supplied input directly into shell commands or SQL queries without explicit sanitization.
- Avoid deeply nested callback chains; use `async`/`await` or Promises consistently.
- Do not log secrets, tokens, or PII — scrub sensitive fields before passing to the logger.
- Never catch and swallow errors silently; at minimum, log and re-throw or pass to `next(err)`.
- Avoid using `require()` dynamically with user-controlled paths — it opens path traversal vectors.
