# Drawer Component Usage Template

## Template Purpose
Drawer configuration template for generating CRUD pages

## Required Imports

```typescript
import { useVbenDrawer } from '#/adapter/form';
```

## 1. Basic Drawer Template

### Basic Structure

```typescript
const [Drawer, drawerApi] = useVbenDrawer({
  title: 'Title',
  onConfirm: async () => {
    // Confirm action
    console.log('Confirmed');
  },
});
```

### Drawer with Content

```vue
<template>
  <Drawer>
    <div class="p-4">
      <p>This is drawer content</p>
    </div>
  </Drawer>
</template>

<script setup lang="ts">
import { useVbenDrawer } from '#/adapter/form';

const [Drawer, drawerApi] = useVbenDrawer({
  title: 'Notice',
  onConfirm: async () => {
    console.log('Confirm action');
  },
});
</script>
```

## 2. Component Separation Template

### External Component

```vue
<template>
  <Drawer />
</template>

<script setup lang="ts">
import { useVbenDrawer } from '#/adapter/form';
import DrawerContent from './drawer-content.vue';

const [Drawer, drawerApi] = useVbenDrawer({
  title: 'Edit',
  connectedComponent: DrawerContent,
  onConfirm: async () => {
    const data = drawerApi.getData();
    console.log('Submit data:', data);
  },
});

// Open drawer
const handleOpen = () => {
  drawerApi.open();
};
</script>
```

### Internal Component (drawer-content.vue)

```vue
<template>
  <div class="p-4">
    <a-input v-model:value="formData.name" placeholder="Please enter name" />
  </div>
</template>

<script setup lang="ts">
import { useVbenDrawer } from '#/adapter/form';
import { reactive } from 'vue';

const [Drawer, drawerApi] = useVbenDrawer({});

const formData = reactive({
  name: '',
});

// Set shared data
drawerApi.setData(formData);
</script>
```

## 3. Common Configuration Templates

### Left Placement

```typescript
const [Drawer, drawerApi] = useVbenDrawer({
  title: 'Left Drawer',
  placement: 'left',
});
```

### Top Placement

```typescript
const [Drawer, drawerApi] = useVbenDrawer({
  title: 'Top Drawer',
  placement: 'top',
});
```

### Bottom Placement

```typescript
const [Drawer, drawerApi] = useVbenDrawer({
  title: 'Bottom Drawer',
  placement: 'bottom',
});
```

### Custom Width

```typescript
const [Drawer, drawerApi] = useVbenDrawer({
  title: 'Custom Width',
  class: 'w-[800px]',
});
```

### Hide Footer Buttons

```typescript
const [Drawer, drawerApi] = useVbenDrawer({
  title: 'No Footer',
  footer: false,
});
```

### Custom Button Text

```typescript
const [Drawer, drawerApi] = useVbenDrawer({
  title: 'Custom Buttons',
  confirmText: 'Submit',
  cancelText: 'Back',
});
```

## 4. API Usage Templates

### Open/Close Drawer

```typescript
// Open
drawerApi.open();

// Close
drawerApi.close();
```

### Dynamically Set State

```typescript
// Set title
drawerApi.setState({
  title: 'New Title',
});

// Set loading state
drawerApi.setState({
  loading: true,
});

// Disable confirm button
drawerApi.setState({
  confirmDisabled: true,
});
```

### Data Sharing

```typescript
// Set data
drawerApi.setData({
  id: 1,
  name: 'John',
});

// Get data
const data = drawerApi.getData();
console.log(data);
```

### Lock/Unlock

```typescript
// Lock (submitting)
drawerApi.lock(true);

// Unlock
drawerApi.unlock();
```

## 5. Event Handling Templates

### Complete Event Example

```typescript
const [Drawer, drawerApi] = useVbenDrawer({
  title: 'Event Example',

  // Open/close state change
  onOpenChange: (isOpen) => {
    console.log('Drawer state:', isOpen);
  },

  // Open animation complete
  onOpened: () => {
    console.log('Opened');
  },

  // Before close confirmation
  onBeforeClose: () => {
    const confirm = window.confirm('Are you sure to close?');
    return confirm; // Return false to prevent closing
  },

  // Confirm button
  onConfirm: async () => {
    try {
      drawerApi.lock(true);
      await submitData();
      drawerApi.close();
    } finally {
      drawerApi.unlock();
    }
  },

  // Cancel button
  onCancel: () => {
    console.log('Cancelled');
  },

  // Close animation complete
  onClosed: () => {
    console.log('Closed');
  },
});
```

## 6. Slot Usage Templates

### Custom Footer Buttons

```vue
<template>
  <Drawer>
    <div class="p-4">
      <p>Content area</p>
    </div>

    <template #prepend-footer>
      <a-button>Extra Button</a-button>
    </template>

    <template #append-footer>
      <a-button type="link">Help</a-button>
    </template>
  </Drawer>
</template>
```

### Fully Custom Footer

```vue
<template>
  <Drawer>
    <div class="p-4">
      <p>Content area</p>
    </div>

    <template #footer>
      <div class="flex justify-between">
        <a-button @click="handleReset">Reset</a-button>
        <div>
          <a-button @click="drawerApi.close()">Cancel</a-button>
          <a-button type="primary" @click="handleSubmit">Submit</a-button>
        </div>
      </div>
    </template>
  </Drawer>
</template>
```

### Custom Close Icon

```vue
<template>
  <Drawer>
    <div class="p-4">
      <p>Content area</p>
    </div>

    <template #close-icon>
      <CloseCircleOutlined />
    </template>
  </Drawer>
</template>
```

### Extra Content on Title Right

```vue
<template>
  <Drawer>
    <div class="p-4">
      <p>Content area</p>
    </div>

    <template #extra>
      <a-button type="link">More Actions</a-button>
    </template>
  </Drawer>
</template>
```

## 7. Complete Example

### Edit User Drawer

```vue
<template>
  <div>
    <a-button type="primary" @click="handleEdit">Edit User</a-button>
    <Drawer />
  </div>
</template>

<script setup lang="ts">
import { useVbenDrawer } from '#/adapter/form';
import { reactive } from 'vue';
import UserForm from './user-form.vue';

const [Drawer, drawerApi] = useVbenDrawer({
  title: 'Edit User',
  class: 'w-[600px]',
  connectedComponent: UserForm,

  onOpenChange: (isOpen) => {
    if (isOpen) {
      // Load data when opening
      loadUserData();
    }
  },

  onConfirm: async () => {
    try {
      drawerApi.lock(true);
      const formData = drawerApi.getData();
      await updateUser(formData);
      message.success('Saved successfully');
      drawerApi.close();
    } catch (error) {
      message.error('Save failed');
    } finally {
      drawerApi.unlock();
    }
  },
});

const handleEdit = () => {
  drawerApi.open();
};

const loadUserData = async () => {
  drawerApi.setState({ loading: true });
  try {
    const data = await fetchUser(1);
    drawerApi.setData(data);
  } finally {
    drawerApi.setState({ loading: false });
  }
};
</script>
```
