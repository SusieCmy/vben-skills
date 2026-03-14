---
name: vue-vben-crud
description: Generate complete CRUD module code in Vue Vben Admin projects, including pages, forms, tables, and API interfaces. Must use this Skill when users say "generate CRUD", "create module", "add page", "write CRUD", "generate table page", "create xxx management", "generate xxx module". Do not skip even if the task seems simple. Do not generate code directly. All questions about component usage must be answered by reading the corresponding component documentation first, never from memory.
---

# Vue Vben CRUD Generator

## Mandatory Execution Process (Cannot Skip Any Step)

### 1. Collect Requirements (Must Ask First, Cannot Skip)

Before generating any code, if the user has not provided the following information,
ask one by one and wait for confirmation before proceeding to step 2.
Do not guess from context and generate directly:

- Module name (English, e.g. user, product)
- Field list and types (name, type, required, validation rules)
- Whether multi-tab is needed
- Special feature requirements (import/export, batch operations, etc.)
- Default to no i18n unless user explicitly requests multi-language support

### 2. Read Reference Documentation (Must Read Before Generation)

**Prioritize reading the default CRUD template: `assets/crud-template.md`**

**Before generating any component, you must read the corresponding documentation first. Never generate from memory.**

**Before using useVbenModal, useVbenDrawer, useVbenVxeGrid, search the project to find the actual import path. Never guess.**

| Component Type | Read This Doc First | Then Refer to This Template |
|---|---|---|
| Form | `references/vben-form.md` | `assets/form-template.md` |
| Table | `references/vben-table.md` | `assets/table-usage-template.md` |
| Modal | `references/vben-modal.md` | `assets/modal-template.md` |
| Drawer | `references/vben-drawer.md` | `assets/drawer-template.md` |
| Page | None | `assets/page-template.md` |
| Count Animator | `references/vben-count-animator.md` | `assets/count-to-template.md` |
| Ellipsis Text | `references/vben-ellipsis-text.md` | `assets/ellipsis-text-template.md` |
| Alert | `references/vben-alert.md` | `assets/alert-template.md` |

### 3. Generate File Structure

All files below must be generated. Not a single one can be skipped, even if the user has already provided information:

```
src/
├── api/
│   └── [module]/
│       ├── types.ts              # Type definitions, must generate
│       └── index.ts              # API interfaces, must generate
├── router/
│   └── routes/
│       └── modules/
│           └── [module].ts       # Route config, must generate
└── views/
    └── [module]/                 # e.g. push/
        ├── index.vue             # Main page, must generate
        └── modules/              # Sub-component directory
            ├── form.vue          # Form component, must generate
            └── data.ts           # Data config, must generate
```

**Important: `index.vue` and `data.ts` are in `[module]/` root. `form.vue`, `drawer.vue` and other components are in `[module]/modules/`. Do NOT nest an extra `[module]` subdirectory.**

**File responsibilities:**
- `types.ts`: Define request/response types and entity types
- `index.ts`: Encapsulate CRUD API methods (create, read, update, delete)
- `[module].ts`: Route config, define menu and page routes
- `form.vue`: Form component using `useVbenModal` or `useVbenDrawer`
- `data.ts`: Table column config and search form schema
- `index.vue`: Main page using `useVbenVxeGrid` to integrate the table

### 4. Code Quality Check (Must Complete Before Output Summary, Cannot Skip)

#### 4.1 Automated Script Check (Run First)

```bash
bash .claude/skills/vue-vben-crud/scripts/check.sh <api-path> <views-path>
# Example: bash .claude/skills/vue-vben-crud/scripts/check.sh src/api/system/push src/views/system/push
```

If the script outputs `exit 1`, fix the errors and re-run.
Only proceed to 4.2 after the script outputs "🎉 All checks passed".

#### 4.2 Manual Documentation Check (Run After Script Passes)

Scripts cannot verify component API usage. You must manually check against the docs:

- [ ] Read `references/vben-form.md`, verify form API usage in form.vue
- [ ] Read `references/vben-table.md`, verify table column config in data.ts
- [ ] Read `references/vben-modal.md` or `vben-drawer.md`, verify modal/drawer usage
- [ ] Verify type definitions in types.ts match usage in form.vue, data.ts, and index.ts
- [ ] Verify API method parameters match request types defined in types.ts

Fix any inconsistencies found. Only output the final summary after all checks pass.

---

## Output Format

After generation completes, output the summary in this exact format:

```
✅ [Module Name] CRUD Module Generation Complete

📁 Generated Files:
- src/api/[module]/types.ts
- src/api/[module]/index.ts
- src/router/routes/modules/[module].ts
- src/views/[module]/index.vue
- src/views/[module]/modules/form.vue
- src/views/[module]/data.ts

🎯 Next Steps:
1. Adjust API endpoint URLs to match actual backend paths
2. Add route configuration
3. Adjust field validation and display logic based on business requirements
```

---

## Core Principles

- All code must comply with TypeScript strict mode
- Follow Vben Admin best practices and code style
- Use framework-provided components and utilities only, do not create custom implementations
- Keep code concise, avoid over-engineering
- Ensure type safety to reduce runtime errors