# Alert Usage Examples Template

## Template Purpose
Usage examples template for generating alert dialog component

## 1. Basic Alert

```typescript
import { alert } from '@vben/common-ui';

// Simple message
alert('This is an alert message');

// With title
await alert('This is the message content', 'Alert Title');

// With options
await alert('This is the message content', 'Alert Title', {
  centered: true,
  confirmText: 'OK',
});
```

## 2. Alert with Custom Content

```typescript
import { h } from 'vue';
import { alert } from '@vben/common-ui';
import { Result } from 'ant-design-vue';

alert({
  buttonAlign: 'center',
  content: h(Result, {
    status: 'success',
    subTitle: 'Order created successfully. Order ID: 2017182818828182881',
    title: 'Operation Successful',
  }),
});
```

## 3. Alert with Different Icons

```typescript
import { alert } from '@vben/common-ui';

// Success icon
await alert('Operation completed successfully!', 'Success', {
  icon: 'success',
});

// Error icon
await alert('An error occurred!', 'Error', {
  icon: 'error',
});

// Warning icon
await alert('Please be careful!', 'Warning', {
  icon: 'warning',
});

// Info icon
await alert('Here is some information', 'Info', {
  icon: 'info',
});

// Question icon
await alert('Do you understand?', 'Question', {
  icon: 'question',
});
```

## 4. Basic Confirm Dialog

```typescript
import { confirm, alert } from '@vben/common-ui';

// Simple confirm
confirm('This is an alert message')
  .then(() => {
    alert('Confirmed');
  })
  .catch(() => {
    alert('Canceled');
  });

// With title and options
try {
  await confirm('Are you sure you want to delete this item?', 'Confirm Delete', {
    confirmText: 'Delete',
    cancelText: 'Cancel',
    icon: 'warning',
  });
  console.log('User confirmed');
} catch {
  console.log('User cancelled');
}
```

## 5. Confirm with Custom Footer

```typescript
import { h, ref } from 'vue';
import { confirm } from '@vben/common-ui';
import { Checkbox, message } from 'ant-design-vue';

const checked = ref(false);

confirm({
  cancelText: 'No',
  confirmText: 'Yes',
  content:
    'Have you ever experienced something that feels like you\'ve been through it before?\nYou can even subconsciously predict what will happen next.\n\nSounds mysterious, have you ever felt this way?',
  footer: () =>
    h(
      Checkbox,
      {
        checked: checked.value,
        class: 'flex-1',
        'onUpdate:checked': (v) => (checked.value = v),
      },
      'Do not show again',
    ),
  icon: 'question',
  title: 'Mystery',
}).then(() => {
  if (checked.value) {
    message.success('I won\'t bother you with this question again');
  } else {
    message.info('I will ask you again next time');
  }
});
```

## 6. Async Confirm with Before Close

```typescript
import { confirm, alert } from '@vben/common-ui';

confirm({
  beforeClose({ isConfirm }) {
    if (isConfirm) {
      // You can perform some async operations here. If false is returned, the dialog will not close
      return new Promise((resolve) => setTimeout(resolve, 2000));
    }
  },
  content: 'This is an alert message with async confirm',
  icon: 'success',
  contentMasking: true, // Show loading mask during beforeClose
}).then(() => {
  alert('Confirmed');
});
```

## 7. Custom Button Alignment

```typescript
import { confirm } from '@vben/common-ui';

// Center alignment
await confirm('Are you sure?', 'Confirm', {
  buttonAlign: 'center',
});

// End alignment (right)
await confirm('Are you sure?', 'Confirm', {
  buttonAlign: 'end',
});

// Start alignment (left)
await confirm('Are you sure?', 'Confirm', {
  buttonAlign: 'start',
});
```

## 8. Basic Prompt Input Dialog

```typescript
import { prompt } from '@vben/common-ui';

// Simple prompt
const result = await prompt({
  title: 'Enter Your Name',
  content: 'Please enter your name:',
  defaultValue: 'John Doe',
});

if (result) {
  console.log('User entered:', result);
}
```

## 9. Prompt with Custom Component

```typescript
import { prompt } from '@vben/common-ui';
import { Input } from 'ant-design-vue';

const result = await prompt({
  title: 'Enter Email',
  content: 'Please enter your email address:',
  component: Input,
  componentProps: {
    type: 'email',
    placeholder: 'example@email.com',
  },
  defaultValue: '',
});

console.log('Email:', result);
```

