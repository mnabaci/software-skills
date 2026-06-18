# TypeScript Anti-Patterns

- Never use `any`. Use `unknown` for truly unknown types, then narrow with type guards or generics.
- Never use `// @ts-ignore` or `// @ts-expect-error` without a comment explaining why it is unavoidable.
- Never use non-null assertion (`!`) unless you have a guarantee the value cannot be null at that point.
- Never use `Object`, `Function`, or `{}` as types — they defeat the purpose of type safety.
- Avoid type assertions (`as Foo`) when proper generics or type narrowing can resolve the type.
- Prefer `interface` for object shapes and `type` for unions, intersections, and primitives.
- Never use `var`; use `const` by default, `let` only when reassignment is required.
- Avoid enums — prefer `as const` object literals or union types for better tree-shaking and interop.
- Use `satisfies` instead of `as` when you want to validate a value against a type without widening it.
- Prefer `readonly` arrays (`readonly T[]` or `ReadonlyArray<T>`) for data that should not be mutated after creation.
