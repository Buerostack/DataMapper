# How to Create a DSL Template

This guide walks you through creating a new DataMapper DSL template.

## Step 1: Choose Project and View Names

Decide on your URL structure: `POST /<project>/<view>`

Examples:
- `/users/list` - List users
- `/orders/summary` - Order summary
- `/reports/daily` - Daily report

## Step 2: Create the Template File

Create a file at `DSL/<project>/<view>.hbs`

Example: For `POST /users/profile`, create `DSL/users/profile.hbs`

```bash
mkdir -p DSL/users
touch DSL/users/profile.hbs
```

## Step 3: Write the Template

Use Handlebars syntax to transform data:

```handlebars
{
  "userId": "{{userId}}",
  "fullName": "{{firstName}} {{lastName}}",
  "email": "{{email}}",
  "timestamp": "{{now}}"
}
```

## Step 4: Test the Template

Start DataMapper (if not running):

```bash
docker compose up -d datamapper
```

Call your endpoint:

```bash
curl -X POST http://localhost:3000/users/profile \
  -H 'Content-Type: application/json' \
  -H 'type: json' \
  -d '{
    "userId": "123",
    "firstName": "John",
    "lastName": "Doe",
    "email": "john@example.com"
  }'
```

## Step 5: Verify the Response

Expected output:

```json
{
  "userId": "123",
  "fullName": "John Doe",
  "email": "john@example.com",
  "timestamp": "2025-10-08T10:30:00Z"
}
```

## Common Template Patterns

### Output Raw JSON
```handlebars
{{{json requestBody}}}
```

### Conditional Fields
```handlebars
{
  "status": "{{status}}"
  {{#if premium}}
  ,"premium_features": true
  {{/if}}
}
```

### Array Iteration
```handlebars
{
  "users": [
    {{#each users}}
    {
      "id": "{{id}}",
      "name": "{{name}}"
    }{{#unless @last}},{{/unless}}
    {{/each}}
  ]
}
```

### Nested Objects
```handlebars
{
  "user": {
    "profile": {
      "name": "{{name}}",
      "age": {{age}}
    }
  }
}
```

## Available Helpers

See `lib/helpers.js` for all available helpers:

- `{{now}}` - Current timestamp
- `{{{json obj}}}` - Stringify object as JSON

## Tips

1. **Test incrementally** - Build templates step by step
2. **Use valid JSON** - Ensure proper commas and quotes
3. **Watch the logs** - `docker compose logs -f datamapper`
4. **Live reload** - DSL changes apply immediately (no rebuild needed)

## Troubleshooting

### Template Not Found
- Check file path matches URL
- Verify file has `.hbs` extension
- Don't include `.hbs` in URL

### Invalid JSON Output
- Check for trailing commas
- Ensure all strings are quoted
- Validate JSON syntax

### Helper Not Working
- Verify helper exists in `lib/helpers.js`
- Use correct syntax: `{{helperName}}`
- Check helper registration in server.js
