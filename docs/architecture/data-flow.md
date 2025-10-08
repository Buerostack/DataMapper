# DataMapper Data Flow

## Request Processing Flow

```mermaid
sequenceDiagram
    participant Client
    participant Express
    participant Router
    participant Handlebars
    participant Template
    participant Helpers

    Client->>Express: POST /<project>/<view>
    Express->>Router: Parse URL path
    Router->>Router: Map to DSL/<project>/<view>.hbs
    Router->>Template: Check file exists

    alt Template not found
        Template-->>Client: 404 Not Found
    else Template exists
        Template->>Handlebars: Load template
        Handlebars->>Helpers: Register custom helpers
        Handlebars->>Handlebars: Compile template
        Handlebars->>Handlebars: Execute with request body
        Handlebars->>Express: Return rendered output
        Express->>Express: Detect content type
        Express-->>Client: Response (JSON/text)
    end
```

## Template Execution Flow

```mermaid
graph TD
    A[Request Body] --> B[Handlebars Context]
    B --> C{Template Processing}
    C --> D[Helper Functions]
    C --> E[Template Logic]
    D --> F[Data Transformation]
    E --> F
    F --> G[Rendered Output]
    G --> H{Valid JSON?}
    H -->|Yes| I[Return as JSON]
    H -->|No| J[Return as Text]
```

## Data Transformation Example

### Input (Client Request)
```json
{
  "userId": "123",
  "timestamp": 1234567890
}
```

### Template (DSL/samples/format.hbs)
```handlebars
{
  "user": "{{userId}}",
  "formatted_time": "{{now}}",
  "received_at": {{timestamp}}
}
```

### Output (Client Response)
```json
{
  "user": "123",
  "formatted_time": "2025-10-08T10:30:00Z",
  "received_at": 1234567890
}
```

## Error Handling Flow

```mermaid
graph TD
    A[Request] --> B{Template Exists?}
    B -->|No| C[404 Error]
    B -->|Yes| D{Valid Handlebars?}
    D -->|No| E[500 Template Error]
    D -->|Yes| F{Execution Success?}
    F -->|No| G[500 Execution Error]
    F -->|Yes| H{Content-Type Check}
    H -->|JSON Requested + Invalid JSON| I[TemplateOutputNotJson Error]
    H -->|Valid| J[200 OK Response]
```

## Live Reload Mechanism

When DSL templates are mounted as volumes:

```mermaid
sequenceDiagram
    participant Dev as Developer
    participant File as DSL File
    participant Volume as Docker Volume
    participant Server as DataMapper
    participant Client

    Dev->>File: Edit template
    File->>Volume: File change detected
    Volume->>Server: Restart triggered
    Server->>Server: Reload templates
    Client->>Server: POST request
    Server-->>Client: Updated response
```

## Health Check Flow

```mermaid
sequenceDiagram
    participant Monitor
    participant DataMapper
    participant HealthEndpoint

    Monitor->>DataMapper: GET /healthz
    DataMapper->>HealthEndpoint: Check server status
    HealthEndpoint-->>Monitor: 200 OK {"status": "healthy"}
```

## Content Type Detection

DataMapper automatically detects response content type:

1. **Client sends `type: json` header** → Force JSON response
2. **Client sends `Accept: application/json`** → Attempt JSON parsing
3. **Template output is valid JSON** → Return as `application/json`
4. **Template output is not JSON** → Return as `text/plain`

This flexible approach allows templates to return either structured data or plain text without explicit configuration.
