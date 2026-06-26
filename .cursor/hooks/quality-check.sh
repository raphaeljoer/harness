#!/bin/bash
# afterFileEdit hook: formata e corrige lint do arquivo TS editado.
# Fail-open: nunca bloqueia o agente; apenas roda ferramentas se existirem.
set -u

input=$(cat)

# Extrai o caminho do arquivo do JSON de stdin sem depender de jq (usa node).
file=$(printf '%s' "$input" | node -e '
  let d = "";
  process.stdin.on("data", c => d += c);
  process.stdin.on("end", () => {
    try {
      const j = JSON.parse(d || "{}");
      process.stdout.write(j.file_path || j.path || j.filePath || "");
    } catch (_) { process.stdout.write(""); }
  });
' 2>/dev/null)

# Só atua em arquivos TypeScript.
case "$file" in
  *.ts|*.tsx) ;;
  *) echo '{}'; exit 0 ;;
esac

[ -f "$file" ] || { echo '{}'; exit 0; }
[ -f package.json ] || { echo '{}'; exit 0; }

# Formata o arquivo editado se prettier estiver disponível.
if [ -x node_modules/.bin/prettier ]; then
  node_modules/.bin/prettier --write "$file" >/dev/null 2>&1
fi

# Corrige problemas de lint auto-fixáveis no arquivo editado.
if [ -x node_modules/.bin/eslint ]; then
  node_modules/.bin/eslint --fix "$file" >/dev/null 2>&1
fi

echo '{}'
exit 0
