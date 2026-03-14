# Table Usage Examples Template

## Template Purpose
Table usage examples template for generating CRUD pages

## 1. Basic Table

### Simplest Table

```vue
<template>
  <Grid />
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '#/adapter/vxe-table';

const [Grid] = useVbenVxeGrid({
  gridOptions: {
    columns: [
      { field: 'name', title: 'Name' },
      { field: 'age', title: 'Age' },
      { field: 'email', title: 'Email' },
    ],
    data: [
      { name: 'Zhang San', age: 25, email: 'zhangsan@example.com' },
      { name: 'Li Si', age: 30, email: 'lisi@example.com' },
    ],
  },
});
</script>
```

## 2. Table with Search Form

```vue
<template>
  <Grid />
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '#/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  showSearchForm: true,
  formOptions: {
    schema: [
      {
        component: 'Input',
        fieldName: 'name',
        label: 'Name',
      },
      {
        component: 'Input',
        fieldName: 'email',
        label: 'Email',
      },
    ],
  },
  gridOptions: {
    columns: [
      { field: 'name', title: 'Name' },
      { field: 'age', title: 'Age' },
      { field: 'email', title: 'Email' },
    ],
    proxyConfig: {
      ajax: {
        query: async ({ page, form }) => {
          // form is the search form values
          return await fetchTableData({
            page: page.currentPage,
            pageSize: page.pageSize,
            ...form,
          });
        },
      },
    },
  },
});
</script>
```

## 3. Remote Data Loading

```vue
<template>
  <Grid />
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '#/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions: {
    columns: [
      { field: 'name', title: 'Name' },
      { field: 'age', title: 'Age' },
      { field: 'email', title: 'Email' },
    ],
    proxyConfig: {
      ajax: {
        query: async ({ page }) => {
          const response = await fetchTableData({
            page: page.currentPage,
            pageSize: page.pageSize,
          });
          return {
            items: response.data,
            total: response.total,
          };
        },
      },
    },
  },
});
</script>
```

## 4. Table with Action Column

```vue
<template>
  <Grid>
    <template #action="{ row }">
      <a-button type="link" @click="handleEdit(row)">Edit</a-button>
      <a-button type="link" danger @click="handleDelete(row)">Delete</a-button>
    </template>
  </Grid>
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '#/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions: {
    columns: [
      { field: 'name', title: 'Name' },
      { field: 'age', title: 'Age' },
      { field: 'email', title: 'Email' },
      {
        field: 'action',
        title: 'Action',
        width: 200,
        slots: { default: 'action' },
      },
    ],
    proxyConfig: {
      ajax: {
        query: async ({ page }) => {
          return await fetchTableData({
            page: page.currentPage,
            pageSize: page.pageSize,
          });
        },
      },
    },
  },
});

const handleEdit = (row: any) => {
  console.log('Edit', row);
};

const handleDelete = (row: any) => {
  console.log('Delete', row);
};
</script>
```

## 5. Cell Editing

```vue
<template>
  <Grid />
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '#/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions: {
    columns: [
      {
        field: 'name',
        title: 'Name',
        editRender: { name: 'input' },
      },
      {
        field: 'age',
        title: 'Age',
        editRender: { name: 'input' },
      },
      { field: 'email', title: 'Email' },
    ],
    editConfig: {
      mode: 'cell',
      trigger: 'click',
    },
    data: [
      { name: 'Zhang San', age: 25, email: 'zhangsan@example.com' },
      { name: 'Li Si', age: 30, email: 'lisi@example.com' },
    ],
  },
});
</script>
```

## 6. Row Editing

```vue
<template>
  <Grid />
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '#/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions: {
    columns: [
      {
        field: 'name',
        title: 'Name',
        editRender: { name: 'input' },
      },
      {
        field: 'age',
        title: 'Age',
        editRender: { name: 'input' },
      },
      { field: 'email', title: 'Email' },
    ],
    editConfig: {
      mode: 'row',
      trigger: 'click',
    },
    data: [
      { name: 'Zhang San', age: 25, email: 'zhangsan@example.com' },
      { name: 'Li Si', age: 30, email: 'lisi@example.com' },
    ],
  },
});
</script>
```

## 7. Tree Table

```vue
<template>
  <Grid />
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '#/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions: {
    columns: [
      { field: 'name', title: 'Name', treeNode: true },
      { field: 'size', title: 'Size' },
      { field: 'type', title: 'Type' },
    ],
    treeConfig: {
      transform: true,
      parentField: 'parentId',
      rowField: 'id',
    },
    data: [
      { id: 1, name: 'Root', size: '-', type: 'Folder', parentId: null },
      { id: 2, name: 'Documents', size: '-', type: 'Folder', parentId: 1 },
      { id: 3, name: 'readme.md', size: '1KB', type: 'File', parentId: 2 },
    ],
  },
});
</script>
```

