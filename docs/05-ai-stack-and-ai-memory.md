# 🤖 Stack de Inteligência Artificial & AI-Memory

Este documento descreve as ferramentas de IA integradas ao sistema: o monitor de cotas **`ai-usagebar`** e o sistema de memória de longo prazo **`ai-memory`** (criado pelo Akita on Rails).

---

## 📊 1. AI-Usagebar (Monitor de Tokens na Waybar)

O **`ai-usagebar`** rastreia o consumo de tokens e cotas das suas APIs de IA em tempo real:

* **Configuração**: [`shared/.config/ai-usagebar/config.toml`](../shared/.config/ai-usagebar/config.toml).
* **Provedores Suportados**: Google AI Pro (Gemini), Anthropic (Claude), OpenAI (GPT-4o), DeepSeek, OpenRouter, Grok.
* **Comportamento na Barra**:
  - Exibe o uso percentual da sessão e da cota semanal (ex.: `󰧑 4% · 2%`).
  - **Scroll na Barra**: Rolar a roda do mouse sobre o widget alterna o provedor ativo (`ai-usagebar --cycle-next`).
  - **Tooltip Rico**: Passar o cursor exibe barras visuais de progresso e tempo restante para o reset das cotas.

---

## 🧠 2. AI-Memory (Memória de Longo Prazo para Agentes)

O **`ai-memory`** ([GitHub](https://github.com/akitaonrails/ai-memory)) é um motor de alta performance em Rust que resolve o problema de amnésia entre sessões de IA.

### Como Funciona:
1. **Wiki em Markdown**: Compila as descobertas, decisões e regras da sua base de código em uma wiki local versionada sob Git em `~/.local/share/ai-memory/wiki/`.
2. **Busca Híbrida em Milissegundos**: Índices SQLite com FTS5, relações em grafo de entidades e embeddings vetoriais.
3. **Handoff entre Agentes**: Transfere o contexto de um projeto do Antigravity CLI para Claude Code, OpenCode, Codex ou Cursor sem perda de informação.

---

## ⚙️ Arquitetura do Serviço no Sistema

O `ai-memory` roda localmente como um serviço de usuário do Systemd:

* **Serviço**: `~/.config/systemd/user/ai-memory.service`
* **Porta Local**: `http://127.0.0.1:49374`
* **Interface Web (UI)**: `http://127.0.0.1:49374/web`
* **Integração MCP**: Registrado no Antigravity CLI via `~/.gemini/antigravity-cli/mcp_config.json`.

---

## 🚀 Comandos Rápidos do `ai-memory` (CLI):

```bash
# Verificar status do servidor e quantidade de páginas na memória:
mem status

# Abrir o painel web visual no navegador:
mem-web

# Buscar decisões ou arquiteturas na memória de projetos:
mem search "configuração de banco"
mem search "regras do hyprland"

# Iniciar o Antigravity com continuidade gerenciada:
mem run agy

# Gravar uma página de documentação manual na wiki:
mem write-page --title "Arquitetura" --body "Decisão: Usamos FastFetch e Waybar com floating chips"

# Instalar MCP em outros agentes:
mem install-mcp --client claude-code --apply
mem install-mcp --client cursor --apply
mem install-mcp --client open-code --apply
```
