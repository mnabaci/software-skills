# React Anti-Patterns

- Never use class components; use function components with hooks.
- Never mutate state directly; always use the setter from `useState` or dispatch from `useReducer`.
- Do not use `useEffect` to sync derived state — compute it inline or with `useMemo`.
- Never pass an object literal or inline function as a prop to a memoized component without wrapping it in `useMemo`/`useCallback`.
- Do not spread all props onto DOM elements (`<div {...props}>`); this leaks non-DOM attributes and defeats prop typing.
- Avoid using array index as a `key` prop when the list can reorder or items can be added/removed.
- Do not fetch data inside a render or without cleanup in `useEffect`.
- Avoid deeply nested component trees inside a single file; extract sub-components when a component exceeds ~100 lines.
