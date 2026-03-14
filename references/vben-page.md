# Vben Page Component Reference Documentation
## Component Overview
Page is the standard page layout component for Vben Admin, providing the page structure: header, content area, and footer.

## Component Properties (Props)
### title
- **Type**: `string | slot`
- **Default**: None
- **Description**: Page title, can be passed via prop or slot

### description
- **Type**: `string | slot`
- **Default**: None
- **Description**: Page description text, displayed below the title

### contentClass
- **Type**: `string`
- **Default**: None
- **Description**: Custom CSS class name for the content area

### headerClass
- **Type**: `string`
- **Default**: None
- **Description**: Custom CSS class name for the header area

### footerClass
- **Type**: `string`
- **Default**: None
- **Description**: Custom CSS class name for the footer area

### autoContentHeight
- **Type**: `boolean`
- **Default**: `false`
- **Description**: Automatically adjust content area height

## Slots
### default
- **Description**: Main content area of ​​the page

### title
- **Description**: Custom page title (higher priority than the title prop)

### description
- **Description**: Custom page description (higher priority than the description prop)

### extra
- **Description**: Extra content area on the right side of the page header

### footer
- **Description**: Content area at the bottom of the page

## Important Notes
**Header Rendering Rules**:
- If `title`, `description`, and `extra` have no content (whether via props or slots), the header area will not be rendered.
- At least one of them must be provided for the header to be displayed.

## Using Templates
**For specific template usage and code examples, please refer to**: `assets/page-template.md`