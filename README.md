# 🌌 Joel Maykon's Dotfiles (Arch Linux · Hyprland · Omarchy)

> Ambiente de desenvolvimento de alta produtividade, estética **Glassmorphism**, telemetria avançada de hardware/segurança e ecossistema de **Inteligência Artificial & TUIs**, gerenciado com **GNU Stow**.

---

## 🧭 Síntese Geral do Sistema & Guias Técnicos

Toda a documentação do sistema está modularizada na pasta [`docs/`](./docs/):

```text
docs/
├── 01-architecture-and-installation.md      # GNU Stow, segurança de segredos e install.sh
├── 02-shell-and-cli-stack.md                # Starship, Zsh, Eza, Zoxide, FZF, Mise e Aliases
├── 03-waybar-cockpit-and-ui.md              # Cockpit Waybar com telemetrias para Dev, AI e SecOps
├── 04-theming-glassmorphism-and-wallpapers.md# Temas Omarchy, Glassmorphism e Wallpaper Animado
└── 05-ai-stack-and-ai-memory.md             # AI-Usagebar e AI-Memory (Akita on Rails)
```

---

## 📋 Tabela de Recursos & Documentações

| Pilar / Módulo | O que foi configurado | Guia Completo |
| :--- | :--- | :---: |
| 🏛️ **Arquitetura & Bootstrap** | Estrutura modular GNU Stow (`shared/`, `arch-omarchy/`, `fivves-ui/`), script `install.sh` 100% automatizado, listas de pacotes nativos/AUR e isolamento de segredos (`~/.zshrc.local`). | [Ler Doc 01](./docs/01-architecture-and-installation.md) |
| ⚡ **Shell & CLI Moderno** | Prompt Starship com contexto dinâmico de Git/Python/Node, Zsh com syntax highlighting e autosuggestions, `zoxide` (`z`), `eza` (tree/icons), `bat`, `fzf` previews (`ff`, `eff`) e `mise`. | [Ler Doc 02](./docs/02-shell-and-cli-stack.md) |
| 📊 **Waybar Cockpit** | Barra flutuante (*floating chips*) com telemetria em tempo real: GPU NVIDIA (VRAM/Temp), CPU, RAM/Swap, Disco SSD, Docker, AI Tokens, I/O de Rede Wi-Fi e atalhos rápidos para TUIs (`btop`, `lazydocker`, `wiremix`, `impala`). | [Ler Doc 03](./docs/03-waybar-cockpit-and-ui.md) |
| 🎨 **Estética & Theming** | Motor Omarchy com **19 temas dinâmicos**, Hyprland com **Glassmorphism** (Dual Kawase blur, sombras 3D, bordas neon), launcher Walker com histórico de clipboard (`$`), cursor Bibata Modern Classic e **Wallpaper Animado 1080p 60fps** com Auto-Pause. | [Ler Doc 04](./docs/04-theming-glassmorphism-and-wallpapers.md) |
| 🤖 **IA & Long-Term Memory** | Monitor de cotas/tokens `ai-usagebar` na barra e **`ai-memory`** (Akita on Rails) rodando como serviço systemd local (`http://127.0.0.1:49374`) com MCP integrado ao Antigravity CLI e painel web (`mem-web`). | [Ler Doc 05](./docs/05-ai-stack-and-ai-memory.md) |

---

## 🚀 Instalação Rápida em uma Máquina Nova

Para restaurar 100% de todo o seu ambiente em qualquer computador com Arch Linux:

```bash
# 1. Clonar este repositório
git clone https://github.com/joelmaykon94/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles

# 2. Executar o instalador
chmod +x install.sh
./install.sh
```

---

## ⌨️ Principais Atalhos do Sistema

### 🖥️ Janelas & Sistema (Hyprland):
- `Super + Q` $\rightarrow$ Abre o terminal **Ghostty**.
- `Super + Espaço` $\rightarrow$ Abre o launcher **Walker** (digite `$` para clipboard, `:` para emojis, `=` para calculadora).
- `Super + Alt + Espaço` $\rightarrow$ Menu de temas do Omarchy (troca de wallpaper, Neovim e Waybar em tempo real).
- `Super + C` $\rightarrow$ Fecha a janela ativa.
- `Super + V` $\rightarrow$ Alterna janela para flutuante (floating).
- `Super + F` $\rightarrow$ Tela cheia (fullscreen).

### 🧰 Terminal & TUIs Rápidas:
- `lg` $\rightarrow$ **`lazygit`** (Git TUI completo com Delta).
- `ld` $\rightarrow$ **`lazydocker`** (Docker TUI).
- `top` $\rightarrow$ **`btop`** (Monitor de hardware e processos).
- `y` $\rightarrow$ **`yazi`** (Gerenciador de arquivos em terminal).
- `ff` $\rightarrow$ Busca interativa de arquivos com preview em cores (`fzf` + `bat`).
- `mem` / `mem-web` $\rightarrow$ CLI e Painel Web do **`ai-memory`**.

---

## 📜 Licença

Distribuído sob a licença **MIT**. Sinta-se livre para usar, clonar e customizar!
