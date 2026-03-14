# Vben Form Component Reference Documentation
## Component Overview
Vben Form is a form component provided by the framework, compatible with UI frameworks such as Ant Design Vue, Element Plus, and Naive UI. It uses vee-validate for underlying form validation.

## Basic Usage
Use `useVbenForm` to create a form instance and configure form fields via schema.

## Schema Configuration
### fieldName
- **Type**: `string`
- **Required**: Yes
- **Description**: Field name, corresponding to the key of the form data

### label
- **Type**: `string`
- **Default**: None
- **Description**: Field label text

### component
- **Type**: `string`
- **Required**: Yes
- **Description**: The type of component used
- **Optional**: `Input`, `Select`, `DatePicker`, `Checkbox`, `Radio`, `Switch`, `Textarea`, `InputNumber`, etc.

### componentProps
- **Type**: `object`
- **Default**: `{}`
- **Description**: Props passed to the component

### defaultValue
- **Type**: `any`
- **Default**: None
- **Description**: Default value for the field

### rules
- **Type**: `string | object`
- **Default Value**: None
- **Description**: Validation rules, supports vee-validate rules and zod schema

#### Complex Validation using zod
```typescript
import { z } from '#/adapter/form';
// Basic type
{
  rules: z.string().min(1, { message: 'Please enter a string' });
}
// Optional (can be undefined), and carries a default value
{
  rules: z.string().default('default value').optional();
}
// Can be an empty string, undefined, or an email address
{
  rules: z.union([z.string().email().optional(), z.literal('')]);
}
{
  rules: z.string().email().or(z.literal('')).optional();
}
// Complex validation
{
  rules: z.string()
    .min(1, { message: 'Please enter' })
    .refine((value) => value === '123', {
      message: 'Value must be 123',
    });
}
```

### dependencies
- **Type**: `object`
- **Default**: None
- **Description**: Field dependency configuration, used for form cascading

#### dependencies configuration items
```typescript
dependencies: {
  // Trigger fields; cascading will only trigger when these field values ​​change
  triggerFields: ['name'],
  // Dynamically determine whether the current field needs to be displayed; if not, destroy it directly
  if(values, formApi) {},
  // Dynamically determine whether the current field needs to be displayed; if not, hide it using CSS
  show(values, formApi) {},
  // Dynamically determine whether the current field needs to be disabled
  disabled(values, formApi) {},
  // This function is triggered whenever a field changes:
  trigger(values, formApi) {},
  // Dynamic rules
  rules(values, formApi) {},
  // Dynamic required fields
  required(values, formApi) {},
  // Dynamic component parameters
  componentProps(values, formApi) {},
}
```

## FormApi Methods
The second parameter returned by useVbenForm contains the following methods:
### submitForm
- **Description**: Submits the form
- **Type**: `(e:Event)=>Promise<Record<string,any>>`

### validateAndSubmitForm
- **Description**: Submits and validates the form
- **Type**: `(e:Event)=>Promise<Record<string,any>>`

### resetForm
- **Description**: Resets the form
- **Type**: `()=>Promise<void>`

### `setValues`
- **Description**: Sets form values. By default, it filters fields not defined in the schema.
- **Type**: `(fields: Record<string, any>, filterFields?: boolean, shouldValidate?: boolean) => Promise<void>`

### getValues
- **Description**: Retrieves form values.
- **Type**: `(fields:Record<string, any>,shouldValidate: boolean = false)=>Promise<void>`

### validate
- **Description**: Form validation.
- **Type**: `()=>Promise<void>`

### validateField
- **Description**: Validates a specified field.
- **Type**: `(fieldName: string)=>Promise<ValidationResult<unknown>>`

### isFieldValid
- **Description**: Checks if a field has passed validation.
- **Type**: `(fieldName: string)=>Promise<ValidationResult<unknown>>` `string)=>Promise<boolean>`

### resetValidate
- **Description**: Resets form validation
- **Type**: `()=>Promise<void>`

### updateSchema
- **Description**: Updates formSchema
- **Type**: `(schema:FormSchema[])=>void`

### setFieldValue
- **Description**: Sets field value
- **Type**: `(field: string, value: any, shouldValidate?: boolean)=>Promise<void>`

### setState
- **Description**: Sets the component state (props)
- **Type**: `(stateOrFn:| ((prev: VbenFormProps) => Partial<VbenFormProps>)| Partial<VbenFormProps>)=>Promise<void>`

### getState
- **Description**: Gets the component state (props)
- **Type**: `()=>Promise<VbenFormProps>`

### getFieldComponentRef
- **Description**: Gets the component instance for the specified field
- **Type**: `<T=unknown>(fieldName: string)=>T`

### getFocusedField
- **Description**: Gets the field that currently has focus
- **Type**: `()=>string|undefined`

## Props Configuration
All properties can be passed to the first parameter of useVbenForm.

### layout
- **Description**: Form item layout
- **Type**: `'horizontal' | 'vertical' | 'inline'`
- **Default**: `horizontal`

### showCollapseButton
- **Description**: Whether to display the collapse button
- **Type**: `boolean`
- **Default**: `false`

### wrapperClass
- **Description**: Form layout, based on tailwindcss
- **Type**: `any`

### actionWrapperClass
- **Description**: Form action area class
- **Type**: `any`

### actionLayout
- **Description**: Form action button position
- **Type**: `'newLine' | 'rowEnd' | 'inline'`
- **Default**: `rowEnd`

