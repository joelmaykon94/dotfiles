# 🏛️ Arquitetura & Instalação Automatizada

Este documento detalha como os dotfiles estão organizados com **GNU Stow**, a política de segurança para segredos e chaves SSH, e o script de bootstrap para reinstalação completa em novos computadores.

---

## 📂 Estrutura Modular com GNU Stow

O repositório está dividido em pacotes modulares limpos. Cada pasta reflete a estrutura exata do `$HOME`:

```text
~/Projects/dotfiles/
├── shared/                       # Configurações multiplataforma (Linux, macOS, WSL)
│   ├── .bashrc
│   ├── .zshrc
│   ├── .gitconfig
│   └── .config/
│       ├── starship.toml         # Prompt moderno
│       ├── mise/                 # Gerenciador de linguagens e ferramentas
│       ├── lazygit/              # TUI para Git
│       ├── lazydocker/           # TUI para Docker
│       ├── btop/                 # TUI de monitoramento de sistema
│       ├── ghostty/              # Terminal moderno integrado ao tema
│       ├── ai-usagebar/          # Monitor de tokens e cotas de LLM
│       └── nvim/                 # Configuração Neovim
│
├── arch-omarchy/                 # Configurações específicas do Arch Linux & Hyprland
│   └── .config/
│       ├── hypr/                 # Look'n'feel, autostart, envs e regras de janela
│       ├── walker/               # Launcher de aplicativos e histórico de clipboard
│       └── swayosd/              # OSD visual para volume e brilho da tela
│
├── fivves-ui/                    # Customizações visuais da barra Waybar
│   └── .config/
│       └── waybar/
│           ├── config.jsonc      # Definição dos módulos de telemetria
│           └── style.css         # Estilização com cantos arredondados e pílulas
│
├── docs/                         # Documentação técnica detalhada
├── scripts/                      # Scripts auxiliares e listas de pacotes
└── install.sh                    # Script de bootstrap 100% automatizado
```

---

## 🔒 Segurança & Isolamento de Segredos

O repositório possui uma política estrita no `.gitignore` para garantir que nenhum segredo, chave ou token pessoal seja versionado publicamente:

1. **Variáveis de Ambiente e Segredos Locais**:
   - O arquivo `~/.zshrc.local` é carregado automaticamente pelo `.zshrc` se existir, mas está bloqueado no `.gitignore`. Nele ficam suas chaves de API (`OPENAI_API_KEY`, `ANTHROPIC_API_KEY`, tokens privados).
2. **Chaves SSH & GPG**:
   - Bloqueadas por padrão no `.gitignore`.
3. **Agente SSH Automático**:
   - O socket do `ssh-agent` é gerenciado via Systemd do usuário (`ssh-agent.socket`), garantindo que suas chaves fiquem protegidas em memória sem necessidade de comandos manuais.

---

## 🚀 Instalação Rápida em um Sistema Limpo

Para restaurar todo o ambiente em uma instalação nova do Arch Linux:

```bash
# 1. Clonar o repositório
git clone https://github.com/joelmaykon94/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles

# 2. Executar o instalador automatizado
chmod +x install.sh
./install.sh
```

### O que o `install.sh` faz automaticamente:
1. Detecta o gerenciador de pacotes (`pacman` e `yay`).
2. Instala todos os pacotes nativos listados em [`scripts/pkglist-native.txt`](../scripts/pkglist-native.txt).
3. Instala todos os pacotes do AUR listados em [`scripts/pkglist-aur.txt`](../scripts/pkglist-aur.txt).
4. Cria os links simbólicos de todos os módulos (`shared`, `arch-omarchy`, `fivves-ui`) usando GNU Stow.
5. Habilita os serviços de sistema necessários (`ssh-agent.socket`, `ai-memory.service`).

---

## 🔄 Sincronização de Pacotes

Sempre que instalar novos pacotes e quiser salvar o estado atual nos dotfiles:

```bash
~/Projects/dotfiles/scripts/sync-pkglist.sh
```
O script atualiza automaticamente `scripts/pkglist-native.txt` e `scripts/pkglist-aur.txt`.
