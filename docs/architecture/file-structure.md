# DataMapper File Structure

## Directory Layout

```
DataMapper/
├── DSL/                          # Handlebars templates
│   └── <project>/                # Project namespace
│       ├── <view>.hbs            # Template files (mapped to POST /<project>/<view>)
│       └── hbs/<view>.hbs        # Optional fallback path
├── lib/                          # Shared libraries
│   └── helpers.js                # Handlebars custom helpers
├── docs/                         # Documentation
│   ├── architecture/             # Architecture documentation
│   │   ├── overview.md
│   │   ├── data-flow.md
│   │   └── file-structure.md
│   ├── how-to/                   # How-to guides
│   └── reference/                # Reference documentation
├── examples/                     # Runnable code examples
│   └── basic-usage/              # Basic usage example
├── server.js                     # Main Express application
├── package.json                  # Node.js dependencies
├── Dockerfile                    # Container build instructions
├── docker-compose.yml            # Docker Compose configuration
├── README.md                     # Project overview
├── CHANGELOG.md                  # Version history
├── CONTRIBUTING.md               # Contribution guidelines
└── LICENSE                       # License file
```

## File Purposes

### Application Core

#### `server.js`
Main Express application file:
- Initializes Express server
- Configures body-parser middleware
- Sets up Handlebars view engine
- Defines route handlers
- Implements health check endpoint
- Starts HTTP server on port 3000

#### `lib/helpers.js`
Handlebars helper functions:
- Custom data transformation utilities
- Available in all templates via `{{helperName}}`
- Examples: `{{now}}`, `{{{json obj}}}`

### DSL Templates

#### `DSL/<project>/<view>.hbs`
Template files that become REST endpoints:
- **Naming**: File path determines URL
  - `DSL/samples/ping.hbs` → `POST /samples/ping`
  - `DSL/users/list.hbs` → `POST /users/list`
- **Format**: Handlebars template syntax
- **Purpose**: Data transformation and formatting
- **Access**: Receives request body as context

Example structure:
```
DSL/
├── samples/
│   ├── ping.hbs
│   └── transform.hbs
├── users/
│   ├── list.hbs
│   └── detail.hbs
└── admin/
    └── stats.hbs
```

### Configuration Files

#### `package.json`
Node.js project configuration:
- Dependencies (express, handlebars, body-parser)
- Scripts (start command)
- Project metadata

#### `docker-compose.yml`
Docker Compose service definition:
- Container configuration
- Port mappings (3000:3000)
- Volume mounts (./DSL:/app/DSL)
- Health checks

#### `Dockerfile`
Container build instructions:
- Base image: node:alpine
- Working directory: /app
- Dependency installation
- Application setup

### Documentation

#### `README.md`
Project overview and quick start:
- Component description
- Origin and ownership
- Quick start guide
- Usage examples
- Development commands

#### `CHANGELOG.md`
Version history:
- Follows Keep a Changelog format
- Tracks added, changed, deprecated, removed, fixed, security updates
- Semantic versioning

#### `CONTRIBUTING.md`
Contribution guidelines:
- Development setup
- Code standards
- Testing procedures
- PR guidelines

#### `LICENSE`
Project license file

### Development Files

#### `.dockerignore`
Files excluded from Docker build context

#### `node_modules/`
Installed Node.js dependencies (not committed to git)

## File Naming Conventions

### Templates (DSL/)
- Use lowercase with hyphens: `user-profile.hbs`
- Match intended URL structure
- Group by logical projects

### Documentation (docs/)
- Use lowercase with hyphens: `getting-started.md`
- Place in appropriate subdirectory:
  - `architecture/` - System design docs
  - `how-to/` - Step-by-step guides
  - `reference/` - API references, specifications

### Examples (examples/)
- Each example in its own directory
- Include `README.md` in each example
- Include dependency manifest (package.json)

## Volume Mounts

The following directories are mounted as volumes in Docker:

```yaml
volumes:
  - ./DSL:/app/DSL              # Live reload of templates
```

This allows editing templates without rebuilding the container.

## File Permissions

All files should be readable by the container user. The default Node.js Alpine image runs as user `node` (UID 1000).

## Git Tracking

### Tracked
- All source code
- Documentation
- Configuration files
- Example DSL templates

### Ignored (.gitignore)
- node_modules/
- Temporary files
- IDE-specific files
- Environment-specific configurations
