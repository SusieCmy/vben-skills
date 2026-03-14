# Vben Drawer Component Reference Documentation

## Component Overview
Vben Drawer is a drawer component provided by the framework, supporting auto-height, loading, and other features.

## Important Notes

- If the existing component encapsulation doesn't meet your needs, you can use native components or create your own custom component
- The framework-provided components are not mandatory - use them based on your requirements
- Some internationalization and theme color issues may appear in documentation examples but won't occur in actual usage

## Basic Usage
Use `useVbenDrawer` to create a basic drawer.

## Component Separation
Drawer content can be complex in business scenarios, so it's recommended to extract the drawer content into a separate component for reusability. Use the `connectedComponent` parameter to connect internal and external components without additional operations.

## Auto Height Calculation
The drawer automatically calculates content height. When content exceeds a certain height, a scrollbar appears. This works with loading effects and the `prepend-footer` slot.

## Using API
Use `drawerApi` to call drawer methods and `setState` to update drawer state.

## Data Sharing
When using the `connectedComponent` parameter, internal and external components share data. Use `drawerApi` to get and set data, combined with `onOpenChange`, to meet most requirements.

## Priority Rules

**Parameter Priority**: `slot > props > state` (state updated via API and useVbenDrawer parameters)

- If you've passed a slot or props, `setState` won't take effect
- In this case, update state through slot or props instead

**Connected Component Priority**:
- When using `connectedComponent`, there are 2 `useVbenDrawer` instances
- If the same parameter is set in both, the internal one (without `connectedComponent`) takes precedence
- Example: If both set `onConfirm`, the internal `onConfirm` is used
- Exception: `onOpenChange` event triggers in both internal and external components

**Destroy Configuration**:
- When using `connectedComponent`, you can configure `destroyOnClose` to decide whether to destroy the connectedComponent when closing the drawer
- After destruction, the component is recreated, and all internal variables, state, and data are restored to their initial state

**Default Properties**:
- If default behavior doesn't meet expectations, modify `setDefaultDrawerProps` parameters in `src\bootstrap.ts`
- Examples: Hide fullscreen button by default, modify default ZIndex, etc.

## API

```typescript
// Drawer is the drawer component
// drawerApi provides drawer methods
const [Drawer, drawerApi] = useVbenDrawer({
  // Properties
  // Events
});
```

## Props Configuration

All properties can be passed to the first parameter of useVbenDrawer.

### appendToMain
- **Type**: `boolean`
- **Default**: `false`
- **Description**: Whether to mount to content area (default mounts to body)
- **Note**: When mounting to content area, the Page component as the page root container needs to set the auto-content-height property

### connectedComponent
- **Type**: `Component`
- **Default**: -
- **Description**: Connect another Drawer component

### destroyOnClose
- **Type**: `boolean`
- **Default**: `false`
- **Description**: Destroy on close

### title
- **Type**: `string | slot`
- **Default**: -
- **Description**: Title

### titleTooltip
- **Type**: `string | slot`
- **Default**: -
- **Description**: Title tooltip information

### description
- **Type**: `string | slot`
- **Default**: -
- **Description**: Description information

### isOpen
- **Type**: `boolean`
- **Default**: `false`
- **Description**: Drawer open state

### loading
- **Type**: `boolean`
- **Default**: `false`
- **Description**: Drawer loading state

### closable
- **Type**: `boolean`
- **Default**: `true`
- **Description**: Show close button

### closeIconPlacement
- **Type**: `'left' | 'right'`
- **Default**: `right`
- **Description**: Close button position

### modal
- **Type**: `boolean`
- **Default**: `true`
- **Description**: Show overlay

### header
- **Type**: `boolean`
- **Default**: `true`
- **Description**: Show header

### footer
- **Type**: `boolean | slot`
- **Default**: `true`
- **Description**: Show footer

### confirmLoading
- **Type**: `boolean`
- **Default**: `false`
- **Description**: Confirm button loading state

