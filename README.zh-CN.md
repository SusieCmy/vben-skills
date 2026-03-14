# Vue Vben CRUD Skill

[English](README.md) | [中文](README.zh-CN.md)

一个强大的技能，用于在 Vue Vben Admin 项目中生成完整的 CRUD 模块。

## 安装

```bash
npx skills add https://github.com/SusieCmy/vben-skills --skill vue-vben-crud
```

## 功能特性

- 🚀 完整 CRUD 生成：页面、表单、表格、API 接口、路由
- 📝 类型安全，完整 TypeScript 支持
- 🎨 使用 Vben 内置组件（Modal、Drawer、Table、Form）
- ✅ 自动化质量检查和验证
- 📚 文档驱动的组件使用

## 快速开始

### 触发短语

- "生成 CRUD"
- "创建模块"
- "新增页面"
- "创建 xxx 管理"

### 生成结构

```
src/
├── api/[module]/
│   ├── types.ts              # 类型定义
│   └── index.ts              # API 方法
├── router/routes/modules/
│   └── [module].ts           # 路由配置
└── views/[module]/
    ├── index.vue             # 主页面（表格）
    ├── data.ts               # 表格列配置和搜索表单
    └── modules/
        └── form.vue          # 表单组件
```

## 使用示例

### 方式一：对话式生成

**用户：** "创建用户管理模块"

**AI 会询问：**
1. 模块名称？（如 `user`）
2. 字段列表？（如 `name, email, role, status`）
3. 是否需要多标签页？
4. 特殊功能需求？

**AI 会生成：**
- 完整 CRUD 代码
- 类型安全的 API 接口
- 带过滤器的搜索表单
- Modal/Drawer 表单
- 带分页的表格

### 方式二：一键触发（推荐）

直接提供完整需求，AI 无需询问直接生成：

```markdown
# 页面名称
- 推送管理

# 页面展示
**搜索条件**
- 推送标题、推送类型、推送状态、推送时间

**表格字段**
- 表格左上展示新增按钮
- 标题、文案、创建时间、推送时间、推送人数、操作（编辑、删除、推送）

**编辑/新增表单字段**
- 使用弹窗组件展示表单
- 标题（必填）
- 文案（必填）
- 推送类型（必填，单选：系统消息、营销消息）
- 推送时间（必填，日期时间选择器）

# 接口对接
- 接口地址：api/push
- 请求类型：GET/POST/DELETE/PUT
- 请求字段：
\`\`\`typescript
{
  title: string; // 推送标题
  content: string; // 推送文案
  type: 'system' | 'marketing'; // 推送类型
  status: 'draft' | 'scheduled' | 'sent'; // 推送状态
  pushTime: string; // 推送时间 (ISO 8601 格式)
}
\`\`\`
- 响应字段：
\`\`\`typescript
{
  id: number; // 推送ID
  title: string; // 推送标题
  content: string; // 推送文案
  type: 'system' | 'marketing'; // 推送类型
  status: 'draft' | 'scheduled' | 'sent'; // 推送状态
  pushTime: string; // 推送时间
  createTime: string; // 创建时间
}
\`\`\`
```

**便捷方式：** 将后端接口文档直接复制到 `.md` 文件中，让 AI 读取接口文档自动生成。

**完整模板：** 参考 `assets/quick-start-template.md`

## 组件文档

| 组件类型 | API 参考 | 使用示例 |
|---|---|---|
| 表单 | `references/vben-form.md` | `assets/form-template.md` |
| 表格 | `references/vben-table.md` | `assets/table-usage-template.md` |
| 弹窗 | `references/vben-modal.md` | `assets/modal-template.md` |
| 抽屉 | `references/vben-drawer.md` | `assets/drawer-template.md` |

## 质量检查

### 自动化检查
```bash
bash .claude/skills/vue-vben-crud/scripts/check.sh src/api/user src/views/user
```

验证项：
- ✅ TypeScript 类型正确性
- ✅ 必需文件完整性
- ✅ 导入路径（必须使用 `#/` 别名）
- ⚠️ 无 `any` 类型滥用

### 手动检查
- 组件 API 使用符合文档
- 文件间类型一致性
- API 参数与类型定义匹配

## 最佳实践

1. 使用 `#/` 别名导入
2. 遵循 TypeScript 严格模式
3. 仅使用框架组件
4. 保持代码简洁
5. 使用 zod 验证表单

## 故障排查

### 导入路径
❌ `import { useVbenForm } from '../../../adapter/form'`
✅ `import { useVbenForm } from '#/adapter/form'`

### 类型定义
始终先在 `types.ts` 中定义：
```typescript
export interface User { id: number; name: string; }
```

## 许可证

MIT

