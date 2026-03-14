# Vben Vxe Table

The framework provides a Table component based on vxe-table, combined with Vben Form for secondary encapsulation.

The search form in the header uses Vben Form, and the table body uses the vxe-grid component, supporting pagination, sorting, filtering, and other features.

If the documentation does not include parameter descriptions, try looking in the online examples or the vxe-grid(https://vxetable.cn/v4/#/grid/api) official API documentation.

**For specific usage examples and code templates, please refer to**: `assets/table-usage-template.md`

## Important Notes

If the existing component encapsulation doesn't meet your needs, you can use native components or create your own custom component. The framework-provided components are not mandatory - use them based on your requirements.

## Adapter

The table uses vxe-table for implementation, so you can use all vxe-table features. For different UI frameworks, we provide adapters for better compatibility.

**For specific adapter configuration and code examples, please refer to**: `assets/table-adapter-template.md`

## Search Form

The search form uses Vben Form. Refer to the Vben Form documentation.

When the search form is enabled, you can configure search as true in toolbarConfig to display a search form control button in the toolbar area. All slots with names starting with form- will be passed to the search form.

## Customize Separator

When you enable the search form, a separator is displayed between the form and the table. This separator uses the default component background color and spans the entire Vben Vxe Table horizontally, blending into the page's default background. If you wrap Vben Vxe Table in a container with a different background color (such as placing it in a Card), the default separator between the form and table may look out of place. The code below demonstrates how to customize this separator.

```typescript
const [Grid] = useVbenVxeGrid({
  formOptions: {},
  gridOptions: {},
  // Completely remove the separator
  separator: false,
  // You can also use the following code to remove the separator
  // separator: { show: false },
  // Or use the following code to change the separator color
  // separator: { backgroundColor: 'rgba(100,100,0,0.5)' },
});
```

## API

useVbenVxeGrid returns an array, the first element is the table component, and the second element is the table methods.

```vue
<script setup lang="ts">
import { useVbenVxeGrid } from '#/adapter/vxe-table';

// Grid is the table component
// gridApi is the table methods
const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions: {},
  formOptions: {},
  gridEvents: {},
  // Properties
  // Events
});
</script>

<template>
  <Grid />
</template>
```

## GridApi Methods

The second parameter returned by useVbenVxeGrid is an object containing some table methods.

### setLoading
- **Description**: Set loading state
- **Type**: `(loading: boolean) => void`

### setGridOptions
- **Description**: Set vxe-table grid component parameters
- **Type**: `(options: Partial<VxeGridProps['gridOptions']>) => void`

### reload
- **Description**: Reload table, will initialize
- **Type**: `(params?: any) => void`

### query
- **Description**: Reload table, will keep current pagination
- **Type**: `(params?: any) => void`

### grid
- **Description**: vxe-table grid instance
- **Type**: `VxeGridInstance`

### formApi
- **Description**: vbenForm api instance
- **Type**: `FormApi`

### toggleSearchForm
- **Description**: Set search form display state
- **Type**: `(show?: boolean) => boolean`
- **Note**: When the parameter is omitted, the form will toggle between display and hide states

## Props Configuration

All properties can be passed to the first parameter of useVbenVxeGrid.

### tableTitle
- **Type**: `string`
- **Description**: Table title

### tableTitleHelp
- **Type**: `string`
- **Description**: Table title help information

### gridClass
- **Type**: `string`
- **Description**: Grid component class

### gridOptions
- **Type**: `VxeTableGridProps`
- **Description**: Grid component parameters

### gridEvents
- **Type**: `VxeGridListeners`
- **Description**: Grid component triggered events

### formOptions
- **Type**: `VbenFormProps`
- **Description**: Form parameters

### showSearchForm
- **Type**: `boolean`
- **Default**: `false`
- **Description**: Whether to display search form

### separator
- **Type**: `boolean | SeparatorOptions`
- **Default**: `true`
- **Version**: >5.5.4
- **Description**: Separator between search form and table body

### showToolbar
- **Type**: `boolean`
- **Default**: `true`
- **Description**: Whether to display toolbar

## Slots

Most slot descriptions can be found in the vxe-table official documentation, but the toolbar section has been customized and requires the following slots to customize the table toolbar:

### toolbar-actions
- **Description**: Left side of toolbar (near table title)

### toolbar-tools
- **Description**: Right side of toolbar (left of vxeTable native tool buttons)

### table-title
- **Description**: Table title slot

### Search Form Slots

For tables using search forms, all slots with names starting with form- will be passed to the form.

## Cell Editing

By specifying editConfig.mode as cell, you can implement cell editing.

```typescript
  editConfig: {
    mode: 'cell',
    trigger: 'click',
  },
```

## Row Editing

By specifying editConfig.mode as row, you can implement row editing.

```typescript
  editConfig: {
    mode: 'row',
    trigger: 'click',
  },
```

## Tree Table

The tree table data source is a flat structure. You can specify the treeConfig configuration to implement a tree table.

```typescript
treeConfig: {
  transform: true, // Specify table as tree table
  parentField: 'parentId', // Parent node field name
  rowField: 'id', // Row data field name
},
```

## Fixed Header/Columns

Column fixed optional parameters: `'left' | 'right' | '' | null`

## Custom Cell

There are two ways to implement custom cells:

1. Through slots
2. Through customCell to customize cells, but you need to add a renderer first

```typescript
// Table configuration can use cellRender: { name: 'CellImage' }
vxeUI.renderer.add('CellImage', {
  renderDefault(_renderOpts, params) {
    const { column, row } = params;
    return h(Image, { src: row[column.field] } as any); // Note: Image component comes from Antd, needs to be imported, otherwise it will use js Image class
  },
});

// Table configuration can use cellRender: { name: 'CellLink' }
vxeUI.renderer.add('CellLink', {
  renderDefault(renderOpts) {
    const { props } = renderOpts;
    return h(
      Button,
      { size: 'small', type: 'link' },
      { default: () => props?.text },
    );
  },
});
```

## Virtual Scrolling

Enable through the combination of scroll-y.enabled and scroll-y.gt, where enabled is the master switch, and gt means automatically enable when the total number of rows is greater than the specified number of rows.

Detailed documentation: https://vxetable.cn/v4/#/component/grid/scroll/vertical
