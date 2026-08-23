---
name: hallucination-prevention
description: Prevent AI code generation hallucinations by forcing documentation-first verification before writing any code. Use when generating frontend code, API integrations, importing unfamiliar libraries, or creating new functionality.
---

# Hallucination Prevention Protocol

## Trigger

Always activate this skill **before** generating any production code that references:

- Third-party APIs or libraries
- Framework methods/hooks/pipes not in the project's dependency list
- New imports or configurations for tools/frameworks you haven't used extensively
- Any function signature you're not 100% certain about

## Core Rules

### Rule 1: Never Guess - Verify First

For every unfamiliar import, method, or API call the model would generate:

1. **Identify the exact package/library and version** from the project's dependency file (package.json, pubspec.yaml, requirements.txt, build.gradle, etc.)
2. **Fetch the official documentation** using web_fetch on the docs URL (e.g., https://developer.mozilla.org/, https://react.dev/reference/react/)
3. **Extract the actual signature** - confirm the method exists, its exact parameters, return type, and any required options
4. **Only then generate code** using the verified signature

### Rule 2: Dependency Boundary Enforcement

Before suggesting any new import:

1. Check if the package already exists in the project's dependency file
2. If not, verify the package is real by searching https://www.npmjs.com/ or the relevant registry
3. Never invent plausible-sounding package names that have never been published

### Rule 3: Permission to Express Uncertainty

If you cannot verify an API, method, or import from official documentation:

- **Do not generate code that uses it**
- Tell the user explicitly: "I could not verify [API/method]. I recommend checking the docs at [URL] before using this"
- Offer a safe alternative pattern instead of the unverified one

### Rule 4: Version-Specific Accuracy

When generating framework code:

1. Note the framework version from package.json, pubspec.yaml, or project config
2. Fetch docs for **that exact version** - not the latest, not the oldest
3. Flag any patterns that are deprecated in that version versus the current recommended approach

### Rule 5: Import Validation Checklist

Before outputting any code block containing imports, verify each one:

- The import path/pattern exactly matches official docs
- The exported name exists and is spelled correctly (case-sensitive)
- No typos in package names (e.g., react-router-dom not react-route-dom)
- Compatible with the project's framework version

## Output Format for Generated Code

When code is generated under this skill:

- Include a commented reference on each import referencing its docs source URL
- If any import could not be verified, mark it as TODO to verify
- Group imports and add a Verification Summary section at the top listing what was confirmed versus left unverified

## Anti-Patterns to Always Avoid

| Anti-Pattern | Why It's Bad | Correct Approach |
|---|---|---|
| Inventing method names that sound right | Models pattern-match, do not know APIs | Fetch docs first |
| Suggesting packages not in the registry | Phantom packages waste time searching | Check registry URL |
| Using old patterns (class components, render) | Outdated for current framework versions | Use version-appropriate patterns |
| Swapped or missing function parameters | Code looks right but fails at runtime | Verify exact signature |
| Combining APIs that do not work together | Confident but wrong combinations | Check API compatibility docs |
