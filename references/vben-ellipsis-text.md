# Vben EllipsisText

The framework provides a text display component that can be configured with long text ellipsis, tooltip prompts, expand/collapse, and other features.

**For specific usage examples and code templates, please refer to**: `assets/ellipsis-text-template.md`

## Important Notes

If the existing component encapsulation doesn't meet your needs, you can use native components or create your own custom component. The framework-provided components are not mandatory - use them based on your requirements.

## Basic Usage

Set the maximum width through max-width, and the excess part will display ellipsis.

## Collapsible Text Block

Set the number of lines after folding through line, and the expand property sets whether to support expand/collapse.

## Custom Tooltip

Customize the tooltip information through the tooltip slot.

## Auto Show Tooltip

Set through tooltip-when-ellipsis, only trigger tooltip when text length exceeds and causes ellipsis to appear.

## API

## Props

### expand
- **Type**: `boolean`
- **Default**: `false`
- **Description**: Support click to expand or collapse

### line
- **Type**: `number`
- **Default**: `1`
- **Description**: Maximum number of text lines

### maxWidth
- **Type**: `number | string`
- **Default**: `'100%'`
- **Description**: Maximum width of text area

### placement
- **Type**: `'bottom' | 'left' | 'right' | 'top'`
- **Default**: `'top'`
- **Description**: Position of tooltip

### tooltip
- **Type**: `boolean`
- **Default**: `true`
- **Description**: Enable text tooltip

### tooltipWhenEllipsis
- **Type**: `boolean`
- **Default**: `false`
- **Description**: Auto enable text tooltip when content exceeds

### ellipsisThreshold
- **Type**: `number`
- **Default**: `3`
- **Description**: Only effective after setting tooltipWhenEllipsis, pixel difference threshold for text truncation detection, the larger the stricter the judgment, you can set the threshold yourself if you encounter abnormal situations

### tooltipBackgroundColor
- **Type**: `string`
- **Default**: -
- **Description**: Background color of tooltip text

### tooltipColor
- **Type**: `string`
- **Default**: -
- **Description**: Color of tooltip text

### tooltipFontSize
- **Type**: `string`
- **Default**: -
- **Description**: Font size of tooltip text

### tooltipMaxWidth
- **Type**: `number`
- **Default**: -
- **Description**: Maximum width of tooltip. If not set, it will keep consistent with text width

### tooltipOverlayStyle
- **Type**: `CSSProperties`
- **Default**: `{ textAlign: 'justify' }`
- **Description**: Tooltip content area style

## Events

### expandChange
- **Type**: `(isExpand: boolean) => void`
- **Description**: Expand state change

## Slots

### default
- **Description**: Text content

### tooltip
- **Description**: Used to customize tooltip content when text tooltip is enabled
