# 📊 Barra Waybar: Cockpit de Telemetria (Dev, AI & SecOps)

Este documento detalha a arquitetura visual, os módulos de telemetria e o comportamento interativo da barra **Waybar**.

---

## 🎨 Design System: Pílulas Flutuantes (Floating Chips)

A barra utiliza o conceito de **Pílulas Flutuantes Isoladas** com fundo translúcido (`surface_bg alpha(@background, 0.85)`), cantos arredondados (`10px - 12px`) e bordas suaves, importando dinamicamente as cores do tema ativo do Omarchy.

Configurações principais:
* **Definição de Módulos**: [`fivves-ui/.config/waybar/config.jsonc`](../fivves-ui/.config/waybar/config.jsonc)
* **Estilização CSS**: [`fivves-ui/.config/waybar/style.css`](../fivves-ui/.config/waybar/style.css)

---

## 📡 Módulos de Telemetria Visíveis na Barra

A barra foi estruturada para desenvolvedores de software, cientistas de IA e profissionais de segurança:

```text
[ 󰖟    󰎞     ]   [  Alacritty - zsh ]   [ 󰧑 4%·2% ] [ 󰢮 0%·0.0G ] [ 󰍛 12% ] [  48°C ] [ 󰘚 27% ] [ 󰋊 11% ] [  0 ] [ 󰤨 ] [ 󰕾 60% ] [ 󰁹 90% ] [ 󰃰 23/08 13:30 ]
```

| Módulo | Exibição na Barra | Ação ao Clicar (`on-click`) | Telemetria no Tooltip (Hover) |
| :--- | :---: | :--- | :--- |
| **󰧑 AI Tokens** | `󰧑 4% · 2%` | Scroll alterna provedor | Cotas da sessão e semanal das APIs de IA (Gemini, Claude, GPT, Antigravity). |
| **󰢮 GPU NVIDIA** | `󰢮 0% · 0.0G` | Abre o **`btop`** | Utilização da GPU e quantidade de **VRAM ocupada (GB)**. |
| **󰍛 CPU** | `󰍛 12%` | Abre o **`btop`** | Porcentagem de uso da CPU em tempo real. |
| ** Temperatura** | ` 48°C` | — | Monitor térmico dos núcleos com alerta em vermelho (`critical = 80°C`). |
| **󰘚 Memória RAM** | `󰘚 27%` | Abre o **`btop`** | Memória física usada/total e paginação em Swap (`RAM: 6.2GiB / 23.2GiB`). |
| **󰋊 Armazenamento** | `󰋊 11%` | Abre o **`btop`** | Espaço total ocupado e gigabytes livres no SSD (`Livre: 423GiB`). |
| ** Docker** | ` 0` | Abre o **`lazydocker`** | Quantidade de containers Docker rodando no momento. |
| **󰤨 Rede & Wi-Fi** | `󰤨` | Abre o menu Wi-Fi (`impala`) | Taxa de Download e Upload instantânea, SSID, Sinal (%) e endereço IP. |
| **󰕾 Áudio** | `󰕾 60%` | Abre o mixer **`wiremix`** | Volume sonoro com atalho de mute no botão direito (`pamixer -t`). |
| **󰁹 Bateria** | `󰁹 90%` | Menu de energia (`omarchy-menu power`) | Taxa de carga/descarga em Watts (`14W↓`) e tempo restante de autonomia. |
| **󰃰 Relógio** | `󰃰 23/08 13:30` | Abre calendário web | Data e horário sincronizados. |
| **Bandeja (Tray)** | Ícones de apps | — | Notificações e aplicativos em segundo plano. |

---

## 🖱️ Interatividade & TUIs Integradas

Clicar nos chips da barra abre instantaneamente a interface de terminal correspondente:
* **CPU / GPU / RAM / Disco** $\rightarrow$ Abre o **`btop`**.
* **Docker** $\rightarrow$ Abre o **`lazydocker`**.
* **Som** $\rightarrow$ Abre o **`wiremix`**.
* **Wi-Fi** $\rightarrow$ Abre o gerenciador de conexões sem fio **`impala`**.
