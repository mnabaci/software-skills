# C++ Anti-Patterns

- Never use raw owning pointers (`new`/`delete`) - use `std::unique_ptr` or `std::shared_ptr`; prefer `unique_ptr` unless shared ownership is genuinely required.
- Avoid `reinterpret_cast` without a comment explaining why it is safe and unavoidable.
- Never use `using namespace std` in a header file - it leaks into every translation unit that includes it.
- Prefer `std::array<T, N>` over C-style arrays; prefer `std::span` for non-owning views of contiguous data.
- Mark every function `const` that does not modify observable state; mark every parameter `const` that is not written to.
- Do not return raw pointers or references to local variables or temporaries.
- Avoid `std::endl` in hot paths - it flushes the buffer; use `'\n'` instead.
- Never ignore the return value of `[[nodiscard]]` functions, especially error codes and `std::expected`.
- Prefer RAII wrappers for any resource (locks, handles, sockets) - never acquire and release manually around non-trivial logic.
- In real-time or embedded contexts: avoid dynamic allocation (`new`/`malloc`) on the hot path, avoid exceptions if they are disabled, and prefer fixed-size containers over `std::vector` where allocation timing matters.
