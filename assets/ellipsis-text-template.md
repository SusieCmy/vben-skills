# EllipsisText Usage Examples Template

## Template Purpose
Usage examples template for generating ellipsis text component

## 1. Basic Usage

Set the maximum width through max-width, and the excess part will display ellipsis.

```vue
<template>
  <EllipsisText :max-width="500">{{ text }}</EllipsisText>
</template>

<script setup lang="ts">
import { EllipsisText } from '@vben/common-ui';

const text = `
Vben Admin is a backend solution based on Vue3.0, Vite, and TypeScript, aiming to provide an out-of-the-box solution for developing medium to large projects. It includes secondary encapsulated components, utils, hooks, dynamic menus, permission verification, multi-theme configuration, button-level permission control, and other features. The project uses the latest frontend technology stack and can be used as a project startup template to help you quickly build enterprise-level mid-to-backend product prototypes. It can also be used as an example for learning vue3, vite, ts, and other mainstream technologies. The project will continue to follow the latest technologies and apply them to the project.
`;
</script>
```

## 2. Collapsible Text Block

Set the number of lines after folding through line, and the expand property sets whether to support expand/collapse.

```vue
<template>
  <EllipsisText :line="3" expand>{{ text }}</EllipsisText>
</template>

<script setup lang="ts">
import { EllipsisText } from '@vben/common-ui';

const text = `
Vben Admin is a backend solution based on Vue3.0, Vite, and TypeScript, aiming to provide an out-of-the-box solution for developing medium to large projects. It includes secondary encapsulated components, utils, hooks, dynamic menus, permission verification, multi-theme configuration, button-level permission control, and other features.
`;
</script>
```

## 3. Custom Tooltip

Customize the tooltip information through the tooltip slot.

```vue
<template>
  <EllipsisText :max-width="240">
    Living in my heart, lonely sea monster, king of pain, starting to tire of the deep sea light, stagnant waves
    <template #tooltip>
      <div style="text-align: center">
        Song Title<br />Living in my heart<br />Lonely sea monster, king of pain<br />Starting to tire
        of the deep sea light, stagnant waves
      </div>
    </template>
  </EllipsisText>
</template>

<script setup lang="ts">
import { EllipsisText } from '@vben/common-ui';
</script>
```

## 4. Auto Show Tooltip

Set through tooltip-when-ellipsis, only trigger tooltip when text length exceeds and causes ellipsis to appear.

```vue
<template>
  <EllipsisText :line="2" :tooltip-when-ellipsis="true">
    {{ text }}
  </EllipsisText>

  <EllipsisText :line="3" :tooltip-when-ellipsis="true">
    {{ text }}
  </EllipsisText>
</template>

<script setup lang="ts">
import { EllipsisText } from '@vben/common-ui';

const text = `
Vben Admin is a backend solution based on Vue3.0, Vite, and TypeScript, aiming to provide an out-of-the-box solution for developing medium to large projects.
`;
</script>
```

## 5. Single Line Ellipsis

```vue
<template>
  <EllipsisText :max-width="300">
    This is a long text content that will automatically display ellipsis when exceeding the maximum width
  </EllipsisText>
</template>

<script setup lang="ts">
import { EllipsisText } from '@vben/common-ui';
</script>
```

## 6. Multi-line Ellipsis

```vue
<template>
  <EllipsisText :line="2">
    This is a long text content, you can set the number of lines to display, and the excess part will be omitted. This is a long text content, you can set the number of lines to display, and the excess part will be omitted. This is a long text content, you can set the number of lines to display, and the excess part will be omitted.
  </EllipsisText>
</template>

<script setup lang="ts">
import { EllipsisText } from '@vben/common-ui';
</script>
```

## 7. With Expand/Collapse Function

```vue
<template>
  <EllipsisText :line="2" expand>
    This is a long text content, you can set the number of lines to display, the excess part will be omitted, click to expand to view all content. This is a long text content, you can set the number of lines to display, the excess part will be omitted, click to expand to view all content. This is a long text content, you can set the number of lines to display, the excess part will be omitted, click to expand to view all content.
  </EllipsisText>
</template>

<script setup lang="ts">
import { EllipsisText } from '@vben/common-ui';
</script>
```

## 8. Custom Tooltip Style

```vue
<template>
  <EllipsisText
    :max-width="300"
    tooltip-background-color="#1890ff"
    tooltip-color="#fff"
    tooltip-font-size="14px"
    :tooltip-max-width="400"
  >
    This is a text content with custom tooltip style, it will display a custom styled tooltip when exceeding the maximum width
  </EllipsisText>
</template>

<script setup lang="ts">
import { EllipsisText } from '@vben/common-ui';
</script>
```

## 9. Custom Tooltip Position

```vue
<template>
  <div>
    <EllipsisText :max-width="300" placement="top">
      Top tooltip: This is a long text content
    </EllipsisText>

    <EllipsisText :max-width="300" placement="bottom">
      Bottom tooltip: This is a long text content
    </EllipsisText>

    <EllipsisText :max-width="300" placement="left">
      Left tooltip: This is a long text content
    </EllipsisText>

    <EllipsisText :max-width="300" placement="right">
      Right tooltip: This is a long text content
    </EllipsisText>
  </div>
</template>

<script setup lang="ts">
import { EllipsisText } from '@vben/common-ui';
</script>
```

## 10. Listen to Expand State Change

```vue
<template>
  <EllipsisText
    :line="2"
    expand
    @expand-change="handleExpandChange"
  >
    This is a long text content, you can listen to the expand/collapse state change. This is a long text content, you can listen to the expand/collapse state change. This is a long text content, you can listen to the expand/collapse state change.
  </EllipsisText>
</template>

<script setup lang="ts">
import { EllipsisText } from '@vben/common-ui';

const handleExpandChange = (isExpand: boolean) => {
  console.log('Expand state:', isExpand);
};
</script>
```

## 11. Disable Tooltip

```vue
<template>
  <EllipsisText :max-width="300" :tooltip="false">
    This is a text content with tooltip disabled, it will not display tooltip when exceeding the maximum width
  </EllipsisText>
</template>

<script setup lang="ts">
import { EllipsisText } from '@vben/common-ui';
</script>
```

## 12. Use in Table

```vue
<template>
  <a-table :columns="columns" :data-source="dataSource">
    <template #description="{ text }">
      <EllipsisText :max-width="200" :tooltip-when-ellipsis="true">
        {{ text }}
      </EllipsisText>
    </template>
  </a-table>
</template>

<script setup lang="ts">
import { EllipsisText } from '@vben/common-ui';

const columns = [
  { title: 'Name', dataIndex: 'name', key: 'name' },
  { title: 'Description', dataIndex: 'description', key: 'description', slots: { customRender: 'description' } },
];

const dataSource = [
  { key: '1', name: 'Project A', description: 'This is a long project description with many details that needs to use ellipsis text component to display' },
  { key: '2', name: 'Project B', description: 'This is another long project description with many details that needs to use ellipsis text component to display' },
];
</script>
```
