# Vben CountToAnimator

The framework provides a number animation component that supports number animation effects.

If the documentation does not include parameter descriptions, try looking in the online examples.

**For specific usage examples and code templates, please refer to**: `assets/count-to-template.md`

## Important Notes

If the existing component encapsulation doesn't meet your needs, you can use native components or create your own custom component. The framework-provided components are not mandatory - use them based on your requirements.

## Basic Usage

Set the start and end values of the number animation through start-val and end-val, with a duration of 3000ms.

Example: 30,000

## Custom Prefix and Separator

Set the prefix and separator of the number animation through prefix and separator.

Example: $2/000/000

## Props

### startVal
- **Type**: `number`
- **Default**: `0`
- **Description**: Start value

### endVal
- **Type**: `number`
- **Default**: `2021`
- **Description**: End value

### duration
- **Type**: `number`
- **Default**: `1500`
- **Description**: Animation duration

### autoplay
- **Type**: `boolean`
- **Default**: `true`
- **Description**: Auto execute

### prefix
- **Type**: `string`
- **Default**: -
- **Description**: Prefix

### suffix
- **Type**: `string`
- **Default**: -
- **Description**: Suffix

### separator
- **Type**: `string`
- **Default**: `,`
- **Description**: Separator

### color
- **Type**: `string`
- **Default**: -
- **Description**: Font color

### useEasing
- **Type**: `boolean`
- **Default**: `true`
- **Description**: Whether to enable animation

### transition
- **Type**: `string`
- **Default**: `linear`
- **Description**: Animation effect

### decimals
- **Type**: `number`
- **Default**: `0`
- **Description**: Number of decimal places to keep

## Events

### started
- **Type**: `() => void`
- **Description**: Animation has started

### finished
- **Type**: `() => void`
- **Description**: Animation has finished

### onStarted
- **Type**: `() => void`
- **Description**: Animation has started

### onFinished
- **Type**: `() => void`
- **Description**: Animation has finished

## Methods

### start
- **Type**: `() => void`
- **Description**: Start executing animation

### reset
- **Type**: `() => void`
- **Description**: Reset
