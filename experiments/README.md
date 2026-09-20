# Experiments

Experiments answer focused questions that reduce risk in a larger project. They are not random projects added only to increase a count.

## Naming

Use a dated folder with a short purpose:

```text
YYYY-MM-DD-short-experiment-name/
```

## Required contents

Each experiment should include a README based on [the build-log template](../docs/BUILD_LOG_TEMPLATE.md), plus only the code, diagrams, media, and data needed to reproduce the result.

## Good experiment questions

- Can two selected devices reconnect within five seconds?
- What is the measured input latency over a supported protocol?
- Can a deliberate input be detected in 9 of 10 trials?
- How often does the system activate when the user gives no command?
- Does the power supply remain within limits under peak load?

## Completion rule

An experiment is complete when it produces a documented decision, including a failed result. Failure that prevents wasted work is useful engineering evidence.
