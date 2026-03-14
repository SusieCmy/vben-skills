# CountToAnimator Usage Examples Template

## Template Purpose
Usage examples template for generating number animation component

## 1. Basic Usage

```vue
<template>
  <VbenCountToAnimator :end-val="30000" />
</template>

<script setup lang="ts">
import { VbenCountToAnimator } from '@vben/common-ui';
</script>
```

## 2. Custom Prefix and Separator

```vue
<template>
  <VbenCountToAnimator
    :duration="3000"
    :end-val="2000000"
    :start-val="1"
    prefix="$"
    separator="/"
  />
</template>

<script setup lang="ts">
import { VbenCountToAnimator } from '@vben/common-ui';
</script>
```

## 3. Custom Suffix

```vue
<template>
  <VbenCountToAnimator
    :end-val="99.99"
    :decimals="2"
    suffix="%"
  />
</template>

<script setup lang="ts">
import { VbenCountToAnimator } from '@vben/common-ui';
</script>
```

## 4. Custom Color and Duration

```vue
<template>
  <VbenCountToAnimator
    :end-val="10000"
    :duration="5000"
    color="#ff6b6b"
  />
</template>

<script setup lang="ts">
import { VbenCountToAnimator } from '@vben/common-ui';
</script>
```

## 5. Manual Control Animation

```vue
<template>
  <div>
    <VbenCountToAnimator
      ref="countToRef"
      :end-val="50000"
      :autoplay="false"
    />
    <div class="mt-4">
      <a-button @click="handleStart">Start</a-button>
      <a-button @click="handleReset">Reset</a-button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { VbenCountToAnimator } from '@vben/common-ui';

const countToRef = ref();

const handleStart = () => {
  countToRef.value?.start();
};

const handleReset = () => {
  countToRef.value?.reset();
};
</script>
```

## 6. Listen to Animation Events

```vue
<template>
  <VbenCountToAnimator
    :end-val="88888"
    @started="handleStarted"
    @finished="handleFinished"
  />
</template>

<script setup lang="ts">
import { VbenCountToAnimator } from '@vben/common-ui';

const handleStarted = () => {
  console.log('Animation started');
};

const handleFinished = () => {
  console.log('Animation finished');
};
</script>
```

## 7. Decimal Places

```vue
<template>
  <VbenCountToAnimator
    :end-val="3.1415926"
    :decimals="4"
  />
</template>

<script setup lang="ts">
import { VbenCountToAnimator } from '@vben/common-ui';
</script>
```

## 8. Disable Easing

```vue
<template>
  <VbenCountToAnimator
    :end-val="100000"
    :use-easing="false"
  />
</template>

<script setup lang="ts">
import { VbenCountToAnimator } from '@vben/common-ui';
</script>
```
