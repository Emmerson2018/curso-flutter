from pathlib import Path

FILE = Path('lib/core/services/ia_service.dart')

if not FILE.exists():
    raise SystemExit(f'Arquivo não encontrado: {FILE}. Execute este script na raiz do projeto Flutter.')

text = FILE.read_text(encoding='utf-8')
original = text

# 1) TimeoutException pertence a dart:async.
if "import 'dart:async';" not in text and 'import "dart:async";' not in text:
    # Insere antes dos imports dart:* existentes, quando possível.
    marker = "import 'dart:"
    idx = text.find(marker)
    if idx >= 0:
        text = text[:idx] + "import 'dart:async';\n" + text[idx:]
    else:
        text = "import 'dart:async';\n" + text

# 2) Remove import não utilizado indicado pelo analyzer.
text = text.replace("import 'dart:convert';\n", '')
text = text.replace('import "dart:convert";\n', '')

# 3) Se houver chamadas diretas http.get/post/put/delete e existir _client, usa o client injetado.
# Isso elimina o aviso de campo _client não usado sem mudar a arquitetura do serviço.
if '_client' in text:
    for method in ['get', 'post', 'put', 'patch', 'delete']:
        text = text.replace(f'http.{method}(', f'_client.{method}(')

# 4) Garante ordem segura dos catchs: TimeoutException antes de SocketException.
# A ordem é importante porque timeouts devem ser tratados de forma específica.
def find_catch_block(src: str, type_name: str):
    start = src.find(f'on {type_name}')
    if start < 0:
        return None
    brace = src.find('{', start)
    if brace < 0:
        return None
    depth = 0
    i = brace
    in_string = None
    escape = False
    while i < len(src):
        ch = src[i]
        if in_string:
            if escape:
                escape = False
            elif ch == '\\':
                escape = True
            elif ch == in_string:
                in_string = None
        else:
            if ch in ('"', "'"):
                in_string = ch
            elif ch == '{':
                depth += 1
            elif ch == '}':
                depth -= 1
                if depth == 0:
                    return (start, i + 1)
        i += 1
    return None

socket_block = find_catch_block(text, 'SocketException')
timeout_block = find_catch_block(text, 'TimeoutException')

if socket_block and timeout_block and socket_block[0] < timeout_block[0]:
    s0, s1 = socket_block
    t0, t1 = timeout_block
    socket_text = text[s0:s1]
    between = text[s1:t0]
    timeout_text = text[t0:t1]
    text = text[:s0] + timeout_text + between + socket_text + text[t1:]

if text != original:
    backup = FILE.with_suffix(FILE.suffix + '.bak')
    backup.write_text(original, encoding='utf-8')
    FILE.write_text(text, encoding='utf-8')
    print('Correções aplicadas com sucesso.')
    print(f'Backup criado em: {backup}')
else:
    print('Nenhuma alteração necessária.')
