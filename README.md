# Vue Vben CRUD Skill

A powerful skill for generating complete CRUD modules in Vue Vben Admin projects.

## Features

- 🚀 Complete CRUD generation: pages, forms, tables, API interfaces, routes
- 📝 Type-safe with full TypeScript support
- 🎨 Uses Vben's built-in components (Modal, Drawer, Table, Form)
- ✅ Automated quality checks and validation
- 📚 Documentation-driven component usage

## Quick Start

### Trigger Phrases

- "generate CRUD"
- "create module"
- "add page"
- "create xxx management"

### Generated Structure

```
src/
├── api/[module]/
│   ├── types.ts              # Type definitions
│   └── index.ts              # API methods
├── router/routes/modules/
│   └── [module].ts           # Route config
└── views/[module]/
    ├── index.vue             # Main page with table
    ├── data.ts               # Table columns & search form
    └── modules/
        └── form.vue          # Form component
```

## Usage Examples

### Method 1: Conversational Generation

**User:** "Create a user management module"

**AI asks:**
1. Module name? (e.g., `user`)
2. Fields? (e.g., `name, email, role, status`)
3. Multi-tab needed?
4. Special features?

**AI generates:**
- Complete CRUD code
- Type-safe API interfaces
- Search form with filters
- Modal/Drawer form
- Table with pagination

### Method 2: One-Click Trigger (Recommended)

Provide complete requirements directly, AI generates without asking:

```markdown
# Page Name
- Push Management

# Page Display
**Search Filters**
- Title, Type, Status, Push Time

**Table Fields**
- Add button at top-left
- Title, Content, Create Time, Push Time, Recipients, Actions (Edit, Delete, Send)

**Form Fields (Create/Edit)**
- Use modal component
- Title (required)
- Content (required)
- Type (required, radio: System Message, Marketing Message)
- Push Time (required, datetime picker)

# API Integration
- Endpoint: api/push
- Methods: GET/POST/DELETE/PUT
- Request Fields:
\`\`\`typescript
{
  title: string;
  content: string;
  type: 'system' | 'marketing';
  status: 'draft' | 'scheduled' | 'sent';
  pushTime: string; // ISO 8601
}
\`\`\`
- Response Fields:
\`\`\`typescript
{
  id: number;
  title: string;
  content: string;
  type: 'system' | 'marketing';
  status: 'draft' | 'scheduled' | 'sent';
  pushTime: string;
  createTime: string;
}
\`\`\`
```

**Quick Tip:** Copy backend API docs to a `.md` file and let AI read it.

**Full Template:** See `assets/quick-start-template.md`

## Component Documentation

| Component | API Reference | Usage Examples |
|---|---|---|
| Form | `references/vben-form.md` | `assets/form-template.md` |
| Table | `references/vben-table.md` | `assets/table-usage-template.md` |
| Modal | `references/vben-modal.md` | `assets/modal-template.md` |
| Drawer | `references/vben-drawer.md` | `assets/drawer-template.md` |

## Quality Checks

### Automated
```bash
bash .claude/skills/vue-vben-crud/scripts/check.sh src/api/user src/views/user
```

Validates:
- ✅ TypeScript types
- ✅ Required files
- ✅ Import paths (must use `#/` alias)
- ⚠️ No `any` type abuse

### Manual
- Component API usage matches docs
- Type consistency across files
- API parameters match types

## Best Practices

1. Use `#/` alias for imports
2. Follow TypeScript strict mode
3. Use framework components only
4. Keep code minimal
5. Validate with zod schemas

## Troubleshooting

### Import Paths
❌ `import { useVbenForm } from '../../../adapter/form'`
✅ `import { useVbenForm } from '#/adapter/form'`

### Type Definitions
Always define in `types.ts` first:
```typescript
export interface User { id: number; name: string; }
```

## License

MIT
