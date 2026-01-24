# Contributing to DDGS

Thank you for your interest in contributing to DDGS! We welcome contributions from the community.

## How to Contribute

### Reporting Issues

- Check if the issue already exists
- Use a clear and descriptive title
- Provide detailed reproduction steps
- Include code samples if applicable
- Specify your Dart version and OS

### Submitting Changes

1. **Fork the repository**
   ```bash
   git clone https://github.com/kamranxdev/ddgs.git
   cd ddgs
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Install dependencies**
   ```bash
   dart pub get
   ```

4. **Make your changes**
   - Write clear, documented code
   - Follow the existing code style
   - Add tests for new features
   - Update documentation

5. **Run tests and checks**
   ```bash
   # Format code
   dart format .
   
   # Analyze code
   dart analyze
   
   # Run tests
   dart test
   ```

6. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

   Use conventional commits:
   - `feat:` New feature
   - `fix:` Bug fix
   - `docs:` Documentation changes
   - `test:` Test updates
   - `refactor:` Code refactoring
   - `style:` Formatting changes
   - `chore:` Maintenance tasks

7. **Push and create a pull request**
   ```bash
   git push origin feature/your-feature-name
   ```

## Code Style Guidelines

- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused
- Prefer composition over inheritance
- Use `const` constructors where possible
- Add trailing commas for better formatting

## Project Structure

```
ddgs/
├── lib/
│   ├── ddgs.dart                    # Main library export
│   └── src/
│       ├── ddgs_base.dart          # Core DDGS class
│       ├── base_search_engine.dart # Base engine interface
│       ├── exceptions.dart         # Custom exceptions
│       ├── http_client.dart        # HTTP client wrapper
│       ├── results.dart            # Result models
│       ├── utils.dart              # Utility functions
│       └── engines/                # Search engine implementations
│           ├── duckduckgo.dart
│           ├── bing.dart
│           ├── brave.dart
│           └── ...
├── bin/
│   └── ddgs.dart                   # CLI implementation
├── test/
│   ├── unit/                      # Unit tests (mocks)
│   ├── integration/               # Integration tests (live API)
│   ├── mocks/                     # Shared mocks
│   └── fixtures/                  # Test data files
└── example/
    └── example.dart               # Usage examples
```

## Adding a New Search Engine

1. Create a new file in `lib/src/engines/`
2. Extend `BaseSearchEngine` class
3. Implement required methods
4. Add to `engines.dart` factory
5. Add tests
6. Update documentation

Example:

```dart
import '../base_search_engine.dart';

class NewEngine extends BaseSearchEngine {
  @override
  String get name => 'newengine';

  @override
  Future<List<Map<String, dynamic>>> search(String query, {
    int? maxResults,
    // other parameters
  }) async {
    // Implementation
  }
}
```

## Testing

We use `mocktail` for mocking and separate unit tests from integration tests.

- **Unit Tests**: Place in `test/unit/`. These should be fast, deterministic, and mock all external dependencies (HTTP calls).
- **Integration Tests**: Place in `test/integration/`. These interact with real APIs and should be marked with `skip` by default or tagged.

```dart
// Example Unit Test
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import '../mocks/mock_http_client.dart';

void main() {
  group('Feature', () {
    test('unit test using mocks', () {
      final mock = MockClient();
      // ...
    });
  });
}
```

## Documentation

- Update README.md for user-facing changes
- Add dartdoc comments for public APIs
- Include code examples
- Update CHANGELOG.md

Example documentation:

```dart
/// Searches for text content across multiple search engines.
///
/// The [query] parameter specifies the search terms.
/// Returns a list of search results as maps containing title, URL, and description.
///
/// Example:
/// ```dart
/// final results = await ddgs.text('Dart programming', maxResults: 5);
/// ```
Future<List<Map<String, dynamic>>> text(String query, {int? maxResults});
```

## Pull Request Process

1. Ensure all tests pass
2. Update documentation
3. Add entry to CHANGELOG.md
4. Request review from maintainers
5. Address review feedback
6. Squash commits if requested

## Code of Conduct

- Be respectful and inclusive
- Welcome newcomers
- Give constructive feedback
- Focus on the code, not the person
- Assume good intentions

## Need Help?

- 📖 Read the [README](README.md)
- 🐛 Check [existing issues](https://github.com/kamranxdev/ddgs/issues)
- 💬 Start a [discussion](https://github.com/kamranxdev/ddgs/discussions)
- 📧 Contact maintainers

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to DDGS! 🎉
