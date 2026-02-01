# Contributing to Project Anbang

Thank you for your interest in contributing to Project Anbang!

## Code of Conduct

- Be respectful and inclusive
- Focus on academic rigor
- Cite sources for all claims

## How to Contribute

### Reporting Bugs

Use the GitHub issue tracker with the bug report template.

### Suggesting Features

Open an issue with the feature request template.

### Code Contributions

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes
4. Write/update tests
5. Ensure CI passes: `./scripts/run-tests.sh`
6. Commit: `git commit -m 'Add amazing feature'`
7. Push: `git push origin feature/amazing-feature`
8. Open a Pull Request

### Code Style

**C++:**

- Follow Google C++ Style Guide
- Use `clang-format` (config provided)

**TypeScript:**

- Use Prettier (config provided)
- Follow Airbnb style guide

**Python:**

- Follow PEP 8
- Use `black` for formatting

### Commit Messages

```
type(scope): subject

body

footer
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

Example:

```
feat(engine): add plague transmission model

Implement SIR model for epidemic simulation based on
Kermack-McKendrick (1927).

Refs: #42
```

## Academic Contributions

### Adding Historical Data

1. Place CSV in `calibration/data/`
2. Document sources in `docs/theory/references.bib`
3. Add validation test

### Improving Models

1. Cite peer-reviewed sources
2. Add mathematical derivation to docs
3. Validate against historical data

## Questions?

Open a discussion in GitHub Discussions or email voyager.lpq@gmail.com.
