# Contributing to DataMapper

Thank you for your interest in contributing to DataMapper!

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR_USERNAME/DataMapper.git`
3. Create a feature branch: `git checkout -b feature/your-feature-name`
4. Make your changes
5. Test your changes locally
6. Commit with descriptive messages
7. Push to your fork
8. Create a Pull Request

## Development Setup

### Prerequisites
- Docker and Docker Compose v2
- Git
- Text editor

### Local Development

```bash
git clone https://github.com/Buerostack/DataMapper.git
cd DataMapper
docker compose up -d --build datamapper
```

## Project Structure

- `DSL/` - Handlebars template files
- `lib/` - Helper functions
- `server.js` - Main application server
- `docs/` - Documentation
- `examples/` - Working code examples

## Code Standards

### DSL Files
- Place templates in `DSL/<project>/<view>.hbs`
- Use meaningful project and view names
- Add comments for complex logic
- Test templates before committing

### Handlebars Helpers
- Add new helpers to `lib/helpers.js`
- Document helper function parameters
- Include usage examples

## Testing

Before submitting a PR:

1. Test your DSL templates:
```bash
curl -X POST http://localhost:3000/<project>/<view> \
  -H 'Content-Type: application/json' \
  -H 'type: json' \
  -d '{}'
```

2. Check health endpoint:
```bash
curl http://localhost:3000/healthz
```

3. Verify logs for errors:
```bash
docker compose logs -f datamapper
```

## Pull Request Guidelines

- Use clear, descriptive PR titles
- Reference related issues
- Describe what changes were made and why
- Include testing steps
- Update documentation if needed
- Update CHANGELOG.md

## Commit Messages

Follow conventional commit format:
- `feat: add new helper function`
- `fix: resolve template rendering issue`
- `docs: update README with examples`
- `refactor: simplify server initialization`

## Questions?

Open an issue or reach out to the maintainer.

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.
