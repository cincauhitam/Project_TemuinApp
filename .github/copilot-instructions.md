# Project Copilot Instructions

## Active Skills

The following custom skills are active for this workspace. They will be loaded automatically when their triggers match your requests:

- **flutter-validation** (`skills/flutter-validation/SKILL.md`) — Validates Flutter/Dart code generation against official framework docs and project constraints. Activates when building widgets, managing dependencies, configuring AGP/Gradle, writing Dart-specific code, or updating framework versions.
- **hallucination-prevention** (`skills/hallucination-prevention/SKILL.md`) — Prevents AI code generation hallucinations by forcing documentation-first verification before writing any code. Activates when generating frontend code, API integrations, importing unfamiliar libraries, or creating new functionality.

## Flutter Project Rules

- This is a Flutter/Dart project (`project_flutter`).
- When adding dependencies, verify them on pub.dev and check compatibility with the project's SDK version (dart: ^3.9.2).
- Always follow null-safe Dart patterns from the start.
- For any new widget or API usage, verify against official Flutter docs before generating code.
