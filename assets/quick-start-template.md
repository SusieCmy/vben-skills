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
```typescript
{
  title: string; // 推送标题
  content: string; // 推送文案
  type: 'system' | 'marketing'; // 推送类型
  status: 'draft' | 'scheduled' | 'sent'; // 推送状态
  pushTime: string; // 推送时间 (ISO 8601 格式)
}
```
- 响应字段：
```typescript
{
  id: number; // 推送ID
  title: string; // 推送标题
  content: string; // 推送文案
  type: 'system' | 'marketing'; // 推送类型
  status: 'draft' | 'scheduled' | 'sent'; // 推送状态
  pushTime: string; // 推送时间
  createTime: string; // 创建时间
}
```

---

## 便捷方式

将后端接口文档直接复制到 `.md` 文件中，让 AI 读取接口文档自动生成。
