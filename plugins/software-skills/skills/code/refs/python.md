# Python Anti-Patterns

- Never use a mutable default argument (`def f(x=[])`) - it is shared across all calls; use `None` and assign inside the body.
- Never use bare `except:` - catch `Exception` or a specific subclass; bare `except:` swallows `KeyboardInterrupt` and `SystemExit`.
- Avoid `import *` - it pollutes the namespace and makes dependency tracking impossible.
- Never use `eval()` or `exec()` with user-supplied input - it is arbitrary code execution.
- Prefer `pathlib.Path` over `os.path` string manipulation for filesystem operations.
- Always use `with` for file and resource management; never call `.close()` manually.
- Do not use `global` or `nonlocal` unless there is no reasonable alternative - they make call sites unpredictable.
- Avoid catching and silently swallowing exceptions; at minimum re-raise or log.
- Do not use `type(x) == Foo` for type checks - use `isinstance(x, Foo)` to respect subclasses.
- Prefer `logging` over `print` for diagnostic output in library or service code.