## 8. Fixed Columns

```vue
<template>
  <Grid />
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '#/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions: {
    columns: [
      { field: 'name', title: 'Name', fixed: 'left', width: 150 },
      { field: 'age', title: 'Age', width: 100 },
      { field: 'email', title: 'Email', width: 200 },
      { field: 'address', title: 'Address', width: 300 },
      { field: 'phone', title: 'Phone', width: 150 },
      { field: 'action', title: 'Action', fixed: 'right', width: 150 },
    ],
    data: [],
  },
});
</script>
```

## 9. Custom Cell Rendering (Slot Method)

```vue
<template>
  <Grid>
    <template #status="{ row }">
      <a-tag :color="row.status === 1 ? 'green' : 'red'">
        {{ row.status === 1 ? 'Enabled' : 'Disabled' }}
      </a-tag>
    </template>
  </Grid>
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '#/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions: {
    columns: [
      { field: 'name', title: 'Name' },
      {
        field: 'status',
        title: 'Status',
        slots: { default: 'status' },
      },
    ],
    data: [
      { name: 'Zhang San', status: 1 },
      { name: 'Li Si', status: 0 },
    ],
  },
});
</script>
```

## 10. Custom Cell Rendering (Renderer Method)

Before using custom renderers, you need to register them in the adapter (refer to `assets/table-adapter-template.md`).

```vue
<template>
  <Grid />
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '#/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions: {
    columns: [
      { field: 'name', title: 'Name' },
      {
        field: 'avatar',
        title: 'Avatar',
        cellRender: { name: 'CellImage' },
      },
      {
        field: 'link',
        title: 'Link',
        cellRender: { name: 'CellLink', props: { text: 'View Details' } },
      },
    ],
    data: [
      { name: 'Zhang San', avatar: 'https://example.com/avatar1.jpg', link: '#' },
      { name: 'Li Si', avatar: 'https://example.com/avatar2.jpg', link: '#' },
    ],
  },
});
</script>
```

## 11. Custom Toolbar

```vue
<template>
  <Grid>
    <template #toolbar-actions>
      <a-button type="primary" @click="handleAdd">Add</a-button>
      <a-button @click="handleExport">Export</a-button>
    </template>

    <template #toolbar-tools>
      <a-button @click="handleRefresh">Refresh</a-button>
    </template>
  </Grid>
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '#/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions: {
    columns: [
      { field: 'name', title: 'Name' },
      { field: 'age', title: 'Age' },
    ],
    data: [],
  },
});

const handleAdd = () => {
  console.log('Add');
};

const handleExport = () => {
  console.log('Export');
};

const handleRefresh = () => {
  gridApi.reload();
};
</script>
```

## 12. Using GridApi Methods

```vue
<template>
  <div>
    <a-space class="mb-4">
      <a-button @click="handleReload">Reload Table</a-button>
      <a-button @click="handleQuery">Query Table</a-button>
      <a-button @click="handleToggleSearch">Toggle Search Form</a-button>
      <a-button @click="handleSetLoading">Set Loading</a-button>
    </a-space>
    <Grid />
  </div>
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '#/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  showSearchForm: true,
  formOptions: {
    schema: [
      {
        component: 'Input',
        fieldName: 'name',
        label: 'Name',
      },
    ],
  },
  gridOptions: {
    columns: [
      { field: 'name', title: 'Name' },
      { field: 'age', title: 'Age' },
    ],
    proxyConfig: {
      ajax: {
        query: async ({ page }) => {
          return await fetchTableData({
            page: page.currentPage,
            pageSize: page.pageSize,
          });
        },
      },
    },
  },
});

// Reload table (will reset pagination)
const handleReload = () => {
  gridApi.reload();
};

// Query table (keep current pagination)
const handleQuery = () => {
  gridApi.query();
};

// Toggle search form display/hide
const handleToggleSearch = () => {
  gridApi.toggleSearchForm();
};

// Set loading state
const handleSetLoading = () => {
  gridApi.setLoading(true);
  setTimeout(() => {
    gridApi.setLoading(false);
  }, 2000);
};
</script>
```

## 13. Virtual Scrolling

```vue
<template>
  <Grid />
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '#/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions: {
    columns: [
      { field: 'name', title: 'Name' },
      { field: 'age', title: 'Age' },
      { field: 'email', title: 'Email' },
    ],
    scrollY: {
      enabled: true,
      gt: 100, // Enable virtual scrolling when data exceeds 100 rows
    },
    data: [], // Large amount of data
  },
});
</script>
```