### actionPosition
- **Description**: Form action button alignment
- **Type**: `'left' | 'center' | 'right'`
- **Default Value**: `right`

### handleReset
- **Description**: Form reset callback
- **Type**: `(values: Record<string, any>) => Promise<void> | void`

### handleSubmit
- **Description**: Form submission callback
- **Type**: `(values: Record<string, any>) => Promise<void> | void`

### handleValuesChange
- **Description**: Form value change callback
- **Type**: `(values: Record<string, any>, fieldsChanged: string[]) => void`
- **Note**:
- The first parameter, `values`, contains the current value object after the form changes.
- The second parameter, `fieldsChanged`, is an array containing all changed field names (available in v5.5.4+).
- `fieldsChanged` only contains field names defined in the schema, not mapped field names.

### handleCollapsedChange
- **Description**: Form collapse/expand state change callbacks
- **Type**: `(collapsed: boolean) => void`

### actionButtonsReverse
- **Description**: Reverses the position of action buttons
- **Type**: `boolean`
- **Default**: `false`

### showDefaultActions
- **Description**: Whether to show the default action buttons
- **Type**: `boolean`
- **Default**: `true`

### collapsed
- **Description**: Whether to collapse, takes effect when showCollapseButton is true
- **Type**: `boolean`
- **Default**: `false`

### collapseTriggerResize
- **Description**: Triggers the resize event when collapsed
- **Type**: `boolean`
- **Default**: `false`

### collapsedRows
- **Description**: The number of rows to retain when collapsed
- **Type**: `number`
- **Default**: `1`

### fieldMappingTime
- **Description**: Maps array values ​​within a form to two fields.
- **Type**: `[string, [string, string], Nullable<string>|[string,string]|((any,string)=>any)?][]`
- **Example**: `[['timeRange', ['startTime', 'endTime'], 'YYYY-MM-DD']]`
- **Note**:
- First parameter: The field name to be mapped
- Second parameter: The array of mapped field names
- Third parameter (optional): Format mask or formatting function
- Setting to null will result in unformatted mapping of the original value (applicable to non-date and time fields)

### commonConfig
- **Description**: General configuration for form items; each configuration is passed to every form item.
- **Type**: `FormCommonConfig`

### schema
- **Description**: Configuration for each form item.
- **Type**: `FormSchema[]`

### submitOnEnter
- **Description**: Submit the form when the Enter key is pressed
- **Type**: `boolean`
- **Default**: `false`

### submitOnChange
- **Description**: Submit the form when a field value changes (internal debouncing)
- **Type**: `boolean`
- **Default**: `false`

### compact
- **Description**: Whether to use compact mode (ignores space reserved for validation information)
- **Type**: `boolean`
- **Default**: `false`

### scrollToFirstError
- **Description**: Whether to automatically scroll to the first error field when form validation fails
- **Type**: `boolean`
- **Default**: `false`

## Using Templates
**For specific template usage and code examples, please refer to**: `assets/form-template.md`

## Slots
### Built-in Slots
| Slot Name | Description |
|--------|------|
| reset-before | Position before the reset button |
| submit-before | Position before the submit button |
| expand-before | Position before the expand button |
| expand-after | Position after the expand button |

### Field Slots
In addition to the built-in slots mentioned above, the fieldName of each field in the schema attribute can be used as a slot name.

**Important Notes**:
- Field slots have higher priority than components defined in the component attribute.
- When a slot with the same name as fieldName is provided, the slot content will be used as a component of that field.
- In this case, the value of component will be ignored.

## TypeScript Type Definitions
### ActionButtonOptions
```typescript
interface ActionButtonOptions {
  class?: ClassType; // Style
  disabled?: boolean; // Whether disabled
  loading?: boolean; // Whether loading
  size?: ButtonVariantSize; // Button size
  variant?: ButtonVariants; // Button type
  show?: boolean; // Whether to show
  content?: string; // Button text
  [key: string]: any; // Any property
}
```

### FormCommonConfig
```typescript
interface FormCommonConfig {
  componentProps?: ComponentProps; // Props for all form items
  controlClass?: string; // Control styles for all form items
  colon?: boolean; // Display a colon after the label
  disabled?: boolean; // Disabled status for all form items
  formFieldProps?: Partial<typeof Field>; // Styles for all form items
  formItemClass?: (() => string) | string; // Grid layout for all form items
  hideLabel?: boolean; // Hide all form item labels
  hideRequiredMark?: boolean; // Whether to hide required markers
  labelClass?: string; // Label style for all form items
  labelWidth?: number; // Label width for all form items
  modelPropName?: string; // Model property name (default "modelValue")
  wrapperClass?: string; // Wrapper style for all form items
}
```

### FormSchema
```typescript
interface FormSchema<T = BaseFormComponentType> extends FormCommonConfig {
  component: Component | T; // Component
  componentProps?: ComponentProps; // Component parameters
  defaultValue?: any; // Default value
  dependencies?: FormItemDependencies; // Dependencies
  description?: string; // Description
  fieldName: string; // Field name (required)
  help?: CustomRenderType; // Help information
  hide?: boolean; // Whether to hide form items
  label?: CustomRenderType; // Form label
  renderComponentContent?: RenderComponentContentType; // Custom component internal rendering
  rules?: FormSchemaRuleType; // Field rules
  suffix?: CustomRenderType; // Suffix
}