### closeOnClickModal
- **Type**: `boolean`
- **Default**: `true`
- **Description**: Close drawer on overlay click

### closeOnPressEscape
- **Type**: `boolean`
- **Default**: `true`
- **Description**: Close drawer on ESC key

### confirmText
- **Type**: `string | slot`
- **Default**: Confirm
- **Description**: Confirm button text

### cancelText
- **Type**: `string | slot`
- **Default**: Cancel
- **Description**: Cancel button text

### placement
- **Type**: `'left' | 'right' | 'top' | 'bottom'`
- **Default**: `right`
- **Description**: Drawer placement position

### showCancelButton
- **Type**: `boolean`
- **Default**: `true`
- **Description**: Show cancel button

### showConfirmButton
- **Type**: `boolean`
- **Default**: `true`
- **Description**: Show confirm button

### class
- **Type**: `string`
- **Default**: -
- **Description**: Drawer class, width configured through this

### contentClass
- **Type**: `string`
- **Default**: -
- **Description**: Drawer content area class

### footerClass
- **Type**: `string`
- **Default**: -
- **Description**: Drawer footer area class

### headerClass
- **Type**: `string`
- **Default**: -
- **Description**: Drawer header area class

### zIndex
- **Type**: `number`
- **Default**: `1000`
- **Description**: Drawer ZIndex level

### overlayBlur
- **Type**: `number`
- **Default**: -
- **Description**: Overlay blur degree

## DrawerApi Methods

### setState
- **Description**: Dynamically set drawer state properties
- **Type**: `(((prev: ModalState) => Partial<ModalState>) | Partial<ModalState>) => drawerApi`

### open
- **Description**: Open drawer
- **Type**: `() => void`

### close
- **Description**: Close drawer
- **Type**: `() => void`

### setData
- **Description**: Set shared data
- **Type**: `<T>(data: T) => drawerApi`

### getData
- **Description**: Get shared data
- **Type**: `<T>() => T`

### useStore
- **Description**: Get reactive state
- **Type**: -

### lock
- **Description**: Mark drawer as submitting, lock current state
- **Type**: `(isLock: boolean) => drawerApi`
- **Version**: >5.5.3
- **Details**: Used to lock the drawer state, generally used during data submission to prevent users from resubmitting or the drawer being accidentally closed, form data being changed, etc. When in locked state, the drawer's confirm button becomes loading state, while disabling cancel and close buttons, preventing ESC or overlay click from closing the drawer, and enabling the drawer's spinner animation to cover content. Calling the close method to close a locked drawer will automatically unlock it.

### unlock
- **Description**: Reverse operation of lock method, unlock drawer state, also an alias for lock(false)
- **Type**: `() => drawerApi`
- **Version**: >5.5.3

## Events

The following events only take effect when passed in `useVbenDrawer({onCancel:()=>{}})`.

### onBeforeClose
- **Description**: Triggered before closing, returning false prevents closing
- **Type**: `() => boolean`

### onCancel
- **Description**: Triggered when cancel button is clicked
- **Type**: `() => void`

### onClosed
- **Description**: Triggered when close animation completes
- **Type**: `() => void`
- **Version**: >5.5.2

### onConfirm
- **Description**: Triggered when confirm button is clicked
- **Type**: `() => void`

### onOpenChange
- **Description**: Triggered when drawer opens or closes
- **Type**: `(isOpen: boolean) => void`

### onOpened
- **Description**: Triggered when open animation completes
- **Type**: `() => void`
- **Version**: >5.5.2

## Slots

In addition to the property types containing slot above, you can also customize drawer content through slots.

### default
- **Description**: Default slot - drawer content

### prepend-footer
- **Description**: Left side of cancel button

### center-footer
- **Description**: Between cancel and confirm buttons (effective when not using footer slot)

### append-footer
- **Description**: Right side of confirm button

### close-icon
- **Description**: Close button icon

### extra
- **Description**: Extra content (right side of title)

## Using Templates

**For specific template usage and code examples, please refer to**: `assets/drawer-template.md`
