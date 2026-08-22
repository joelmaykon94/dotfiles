# 🚀 Dotfiles - Arch Linux (Omarchy) + Hyprland

Repositório pessoal de configurações automatizadas, modulares e seguras gerenciadas com **GNU Stow**.

---

## 📂 Estrutura Modular

```text
dotfiles/
├── arch-omarchy/          # Configurações do Hyprland, hypridle, hyprlock
│   └── .config/hypr/
├── fivves-ui/             # Waybar customizado com estilo Floating Chips
│   └── .config/waybar/
├── shared/                # Shell, Git e Neovim compartilhados
│   ├── .config/nvim/
│   ├── .bashrc
│   ├── .zshrc
│   └── .gitconfig
├── scripts/               # Scripts de manutenção e listas de pacotes
│   ├── pkglist-native.txt # Pacotes oficiais do Arch Linux
│   ├── pkglist-aur.txt    # Pacotes do AUR
│   └── sync-pkglist.sh    # Script para atualizar manifestos de pacotes
├── .gitignore             # Bloqueio de segredos e arquivos temporários
├── install.sh             # Script de bootstrap automatizado para novo sistema
└── README.md
```

---

## ⚡ Como Restaurar em uma Nova Instalação

Em uma instalação limpa do Arch Linux ou Omarchy, basta clonar o repositório e executar:

```bash
git clone https://github.com/SEU_USUARIO/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles
chmod +x install.sh
./install.sh
```

O `install.sh` irá automaticamente:
1. Instalar os pacotes oficiais essenciais (`stow`, `git`, `base-devel`).
2. Instalar todos os pacotes nativos listados em `scripts/pkglist-native.txt`.
3. Instalar o `yay` e todos os pacotes AUR de `scripts/pkglist-aur.txt`.
4. Criar os symlinks das configurações usando `stow`.
5. Habilitar o firewall UFW com regras de segurança padrão.
6. Gerar o arquivo de segredos locais `~/.zshrc.local`.

---

## 🛠️ Gerenciamento no Dia a Dia

### Aplicar/Reaplicar Symlinks com Stow
```bash
cd ~/Projects/dotfiles
stow -R -t ~ shared
stow -R -t ~ arch-omarchy
stow -R -t ~ fivves-ui
```

### Sincronizar Pacotes Instalados
Sempre que instalar novos pacotes e quiser salvá-los no Git:
```bash
./scripts/sync-pkglist.sh
git add scripts/pkglist-*.txt
git commit -m "chore(pkg): update package list"
git push
```

---

## 🔒 Segurança e Gestão de Segredos

- **Nunca commite senhas ou tokens:** Use `~/.zshrc.local` ou `~/.bashrc.local` para exportar chaves de API e variáveis privadas. Estes arquivos são ignorados pelo `.gitignore`.
- **Chaves SSH:** Utilize o **1Password SSH Agent** ou chaves com senha/FIDO2.
