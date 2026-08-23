---
name: flutter-validation
description: Validate Flutter/Dart code generation against official framework docs and project constraints. Use when building widgets, managing dependencies, configuring AGP/Gradle, writing Dart-specific code, or updating framework versions.
---

# Flutter/Dart Validation Protocol

## Trigger

Activate this skill before generating any Flutter/Dart code that involves:

- Building or modifying widgets (StatelessWidget, StatefulWidget, custom widgets)
- Adding or updating dependencies in pubspec.yaml
- Configuring AGP, Gradle, or native Android/iOS project files
- Using third-party packages (plugins from pub.dev)
- Framework API calls (Flutter core APIs, dart: libraries)
- State management patterns (Provider, Riverpod, Bloc, GetX, etc.)
- Platform channel code or method channels

## Core Rules

### Rule 1: Widget Constructor Validation

Before outputting any widget with a constructor:

1. Check if the widget exists in the current Flutter SDK version
2. Verify each named parameter against official docs (https://api.flutter.dev/)
3. Never invent widget properties that "look right" - many Flutter widgets accept very specific parameter names (e.g., mainAxisAlignment not mainAlignment)
4. Confirm required vs optional parameters

### Rule 2: Package and Dependency Validation

When suggesting or modifying pubspec.yaml dependencies:

1. Verify the package exists on https://pub.dev/ using web_fetch
2. Check that the suggested version is compatible with the project's Flutter SDK version (check flutter --version)
3. Validate the import path matches the package's official documentation
4. Never suggest packages with fabricated names or wrong pubspec IDs

### Rule 3: Framework Version Awareness

Flutter APIs change between versions. Before generating code:

1. Check flutter --version to get the current SDK version
2. Note the minimum Flutter SDK version constraint in pubspec.yaml (sdk: ">=3.x.x <4.0.0")
3. Fetch docs for that exact SDK version - APIs may differ between 3.x releases
4. Flag deprecated widgets/methods and suggest their modern replacements (e.g. 
ew keyword removal, nullable vs non-nullable migration)

### Rule 4: Dart Language Feature Validation

When using Dart-specific features:

1. Confirm the feature is available in the project's Dart SDK version (check pubspec.yaml sdk constraint)
2. Verify syntax correctness for that language version (null safety, records, patterns, macros are version-dependent)
3. Never use newer Dart features if they exceed the minimum SDK constraint

### Rule 5: AGP/Gradle/Native Configuration Validation

For any Android/iOS native configuration changes:

1. Check compatibility between AGP, Gradle, Kotlin, and Flutter versions using https://docs.flutter.dev/platform-integration
2. Verify AGP version against https://developer.android.com/build/releases/gradle-plugin
3. Cross-reference Gradle wrapper version with AGP minimum requirements
4. Confirm NDK version compatibility when touching native build configs

### Rule 6: Import Path Verification

Before outputting any import statement:

1. The import path must match the package's published structure exactly
2. Example: package:flutter/material.dart - not package:flutter/materials.dart or package:flutter/widgets.dart (unless intentional)
3. For custom packages in monorepos, verify the local package path from the workspace config
4. Check for case sensitivity issues

## Verification Workflow

When generating Flutter code that uses external APIs or libraries:

1. **Step 1:** Identify the exact package and version from pubspec.yaml
2. **Step 2:** Fetch the official docs using web_fetch:
   - Flutter core: https://api.flutter.dev/ (search for the specific widget/class)
   - pub.dev packages: https://pub.dev/packages/[package_name]/versions
3. **Step 3:** Confirm every API call, constructor parameter, and method signature against the fetched docs
4. **Step 4:** If anything cannot be verified, state it clearly instead of guessing

## Flutter-Specific Anti-Patterns to Always Avoid

| Anti-Pattern | Example | Correct Approach |
|---|---|---|
| Invented widget properties |  alignment: CrossAxisAlignment.start | crossAxisAlignment: CrossAxisAlignment.start |
| Wrong parameter types | padding: EdgeInsets(10) | padding: EdgeInsets.all(10) or EdgeInsets.symmetric(vertical: 10) |
| Deprecated constructors | Navigator.push(context, new MaterialPageRoute(...)) | Navigator.of(context).push(MaterialPageRoute(...)) |
| Phantom plugins | Suggesting a package that does not exist on pub.dev | Verify via web_fetch before suggesting |
| Ignoring null safety | Using nullable types without proper checks in Dart 2.12+ | Apply null-safe patterns from the start |
| AGP/Gradle mismatch | AGP 8.12 with Gradle 7.x | Check https://developer.android.com/build/releases/gradle-plugin |
| Wrong Flutter import paths | import 'package:flutter/material' (missing .dart) | import 'package:flutter/material.dart' |

## Output Format for Generated Flutter Code
