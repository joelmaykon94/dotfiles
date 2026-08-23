# ⚡ Shell Moderno & Stack de Ferramentas CLI

Este documento descreve a configuração do terminal, prompt, plugins e ferramentas modernas de linha de comando utilizadas no sistema.

---

## 🎨 Starship Prompt

O prompt é alimentado pelo [Starship](https://starship.rs), configurado em [`shared/.config/starship.toml`](../shared/.config/starship.toml):

* **Contexto Dinâmico**: Exibe automaticamente o ambiente virtual Python (`venv`, `conda`, `poetry`), status do Git (branch, commits a frente/atrás, modificações), versão do Node.js, Rust e Go.
* **Medição de Tempo**: Exibe a duração de execução de comandos pesados (ex.: compilações, testes, treinamentos).
* **Aparência**: Estilo Nerd Font com cores suaves e ícones informativos.

---

## 🛠️ Ferramentas Modernas de Linha de Comando

Substitutos modernos para ferramentas clássicas Unix:

| Ferramenta Clássica | Ferramenta Moderna | Função / Vantagem |
| :--- | :--- | :--- |
| `cd` | **`zoxide` (`z`)** | Navegação inteligente aprendendo seus diretórios mais acessados. |
| `ls` | **`eza`** | Listagem colorida com ícones, permissões detalhadas e visualização em árvore (`tree`). |
| `cat` | **`bat`** | Visualizador de arquivos com syntax highlighting e numeração de linhas. |
| `find` / `grep` | **`fzf`** | Busca fuzzy interativa com preview instantâneo de arquivos. |
| `nvm` / `rbenv` | **`mise`** | Gerenciador poliglota ultrarrápido em Rust para Node, Python, Rust, Go, etc. |

---

## 🚀 Tabela de Atalhos & Aliases (Cheat Sheet)

Configurados em [`shared/.zshrc`](../shared/.zshrc) e [`shared/.bashrc`](../shared/.bashrc):

### 🧰 TUIs de Produtividade:
* `lg` $\rightarrow$ **`lazygit`** (Interface visual para Git com Delta pager).
* `ld` $\rightarrow$ **`lazydocker`** (Interface visual para containers, imagens e volumes Docker).
* `top` $\rightarrow$ **`btop`** (Monitor de recursos em TUI com suporte a tema).
* `y` $\rightarrow$ **`yazi`** (Gerenciador de arquivos ultrarrápido em terminal).
* `n` $\rightarrow$ **`nvim`** (Editor Neovim).

### 🔍 Busca Fuzzy & Preview (FZF):
* `ff` $\rightarrow$ Busca interativa de arquivos com preview em sintaxe colorida (`bat`).
* `eff` $\rightarrow$ Busca e abre o arquivo selecionado diretamente no Neovim.

### 🧠 Memória & IA:
* `mem` $\rightarrow$ CLI do **`ai-memory`** (memória de longo prazo para agentes).
* `mem-web` $\rightarrow$ Abre o painel visual do `ai-memory` no navegador (`http://127.0.0.1:49374/web`).

### 📦 Git Rápido:
* `g` $\rightarrow$ `git`
* `gs` $\rightarrow$ `git status`
* `gp` $\rightarrow$ `git push`
* `gl` $\rightarrow$ `git pull`
* `gd` $\rightarrow$ `git diff`
* `gcm "msg"` $\rightarrow$ `git commit -m "msg"`
* `gcam "msg"` $\rightarrow$ `git commit -a -m "msg"`

---

## 🔌 Plugins do ZSH
* **`zsh-autosuggestions`**: Sugestões automáticas baseadas no histórico enquanto você digita (pressione `Ctrl + Espaço` ou `Seta Direita` para aceitar).
* **`zsh-syntax-highlighting`**: Destaque de sintaxe em tempo real no terminal (verde para comandos válidos, vermelho para inválidos).
