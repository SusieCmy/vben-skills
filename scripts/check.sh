#!/bin/bash
# Vue Vben CRUD Code Quality Check Script
# Usage: bash .claude/skills/vue-vben-crud/scripts/check.sh <api-path> <views-path>
# Example: bash .claude/skills/vue-vben-crud/scripts/check.sh src/api/system/push src/views/system/push

API_PATH=$1
VIEW_PATH=$2

if [ -z "$API_PATH" ] || [ -z "$VIEW_PATH" ]; then
  echo "❌ Please provide actual paths"
  echo "Usage: bash check.sh <api-path> <views-path>"
  echo "Example: bash check.sh src/api/system/push src/views/system/push"
  exit 1
fi

echo "🔍 Starting checks"
echo "   API  path: $API_PATH"
echo "   Views path: $VIEW_PATH"
ERRORS=0

# ── 1. TypeScript Type Check ──────────────────────────
echo ""
echo "📌 Step 1: TypeScript type check"

VUE_TSC=""
if [ -f "node_modules/.bin/vue-tsc" ]; then
  VUE_TSC="node_modules/.bin/vue-tsc"
elif command -v pnpm &> /dev/null; then
  VUE_TSC="pnpm exec vue-tsc"
elif command -v npx &> /dev/null; then
  VUE_TSC="npx vue-tsc"
fi

if [ -z "$VUE_TSC" ]; then
  echo "⚠️  vue-tsc not found, skipping type check"
else
  $VUE_TSC --noEmit 2>&1
  if [ $? -ne 0 ]; then
    echo "❌ TypeScript type check failed, please fix the errors above"
    ERRORS=$((ERRORS + 1))
  else
    echo "✅ TypeScript type check passed"
  fi
fi

# ── 2. Check Required Files ─────────────────────────
echo ""
echo "📌 Step 2: Check if all required files are generated"

FILES=(
  "$API_PATH/types.ts"
  "$API_PATH/index.ts"
  "$VIEW_PATH/index.vue"
  "$VIEW_PATH/modules/form.vue"
  "$VIEW_PATH/data.ts"
)

for FILE in "${FILES[@]}"; do
  if [ ! -f "$FILE" ]; then
    echo "❌ Missing file: $FILE"
    ERRORS=$((ERRORS + 1))
  else
    echo "✅ $FILE"
  fi
done

# ── 3. Check Relative Paths ─────────────────────────────────
echo ""
echo "📌 Step 3: Check for relative paths (should use #/ alias)"
RELATIVE=$(grep -rn "\.\.\/" "$VIEW_PATH" "$API_PATH" --include="*.ts" --include="*.vue" 2>/dev/null)
if [ -n "$RELATIVE" ]; then
  echo "❌ Found relative paths, please replace with #/ alias:"
  echo "$RELATIVE"
  ERRORS=$((ERRORS + 1))
else
  echo "✅ No relative paths"
fi

# ── 4. Check 'any' Type Abuse ────────────────────────────
echo ""
echo "📌 Step 4: Check for 'any' type abuse"
ANY_USAGE=$(grep -rn ": any" "$API_PATH" "$VIEW_PATH" --include="*.ts" --include="*.vue" 2>/dev/null)
if [ -n "$ANY_USAGE" ]; then
  echo "⚠️  Found 'any' type, recommend replacing with specific types:"
  echo "$ANY_USAGE"
else
  echo "✅ No 'any' type abuse"
fi

# ── 5. Summary ─────────────────────────────────────
echo ""
echo "════════════════════════════════"
if [ $ERRORS -gt 0 ]; then
  echo "❌ Checks failed, found $ERRORS error(s), please fix and re-run the script"
  exit 1
fi
echo "🎉 All checks passed, ready to output final summary"
