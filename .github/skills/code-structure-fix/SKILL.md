---
name: code-structure-fix
description: Analyze and refactor messy/disorganized code to follow good coding standards — consistent naming, single-responsibility functions, DRY principle, proper indentation, extracted constants, separated concerns. Use when cleaning up sloppy code structure without changing functionality.
---

# Code Structure Fix Protocol

## Trigger

Activate this skill when the user asks to:

- Clean up messy, disorganized, or poorly-structured code
- Refactor overly long functions or one-line build methods
- Remove magic numbers, magic strings, and magic colors
- Extract repeated logic into constants or helper classes
- Break large widgets/components into small single-responsibility parts
- Enforce consistent naming, indentation, and formatting conventions
- Separate concerns (UI vs business logic vs data) within a file

## Core Rules

### Rule 1: Analyze Before Refactoring

Before making any changes:

1. Review the code structure and identify all issues (naming, duplication, long functions, magic values, mixed concerns)
2. Present a clear analysis table mapping each issue → example → impact
3. Confirm that no functionality will change — only the structure improves

### Rule 2: Consistent Naming Conventions

- Follow the language/framework convention for naming (e.g., camelCase for Dart/Flutter, PascalCase for classes, snake_case for Python)
- Extract all magic numbers/colors/strings into named constants with clear prefixes (e.g., `k` for constants in Dart)
- Rename methods following framework conventions (e.g., `_buildStatRow` not `_statRow` in Flutter)

### Rule 3: Single Responsibility — Extract Functions and Classes

- Break logic into small functions/methods, each with one clear purpose
- Extract stateful concerns into dedicated helper classes (e.g., timer management → `_ActivityTimer`)
- Extract static data/config into named constants or data classes (e.g., stat rows → `kStaticStats` of `_StatEntry`)

### Rule 4: Expand Collapsed/One-Line Code

- Never leave entire build/render methods on one line
- Use proper indentation matching the language standard (8-space for Dart, 4-space for Python/JS)
- Add section comments to visually group UI/logic sections (e.g., `// ===== Section: Title =====`)
- Use string interpolation (`$variable`) instead of `+` concatenation

### Rule 5: Remove Duplication (DRY Principle)

- Identify repeated values → extract as constants
- Identify repeated patterns → extract as helper functions or reusable widgets/components
- Identify repeated logic → extract into shared methods or classes

### Rule 6: Validate Generated Code

- Run the project's formatter after changes (e.g., `dart_format` for Dart, `black` for Python)
- Check for any linter errors or warnings post-refactor
- Ensure all behaviors are preserved — no functional changes

## Refactoring Checklist

Use this checklist when applying the skill:

- [ ] Analysis table provided before changes
- [ ] All magic numbers/colors/strings extracted to named constants
- [ ] Functions/methods broken into single-responsibility units
- [ ] Stateful logic encapsulated in dedicated helper classes if appropriate
- [ ] One-line/collapsed code expanded with proper indentation
- [ ] Section comments added for visual grouping
- [ ] String interpolation used instead of concatenation where applicable
- [ ] Code formatted with the language's standard formatter
- [ ] No functional behavior changed

## Output Format

When applying this skill, provide:

1. **Analysis** — A table of issues found (Issue | Example | Impact)
2. **Changes Applied** — A numbered list of major changes with explanation for each
3. **Code** — The refactored code only (no diff/showing unless requested)
4. **Verification** — Confirm formatter was run and no errors introduced

## Examples

### Before (Messy)

```dart
@override Widget build(BuildContext context) { return Scaffold(backgroundColor: dark ? Color(0xFF121212) : Colors.white, body: SafeArea(child: Padding(padding: EdgeInsets.all(20), child: Column(children: [Text('SOLO ACTIVITY', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 8), Text('Track your futsal activity alone (futsal only per PRD)', style: GoogleFonts.poppins(fontSize: 13, color: dark ? Colors.white60 : Colors.grey)), Container(width: 280, height: 280, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: accentColor, width: _isActive ? 4 : 2)), child: Center(child: Text(_formatDuration(_elapsedSeconds), style: GoogleFonts.poppins(fontSize: 42, fontWeight: FontWeight.bold, color: accentColor)))), ElevatedButton(onPressed: _isActive ? _endActivity : _startActivity, style: ElevatedButton.styleFrom(backgroundColor: _isActive ? Colors.red : accentColor, padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16)), child: Text(_isActive ? 'End Activity' : 'Start Activity', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold))), ...[_statRow('Total Sessions', '5'), _statRow('Total Time', '4h 32m')]])))); }
```

### After (Cleaned)

- Expanded every widget to its own indented line with section comments
- Extracted `kAccentColor`, `kSpacingSmall/Default/Large`, `kCircularTimerRadius` as constants
- Encapsulated timer logic into `_ActivityTimer` helper class
- Extracted stat data into `kStaticStats` list of `_StatEntry` objects
- Used string interpolation (`'$duration'`) instead of `+` concatenation
- Renamed `_statRow` → `_buildStatRow` (Flutter convention)
