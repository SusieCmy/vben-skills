# Page Component Template Usage

## Template Purpose
Basic structure of the Page component when generating CRUD pages

## Basic Structure
```vue
<template>
  <Page :title="Page Title" :description="Page Description">
    <template #extra>
      <!-- Right-side action button in header -->
      <a-button type="primary" @click="handleAdd">
        <PlusOutlined />
        Add
      </a-button>
    </template>

    <!-- Main content area -->
    <div class="content-wrapper">
      <!-- Business content -->
    </div>

    <template #footer>
      <!-- Footer content (optional) -->
    </template>
  </Page>
</template>

<script setup lang="ts">
import { Page } from '@vben/common-ui';
import { PlusOutlined } from '@ant-design/icons-vue';

const handleAdd = () => {
  // Add operation
};
</script>
```

## Required Imports
```typescript
import { Page } from '@vben/common-ui';
```

## Usage Rules
1. **Title and Description**: Passed using `title` and `description` props
2. **Action Buttons**: Placed in the `extra` slot
3. **Main Content**: Placed in the default slot
4. **Bottom Content**: Optional, using the `footer` slot

## Common Action Buttons

```vue
<!-- Add Button -->
<a-button type="primary" @click="handleAdd">
  <PlusOutlined />
  Add
</a-button>

<!-- Export Button -->
<a-button @click="handleExport">
  <ExportOutlined />
  Export
</a-button>

<!-- Refresh button -->
<a-button @click="handleRefresh">
  <ReloadOutlined />
  Refresh
</a-button>
```