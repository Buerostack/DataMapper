# Basic Usage Example

This example demonstrates the core functionality of DataMapper: transforming Handlebars templates into REST endpoints.

## What This Demonstrates

- Creating a simple DSL template
- Calling the template via HTTP POST
- Using Handlebars helpers
- Data transformation and formatting

## Prerequisites

- Docker and Docker Compose v2 installed
- curl or similar HTTP client

## Setup

1. Start DataMapper:
```bash
cd ../.. # Navigate to DataMapper root
docker compose up -d --build datamapper
```

2. Verify it's running:
```bash
curl -sS http://localhost:3000/healthz
```

Expected output:
```json
{"status":"healthy"}
```

## Run the Example

### Example 1: Simple Ping

```bash
curl -X POST http://localhost:3000/samples/ping \
  -H 'Content-Type: application/json' \
  -H 'type: json' \
  -d '{}'
```

Expected output:
```json
{"message":"pong"}
```

### Example 2: Data Transformation

Create a custom template at `../../DSL/examples/transform.hbs`:

```handlebars
{
  "input_data": {{{json this}}},
  "timestamp": "{{now}}",
  "user_id": "{{userId}}",
  "processed": true
}
```

Call it:

```bash
curl -X POST http://localhost:3000/examples/transform \
  -H 'Content-Type: application/json' \
  -H 'type: json' \
  -d '{"userId": "12345", "name": "Test User"}'
```

Expected output:
```json
{
  "input_data": {"userId":"12345","name":"Test User"},
  "timestamp": "2025-10-08T...",
  "user_id": "12345",
  "processed": true
}
```

### Example 3: List Iteration

Create `../../DSL/examples/list.hbs`:

```handlebars
{
  "items": [
    {{#each items}}
    {
      "id": "{{id}}",
      "name": "{{name}}",
      "processed": true
    }{{#unless @last}},{{/unless}}
    {{/each}}
  ],
  "count": {{items.length}}
}
```

Call it:

```bash
curl -X POST http://localhost:3000/examples/list \
  -H 'Content-Type: application/json' \
  -H 'type: json' \
  -d '{
    "items": [
      {"id": "1", "name": "First"},
      {"id": "2", "name": "Second"}
    ]
  }'
```

## Understanding the Flow

1. **Request**: Client sends POST to `/<project>/<view>`
2. **Mapping**: DataMapper finds `DSL/<project>/<view>.hbs`
3. **Processing**: Template processes request body
4. **Response**: Transformed data returned to client

## Common Patterns

### Access Request Data
```handlebars
{{fieldName}}
```

### Output JSON Objects
```handlebars
{{{json object}}}
```

### Iterate Arrays
```handlebars
{{#each arrayName}}
  {{this}}
{{/each}}
```

### Conditional Logic
```handlebars
{{#if condition}}
  true case
{{else}}
  false case
{{/if}}
```

## Troubleshooting

### Error: "Cannot POST /..."
- Check that the DSL file exists at the correct path
- Verify the URL matches the file structure

### Error: "TemplateNotFound"
- Ensure `.hbs` extension is on the file
- Don't include `.hbs` in the URL

### Error: "TemplateOutputNotJson"
- Template output must be valid JSON when requesting JSON
- Check for trailing commas or syntax errors

## Next Steps

- Read the [Architecture Overview](../../docs/architecture/overview.md)
- Explore [Data Flow](../../docs/architecture/data-flow.md)
- Check [How-To Guides](../../docs/how-to/) for advanced patterns
