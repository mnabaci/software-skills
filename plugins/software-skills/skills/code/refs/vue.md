# Vue Anti-Patterns

- Never mutate props directly; emit an event to the parent instead.
- Do not use `$parent` or `$children` to access component internals; use `emit`/`provide`/`inject` or a store.
- Avoid using `v-html` with user-supplied content — it opens XSS vectors.
- Never mix the Options API and Composition API in the same component without a strong reason.
- Do not use `watch` to sync derived state; use `computed` instead.
- Avoid using array index as the `:key` in `v-for` when the list can reorder or items can be added/removed.
- Do not access reactive state outside the setup lifecycle without `toRef` or `toRefs`.
