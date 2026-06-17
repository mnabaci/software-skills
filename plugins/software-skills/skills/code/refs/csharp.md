# C# Anti-Patterns

- Never use `dynamic` unless interoperating with a COM or dynamic language boundary.
- Avoid catching `Exception` broadly without rethrowing or logging; catch the most specific exception type.
- Do not use `Thread.Sleep` on async code paths; use `await Task.Delay` instead.
- Never use `async void` except for top-level event handlers — it swallows exceptions.
- Avoid mutable public fields; expose state through properties with appropriate access modifiers.
- Do not use `var` when the type is not obvious from the right-hand side of the assignment.
- Prefer `IEnumerable<T>` or `IReadOnlyList<T>` over concrete `List<T>` for return types unless mutation is part of the contract.
- Avoid `string` concatenation in loops; use `StringBuilder` or LINQ.
- Never block on async code with `.Result` or `.Wait()` — it can deadlock in synchronization contexts.