## 10. Prompt with Validation

```typescript
import { prompt, alert } from '@vben/common-ui';

const result = await prompt({
  title: 'Enter Age',
  content: 'Please enter your age (must be 18 or older):',
  defaultValue: '',
  beforeClose: ({ isConfirm, value }) => {
    if (isConfirm) {
      const age = Number(value);
      if (isNaN(age) || age < 18) {
        alert('Age must be 18 or older');
        return false; // Prevent close
      }
    }
    return true;
  },
});

console.log('Age:', result);
```

## 11. Prompt with Custom Slots and useAlertContext

```typescript
import { h } from 'vue';
import { prompt, useAlertContext, alert } from '@vben/common-ui';
import { Input } from 'ant-design-vue';
import { BadgeJapaneseYen } from 'lucide-vue-next';

prompt({
  component: () => {
    // Get alert context. Note: can only be called in setup or functional components
    const { doConfirm } = useAlertContext();
    return h(
      Input,
      {
        onKeydown(e: KeyboardEvent) {
          if (e.key === 'Enter') {
            e.preventDefault();
            // Call the confirm method provided by the dialog
            doConfirm();
          }
        },
        placeholder: 'Please enter',
        prefix: 'Recharge amount:',
        type: 'number',
      },
      {
        addonAfter: () => h(BadgeJapaneseYen),
      },
    );
  },
  content:
    'This dialog demonstrates how to use custom slots and get the dialog context using useAlertContext.\nPress Enter in the input box to trigger the confirm operation.',
  icon: 'question',
  modelPropName: 'value',
}).then((val) => {
  if (val) alert(`You entered ${val}`);
});
```

## 12. Prompt with Select Component

```typescript
import { prompt, alert } from '@vben/common-ui';
import { Select } from 'ant-design-vue';

prompt({
  component: Select,
  componentProps: {
    options: [
      { label: 'Option A', value: 'Option A' },
      { label: 'Option B', value: 'Option B' },
      { label: 'Option C', value: 'Option C' },
    ],
    placeholder: 'Please select',
    // The dialog sets body pointer-events to none, which affects dropdown click events
    popupClassName: 'pointer-events-auto',
  },
  content: 'This dialog demonstrates how to pass custom components using component',
  icon: 'question',
  modelPropName: 'value',
}).then((val) => {
  if (val) {
    alert(`You selected ${val}`);
  }
});
```

## 13. Prompt with Async Validation

```typescript
import { prompt, alert } from '@vben/common-ui';
import { RadioGroup } from 'ant-design-vue';

function sleep(ms: number) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

prompt({
  async beforeClose(scope) {
    if (scope.isConfirm) {
      if (scope.value) {
        // Simulate async operation, can return false if not successful
        await sleep(2000);
      } else {
        alert('Please select an option');
        return false;
      }
    }
  },
  component: RadioGroup,
  componentProps: {
    class: 'flex flex-col',
    options: [
      { label: 'Option 1', value: 'option1' },
      { label: 'Option 2', value: 'option2' },
      { label: 'Option 3', value: 'option3' },
    ],
  },
  content: 'Select an option and then click [Confirm]',
  icon: 'question',
  modelPropName: 'value',
}).then((val) => {
  alert(`${val} has been set.`);
});
```

## 14. Custom Overlay Blur

```typescript
import { alert } from '@vben/common-ui';

await alert('Dialog with blurred background', 'Blur Effect', {
  overlayBlur: 5,
});
```

## 15. Use Custom Component with useAlertContext

```vue
<template>
  <div>
    <p>Custom content in alert</p>
    <a-button @click="handleConfirm">Confirm</a-button>
    <a-button @click="handleCancel">Cancel</a-button>
  </div>
</template>

<script setup lang="ts">
import { useAlertContext } from '@vben/common-ui';

const { doConfirm, doCancel } = useAlertContext();

const handleConfirm = () => {
  // Perform some validation or operation
  doConfirm();
};

const handleCancel = () => {
  doCancel();
};
</script>
```

```typescript
// Usage
import { alert } from '@vben/common-ui';
import CustomContent from './CustomContent.vue';

await alert({
  title: 'Custom Component',
  content: CustomContent,
});
```
