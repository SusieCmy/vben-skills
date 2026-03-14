# Vben Alert

The framework provides some lightweight prompt dialogs that can be quickly created dynamically using only JS code without writing any code in the template.

**For specific usage examples and code templates, please refer to**: `assets/alert-template.md`

## Important Notes

If the existing component encapsulation doesn't meet your needs, you can use native components or create your own custom component. The framework-provided components are not mandatory - use them based on your requirements.

## Application Scenarios

Alert provides similar functionality to Modal, but is only suitable for simple application scenarios. For example, temporarily and dynamically popping up modal confirmation boxes, input boxes, etc. If you have more complex requirements for dialogs, please use VbenModal.

## Note

The shortcut methods alert, confirm, and prompt provided by Alert do not support HMR (hot module replacement) when the dynamically created dialogs are already open. After code changes, you need to close these dialogs and reopen them.

## useAlertContext

When the content, footer, or icon of the dialog uses custom components, you can use useAlertContext in these components to get the context object of the current dialog to actively control the dialog.

**Note**: useAlertContext can only be used in setup or functional components.

### Methods

#### doConfirm
- **Type**: `() => void`
- **Version**: >5.5.4
- **Description**: Call the confirm operation of the dialog

#### doCancel
- **Type**: `() => void`
- **Version**: >5.5.4
- **Description**: Call the cancel operation of the dialog

## Type Definitions

### IconType

```typescript
/** Preset icon types */
export type IconType = 'error' | 'info' | 'question' | 'success' | 'warning';
```

### BeforeCloseScope

```typescript
export type BeforeCloseScope = {
  /** Whether the close is triggered by clicking the confirm button */
  isConfirm: boolean;
};
```

### AlertProps

```typescript
export type AlertProps = {
  /** Callback before closing, if returns false, the close will be terminated */
  beforeClose?: (
    scope: BeforeCloseScope,
  ) => boolean | Promise<boolean | undefined> | undefined;
  /** Border */
  bordered?: boolean;
  /** Button alignment */
  buttonAlign?: 'center' | 'end' | 'start';
  /** Cancel button title */
  cancelText?: string;
  /** Whether to center display */
  centered?: boolean;
  /** Confirm button title */
  confirmText?: string;
  /** Extra style for dialog container */
  containerClass?: string;
  /** Dialog prompt content */
  content: Component | string;
  /** Extra style for dialog content */
  contentClass?: string;
  /** Display a loading mask in the content area during beforeClose callback execution */
  contentMasking?: boolean;
  /** Dialog footer content (in the same container as buttons) */
  footer?: Component | string;
  /** Dialog icon (before the title) */
  icon?: Component | IconType;
  /** Dialog overlay blur effect */
  overlayBlur?: number;
  /** Whether to show cancel button */
  showCancel?: boolean;
  /** Dialog title */
  title?: string;
};
```

### PromptProps

```typescript
export type PromptProps<T = any> = {
  /** Callback before closing, if returns false, the close will be terminated */
  beforeClose?: (scope: {
    isConfirm: boolean;
    value: T | undefined;
  }) => boolean | Promise<boolean | undefined> | undefined;
  /** Component for accepting user input */
  component?: Component;
  /** Properties of the input component */
  componentProps?: Recordable<any>;
  /** Slots of the input component */
  componentSlots?: Recordable<Component>;
  /** Default value */
  defaultValue?: T;
  /** Value property name of the input component */
  modelPropName?: string;
} & Omit<AlertProps, 'beforeClose'>;
```

## Function Signatures

### alert / confirm

```typescript
/**
 * Function signatures for alert and confirm are the same.
 * confirm shows cancel button by default, while alert only has one button by default
 */
export function alert(options: AlertProps): Promise<void>;
export function alert(
  message: string,
  options?: Partial<AlertProps>,
): Promise<void>;
export function alert(
  message: string,
  title?: string,
  options?: Partial<AlertProps>,
): Promise<void>;
```

### prompt

```typescript
/**
 * Function signature for popping up input box.
 * beforeClose parameter will pass the current input value
 * component specifies the component to accept user input, default is Input
 * componentProps sets property data for the input component
 * defaultValue is the default value
 * modelPropName is the value property name of the input component, default is modelValue
 */
export async function prompt<T = any>(
  options: Omit<AlertProps, 'beforeClose'> & {
    beforeClose?: (
      scope: BeforeCloseScope & {
        /** Current value of the input component */
        value: T;
      },
    ) => boolean | Promise<boolean | undefined> | undefined;
    component?: Component;
    componentProps?: Recordable<any>;
    defaultValue?: T;
    modelPropName?: string;
  },
): Promise<T | undefined>;
```
