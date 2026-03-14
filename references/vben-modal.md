# Vben Modal Component Reference Documentation

## Component Overview
Vben Modal is a modal dialog component provided by the framework, supporting drag-and-drop, fullscreen, auto-height, loading, and other features.

## Important Notes

- If the existing component encapsulation doesn't meet your needs, you can use native components or create your own custom component
- The framework-provided components are not mandatory - use them based on your requirements
- Some internationalization and theme color issues may appear in documentation examples but won't occur in actual usage

## Basic Usage
Use `useVbenModal` to create a basic modal dialog.

## Component Separation
Modal content can be complex in business scenarios, so it's recommended to extract the modal content into a separate component for reusability. Use the `connectedComponent` parameter to connect internal and external components without additional operations.

## Draggable
Enable drag-and-drop functionality using the `draggable` parameter.

## Auto Height Calculation
The modal automatically calculates content height. When content exceeds a certain height, a scrollbar appears. This works with loading effects and the `prepend-footer` slot.

## Using API
Use `modalApi` to call modal methods and `setState` to update modal state.

## Data Sharing
When using the `connectedComponent` parameter, internal and external components share data. Use `modalApi` to get and set data, combined with `onOpenChange`, to meet most requirements.

## Animation Types
Control modal animation effects using the `animationType` property:

- `slide` (default): Slides down from top on enter/exit
- `scale`: Scale fade in/out effect

## Priority Rules

**Parameter Priority**: `slot > props > state` (state updated via API and useVbenModal parameters)

- If you've passed a slot or props, `setState` won't take effect
- In this case, update state through slot or props instead

**Connected Component Priority**:
- When using `connectedComponent`, there are 2 `useVbenModal` instances
- If the same parameter is set in both, the internal one (without `connectedComponent`) takes precedence
- Example: If both set `onConfirm`, the internal `onConfirm` is used
- Exception: `onOpenChange` event triggers in both internal and external components
- If `destroyOnClose` is set, the internal Modal and its child components will be completely destroyed after closing

**Default Properties**:
- If default behavior doesn't meet expectations, modify `setDefaultModalProps` parameters in `src\bootstrap.ts`
- Examples: Hide fullscreen button by default, modify default ZIndex, etc.

## API

```typescript
// Modal is the modal component
// modalApi provides modal methods
const [Modal, modalApi] = useVbenModal({
  // Properties
  // Events
});
```

## Props Configuration

All properties can be passed to the first parameter of useVbenModal.

### appendToMain
- **Type**: `boolean`
- **Default**: `false`
- **Description**: Whether to mount to content area (default mounts to body)
- **Note**: When mounting to content area, the Page component as the page root container needs to set the auto-content-height property

### connectedComponent
- **Type**: `Component`
- **Default**: -
- **Description**: Connect another Modal component

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
- **Description**: Modal open state

### loading
- **Type**: `boolean`
- **Default**: `false`
- **Description**: Modal loading state

### fullscreen
- **Type**: `boolean`
- **Default**: `false`
- **Description**: Fullscreen display

### fullscreenButton
- **Type**: `boolean`
- **Default**: `true`
- **Description**: Show fullscreen button

### draggable
- **Type**: `boolean`
- **Default**: `false`
- **Description**: Draggable

### closable
- **Type**: `boolean`
- **Default**: `true`
- **Description**: Show close button

### centered
- **Type**: `boolean`
- **Default**: `false`
- **Description**: Centered display

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

### confirmDisabled
- **Type**: `boolean`
- **Default**: `false`
- **Description**: Disable confirm button

### confirmLoading
- **Type**: `boolean`
- **Default**: `false`
- **Description**: Confirm button loading state

### closeOnClickModal
- **Type**: `boolean`
- **Default**: `true`
- **Description**: Close modal on overlay click

### closeOnPressEscape
- **Type**: `boolean`
- **Default**: `true`
- **Description**: Close modal on ESC key

### confirmText
- **Type**: `string | slot`
- **Default**: Confirm
- **Description**: Confirm button text

### cancelText
- **Type**: `string | slot`
- **Default**: Cancel
- **Description**: Cancel button text

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
- **Description**: Modal class, width configured through this

### contentClass
- **Type**: `string`
- **Default**: -
- **Description**: Modal content area class

### footerClass
- **Type**: `string`
- **Default**: -
- **Description**: Modal footer area class

### headerClass
- **Type**: `string`
- **Default**: -
- **Description**: Modal header area class

### bordered
- **Type**: `boolean`
- **Default**: `false`
- **Description**: Whether to show border

### zIndex
- **Type**: `number`
- **Default**: `1000`
- **Description**: Modal ZIndex level

### overlayBlur
- **Type**: `number`
- **Default**: -
- **Description**: Overlay blur degree

### animationType
- **Type**: `'slide' | 'scale'`
- **Default**: `'slide'`
- **Description**: Animation type

### submitting
- **Type**: `boolean`
- **Default**: `false`
- **Description**: Mark as submitting, lock current modal state

## ModalApi Methods

### setState
- **Description**: Dynamically set modal state properties
- **Type**: `(((prev: ModalState) => Partial<ModalState>) | Partial<ModalState>) => modalApi`

### open
- **Description**: Open modal
- **Type**: `() => void`

### close
- **Description**: Close modal
- **Type**: `() => void`

### setData
- **Description**: Set shared data
- **Type**: `<T>(data: T) => modalApi`

### getData
- **Description**: Get shared data
- **Type**: `<T>() => T`

### useStore
- **Description**: Get reactive state
- **Type**: -

### lock
- **Description**: Mark modal as submitting, lock current state
- **Type**: `(isLock: boolean) => modalApi`
- **Version**: >5.5.2
- **Details**: Used to lock the current modal state, generally used during data submission to prevent users from resubmitting or the modal being accidentally closed, form data being changed, etc. When in locked state, the modal's confirm button becomes loading state, while disabling cancel and close buttons, preventing ESC or overlay click from closing the modal, and enabling the modal's spinner animation to cover modal content. Calling the close method to close a locked modal will automatically unlock it.

### unlock
- **Description**: Reverse operation of lock method, unlock modal state, also an alias for lock(false)
- **Type**: `() => modalApi`
- **Version**: >5.5.3

## Events

The following events only take effect when passed in `useVbenModal({onCancel:()=>{}})`.

### onBeforeClose
- **Description**: Triggered before closing, returning false or being rejected prevents closing
- **Type**: `() => Promise<boolean> | boolean`
- **Version**: >5.5.2 supports Promise

### onCancel
- **Description**: Triggered when cancel button is clicked
- **Type**: `() => void`

### onClosed
- **Description**: Triggered when close animation completes
- **Type**: `() => void`
- **Version**: >5.4.3

### onConfirm
- **Description**: Triggered when confirm button is clicked
- **Type**: `() => void`

### onOpenChange
- **Description**: Triggered when modal opens or closes
- **Type**: `(isOpen: boolean) => void`

### onOpened
- **Description**: Triggered when open animation completes
- **Type**: `() => void`
- **Version**: >5.4.3

## Slots

In addition to the property types containing slot above, you can also customize modal content through slots.

### default
- **Description**: Default slot - modal content

### prepend-footer
- **Description**: Left side of cancel button

### center-footer
- **Description**: Between cancel and confirm buttons (effective when not using footer slot)

### append-footer
- **Description**: Right side of confirm button

## Using Templates

**For specific template usage and code examples, please refer to**: `assets/modal-template.md`
