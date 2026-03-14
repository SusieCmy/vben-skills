# Form Component Usage Template

## Template Purpose
Form configuration template for generating CRUD pages

## Required Imports

```typescript
import { useVbenForm, z } from '#/adapter/form';
```

## 1. Basic Form Template

### Basic Structure

```typescript
const [Form, formApi] = useVbenForm({
  // Form configuration
  commonConfig: {
    componentProps: {
      class: 'w-full',
    },
  },
  // Form layout
  layout: 'horizontal',
  // Form schema
  schema: [
    {
      fieldName: 'name',
      label: 'Name',
      component: 'Input',
      rules: 'required',
    },
  ],
});
```

### Common Field Types

#### Text Input
```typescript
{
  fieldName: 'username',
  label: 'Username',
  component: 'Input',
  rules: z.string().min(3, { message: 'At least 3 characters' }),
  componentProps: {
    placeholder: 'Please enter username',
  },
}
```

#### Number Input
```typescript
{
  fieldName: 'age',
  label: 'Age',
  component: 'InputNumber',
  componentProps: {
    min: 0,
    max: 150,
  },
}
```

#### Select Dropdown
```typescript
{
  fieldName: 'status',
  label: 'Status',
  component: 'Select',
  rules: 'selectRequired',
  componentProps: {
    options: [
      { label: 'Enabled', value: 1 },
      { label: 'Disabled', value: 0 },
    ],
  },
}
```

#### Date Picker
```typescript
{
  fieldName: 'birthday',
  label: 'Birthday',
  component: 'DatePicker',
  componentProps: {
    format: 'YYYY-MM-DD',
  },
}
```

#### Date Range Picker
```typescript
{
  fieldName: 'dateRange',
  label: 'Date Range',
  component: 'RangePicker',
  componentProps: {
    format: 'YYYY-MM-DD',
  },
}
```

#### Switch
```typescript
{
  fieldName: 'enabled',
  label: 'Enabled',
  component: 'Switch',
  defaultValue: true,
}
```

#### Textarea
```typescript
{
  fieldName: 'description',
  label: 'Description',
  component: 'Textarea',
  componentProps: {
    rows: 4,
    placeholder: 'Please enter description',
  },
}
```

## 2. Cascading Form Template

### Basic Cascading Example

```typescript
const [Form, formApi] = useVbenForm({
  schema: [
    {
      fieldName: 'type',
      label: 'Type',
      component: 'Select',
      componentProps: {
        options: [
          { label: 'Personal', value: 'personal' },
          { label: 'Company', value: 'company' },
        ],
      },
    },
    {
      fieldName: 'idCard',
      label: 'ID Card',
      component: 'Input',
      // Show based on type field
      dependencies: {
        triggerFields: ['type'],
        show(values) {
          return values.type === 'personal';
        },
      },
    },
    {
      fieldName: 'companyName',
      label: 'Company Name',
      component: 'Input',
      // Show based on type field
      dependencies: {
        triggerFields: ['type'],
        show(values) {
          return values.type === 'company';
        },
      },
    },
  ],
});
```

### Dynamic Disabled Example

```typescript
{
  fieldName: 'email',
  label: 'Email',
  component: 'Input',
  dependencies: {
    triggerFields: ['useEmail'],
    disabled(values) {
      return !values.useEmail;
    },
  },
}
```

### Dynamic Required Example

```typescript
{
  fieldName: 'phone',
  label: 'Phone',
  component: 'Input',
  dependencies: {
    triggerFields: ['contactType'],
    required(values) {
      return values.contactType === 'phone';
    },
  },
}
```

### Dynamic Component Props Example

```typescript
{
  fieldName: 'city',
  label: 'City',
  component: 'Select',
  dependencies: {
    triggerFields: ['province'],
    componentProps(values, formApi) {
      // Load city list based on province
      return {
        options: getCitiesByProvince(values.province),
      };
    },
  },
}
```

## 3. Custom Component Form Template

### Using Field Slots

```vue
<template>
  <Form>
    <!-- Custom field rendering -->
    <template #customField="{ value, onChange }">
      <div class="custom-component">
        <a-input :value="value" @change="onChange" />
        <span class="hint">Custom hint message</span>
      </div>
    </template>
  </Form>
</template>

<script setup lang="ts">
const [Form, formApi] = useVbenForm({
  schema: [
    {
      fieldName: 'customField',
      label: 'Custom Field',
      component: 'Input', // Will be overridden by slot
    },
  ],
});
</script>
```

### Custom Render Content

```typescript
{
  fieldName: 'avatar',
  label: 'Avatar',
  component: 'Input',
  renderComponentContent: ({ value, onChange }) => {
    return h('div', { class: 'avatar-uploader' }, [
      h('img', { src: value || '/default-avatar.png' }),
      h('button', { onClick: () => handleUpload(onChange) }, 'Upload'),
    ]);
  },
}
```

## 4. Form Methods Usage

### Get Form Values
```typescript
const values = formApi.getValues();
console.log(values);
```

### Set Form Values
```typescript
formApi.setValues({
  name: 'John',
  age: 25
});
```

### Validate Form
```typescript
const isValid = await formApi.validate();
if (isValid) {
  // Submit form
}
```

### Reset Form
```typescript
formApi.resetForm();
```

### Update Schema
```typescript
formApi.updateSchema([
  {
    fieldName: 'newField',
    label: 'New Field',
    component: 'Input',
  },
]);
```

## 5. Complete Example

```typescript
const [Form, formApi] = useVbenForm({
  layout: 'horizontal',
  commonConfig: {
    componentProps: {
      class: 'w-full',
    },
  },
  schema: [
    {
      fieldName: 'username',
      label: 'Username',
      component: 'Input',
      rules: z.string().min(3).max(20),
    },
    {
      fieldName: 'type',
      label: 'User Type',
      component: 'Select',
      componentProps: {
        options: [
          { label: 'Normal User', value: 'normal' },
          { label: 'VIP User', value: 'vip' },
        ],
      },
    },
    {
      fieldName: 'vipLevel',
      label: 'VIP Level',
      component: 'Select',
      dependencies: {
        triggerFields: ['type'],
        show(values) {
          return values.type === 'vip';
        },
        componentProps: {
          options: [
            { label: 'VIP1', value: 1 },
            { label: 'VIP2', value: 2 },
            { label: 'VIP3', value: 3 },
          ],
        },
      },
    },
    {
      fieldName: 'email',
      label: 'Email',
      component: 'Input',
      rules: z.string().email(),
    },
    {
      fieldName: 'enabled',
      label: 'Enabled',
      component: 'Switch',
      defaultValue: true,
    },
  ],
  handleSubmit: async (values) => {
    console.log('Submit data:', values);
    // Call API to submit
  },
});
```
