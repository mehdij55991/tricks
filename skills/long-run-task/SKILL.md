---
name: long-run-task-monitor
description: Use when launching a long-running or potentially long-running task. Poll its status at a reasonable interval to confirm it's still making progress, rather than waiting indefinitely. Detects stalls, hangs, and silent failures, and avoids flooding context with per-poll logs.
---
