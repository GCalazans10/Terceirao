# 🚀 Guia Completo: Falaí - Aplicação de Chat em Tempo Real

## Índice
1. [Visão Geral](#visão-geral)
2. [Arquitetura da Aplicação](#arquitetura-da-aplicação)
3. [Tecnologias Utilizadas](#tecnologias-utilizadas)
4. [Passo 1: Configuração Inicial](#passo-1-configuração-inicial)
5. [Passo 2: Estrutura de Pastas](#passo-2-estrutura-de-pastas)
6. [Passo 3: Dependências e Instalação](#passo-3-dependências-e-instalação)
7. [Passo 4: Configurar Supabase](#passo-4-configurar-supabase)
8. [Passo 5: Variáveis de Ambiente](#passo-5-variáveis-de-ambiente)
9. [Passo 6: Setup do Projeto](#passo-6-setup-do-projeto)
10. [Passo 7: Componentes Principais](#passo-7-componentes-principais)
11. [Passo 8: Services (Serviços)](#passo-8-services-serviços)
12. [Passo 9: Contextos e Hooks](#passo-9-contextos-e-hooks)
13. [Passo 10: Integrações com Supabase](#passo-10-integrações-com-supabase)

---

## Visão Geral

**Falaí** é um aplicativo de chat em tempo real desenvolvido com React e Supabase que permite aos usuários:

- ✅ Fazer login e cadastro
- ✅ Enviar mensagens de texto
- ✅ Compartilhar áudio, imagens e vídeos
- ✅ Ver status online/offline dos usuários
- ✅ Gerenciar conversas e mensagens
- ✅ Bloquear/desbloquear usuários
- ✅ Editar e deletar mensagens

### Por Que Essas Tecnologias?

- **React**: Framework JavaScript moderno para construir interfaces dinâmicas
- **TypeScript**: Adiciona tipagem estática ao JavaScript (evita erros)
- **Supabase**: Backend como serviço (autenticação + banco de dados + storage)
- **TailwindCSS**: Framework CSS para estilização rápida
- **Vite**: Bundler de desenvolvimento rápido (muito mais rápido que webpack)

---

## Arquitetura da Aplicação

```
┌─────────────────────────────────────┐
│     Frontend (React + TypeScript)   │
├─────────────────────────────────────┤
│  - Components (UI)                  │
│  - Pages (Rotas)                    │
│  - Contexts (Estado Global)         │
│  - Hooks (Lógica Reutilizável)      │
│  - Services (Chamadas API)          │
└────────────┬────────────────────────┘
             │ HTTP/WebSocket
             ▼
┌─────────────────────────────────────┐
│     Backend (Supabase)              │
├─────────────────────────────────────┤
│  - Autenticação (Auth)              │
│  - Banco de Dados (PostgreSQL)      │
│  - Storage (Arquivos)               │
│  - Realtime (WebSocket)             │
└─────────────────────────────────────┘
```

### Fluxo de Dados

```
1. Usuário interage com Componente
    ↓
2. Componente chama Hook (useAuth, useState, etc)
    ↓
3. Hook chama Service (authService, mensagensService)
    ↓
4. Service chama Supabase Client
    ↓
5. Supabase executa no Backend
    ↓
6. Resposta retorna ao Componente
    ↓
7. Componente re-renderiza com novos dados
```

---

## Tecnologias Utilizadas

### Frontend
- **React 18.3.1** - Biblioteca para UI
- **TypeScript 5.6.2** - Tipagem de JavaScript
- **React Router 7.1.3** - Navegação entre páginas
- **TailwindCSS 3.4.0** - Estilização CSS
- **Vite 6.0.5** - Build tool

### Dependências de Funcionalidades
- **@supabase/supabase-js** - Cliente Supabase
- **recordrtc** - Gravação de áudio
- **wavesurfer.js** - Player de áudio
- **sweetalert2** - Modais bonitas
- **@emoji-mart/react** - Seletor de emoji

### DevDependencies
- **ESLint** - Linter de código
- **PostCSS + Autoprefixer** - Processamento de CSS

---

## Passo 1: Configuração Inicial

### 1.1 Criar um novo projeto React com Vite

```bash
# Abrir PowerShell e executar:
npm create vite@latest falai -- --template react

# Entrar na pasta do projeto
cd falai

# Instalar dependências
npm install
```

### 1.2 Inicializar Git (Versionamento)

```bash
git init
git add .
git commit -m "Projeto inicial criado com Vite"
```

### Explicação:

- **Vite** cria um projeto React moderno em segundos
- **npm install** baixa todas as dependências do `package.json`
- **Git** permite rastrear mudanças no código

---

## Passo 2: Estrutura de Pastas

Criar a seguinte estrutura dentro de `src/`:

```
src/
├── assets/                    # Imagens, ícones
├── components/                # Componentes React reutilizáveis
│   ├── AudioPlayer.tsx       # Player de áudio
│   ├── Avatar.tsx            # Avatar do usuário
│   ├── ChatContent.tsx       # Conteúdo da conversa
│   ├── ChatInput.tsx         # Input para escrever mensagens
│   ├── ConversaItem.tsx      # Item de uma conversa
│   ├── ErrorBoundary.tsx     # Tratamento de erros
│   ├── ImagemPreview.tsx     # Preview de imagens
│   ├── InfoUsuario.tsx       # Info do usuário
│   ├── ListaConversas.tsx    # Lista de conversas
│   ├── MensagemBalao.tsx     # Balão de mensagem
│   ├── ModalBuscaUsuarios.tsx# Modal para buscar usuários
│   ├── Portal.tsx            # Portal React
│   ├── RotaProtegida.tsx     # Proteção de rotas
│   └── Toast.tsx             # Notificações
├── contexts/                  # Contextos (estado global)
│   └── AuthContext.tsx       # Contexto de autenticação
├── hooks/                     # Hooks customizados
│   └── useAuth.ts            # Hook para autenticação
├── lib/                       # Bibliotecas e utilitários
│   └── supabase.ts           # Configuração Supabase
├── pages/                     # Páginas da aplicação
│   └── Chat.tsx              # Página principal de chat
├── services/                  # Serviços (chamadas API)
│   ├── auth.ts               # Autenticação
│   ├── bloqueios.ts          # Gerenciamento de bloqueios
│   ├── conversas.ts          # Conversas
│   ├── eventos.ts            # Eventos
│   ├── mensagens.ts          # Mensagens
│   └── status.ts             # Status de usuários
├── utils/                     # Funções utilitárias
│   └── documentos.tsx        # Utilitários de documentos
├── App.tsx                    # Componente raiz
├── App.css                    # Estilos globais
├── main.tsx                   # Entrada da aplicação
├── index.css                  # Estilos globais
└── vite-env.d.ts             # Tipos Vite
```

### Criar as Pastas:

```bash
mkdir src/components
mkdir src/contexts
mkdir src/hooks
mkdir src/lib
mkdir src/pages
mkdir src/services
mkdir src/utils
```

---

## Passo 3: Dependências e Instalação

### 3.1 Instalar Supabase

```bash
npm install @supabase/supabase-js
```

### 3.2 Instalar React Router (Navegação)

```bash
npm install react-router-dom
```

### 3.3 Instalar Dependências de Funcionalidades

```bash
# Para áudio
npm install recordrtc wavesurfer.js

# Para TypeScript (types)
npm install --save-dev @types/recordrtc @types/wavesurfer.js

# Para modais e notificações
npm install sweetalert2

# Para emoji
npm install @emoji-mart/data @emoji-mart/react
```

### 3.4 TailwindCSS (Estilização)

```bash
npm install -D tailwindcss postcss autoprefixer

# Inicializar Tailwind
npx tailwindcss init -p
```

### 3.5 ESLint (Verificação de Código)

```bash
npm install --save-dev eslint @eslint/js typescript-eslint eslint-plugin-react-hooks eslint-plugin-react-refresh globals
```

### Explicação:

- **@supabase/supabase-js**: Biblioteca para comunicar com Supabase
- **react-router-dom**: Permite navegação entre páginas (tipo SPA)
- **recordrtc + wavesurfer.js**: Gravação e reprodução de áudio
- **sweetalert2**: Modais customizáveis (mais bonitos que alert)
- **tailwindcss**: Estilização utilitária (classes CSS prontas)
- **eslint**: Encontra erros e problemas no código

---

## Passo 4: Configurar Supabase

### 4.1 Criar uma Conta no Supabase

1. Ir para [https://supabase.com](https://supabase.com)
2. Clicar em "Sign Up"
3. Criar uma conta com GitHub ou email
4. Criar um novo projeto

### 4.2 Criar as Tabelas Necessárias

#### Tabela: `usuarios`

```sql
CREATE TABLE usuarios (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT NOT NULL UNIQUE,
  nome TEXT NOT NULL,
  avatar_url TEXT,
  status TEXT DEFAULT 'offline' CHECK (status IN ('online', 'offline')),
  ultimo_acesso TIMESTAMP,
  username TEXT UNIQUE,
  bio TEXT,
  telefone TEXT,
  configuracoes JSONB DEFAULT '{"notificacoes": true, "tema": "light", "idioma": "pt-BR"}',
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

**Explicação:**
- `id UUID PRIMARY KEY`: ID único do usuário (vem do Supabase Auth)
- `REFERENCES auth.users(id)`: Vincula com a tabela de autenticação
- `ON DELETE CASCADE`: Deleta o usuário quando auth.user é deletado
- `status TEXT DEFAULT 'offline'`: Como padrão é offline
- `CHECK`: Valida que o status é apenas 'online' ou 'offline'
- `JSONB`: Formato JSON no banco (mais flexível)

#### Tabela: `msg_chat`

```sql
CREATE TABLE msg_chat (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  remetente_id UUID NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
  destinatario_id UUID NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
  texto TEXT,
  tipo TEXT NOT NULL CHECK (tipo IN ('texto', 'imagem', 'audio', 'video', 'documento')),
  audio_url TEXT,
  imagem_url TEXT,
  video_url TEXT,
  documento_url TEXT,
  documento_nome TEXT,
  documento_tamanho INTEGER,
  lida_remetente BOOLEAN DEFAULT FALSE,
  lida_destinatario BOOLEAN DEFAULT FALSE,
  deletada BOOLEAN DEFAULT FALSE,
  editada BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

**Explicação:**
- Guarda as mensagens trocadas entre usuários
- `tipo`: Especifica o tipo de conteúdo
- `*_url`: URL do arquivo armazenado (imagem, áudio, vídeo, etc)
- `lida_remetente/destinatario`: Rastreia se a mensagem foi lida
- `editada/deletada`: Flags para saber se foi modificada

#### Tabela: `bloqueios`

```sql
CREATE TABLE bloqueios (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id UUID NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
  bloqueado_id UUID NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(usuario_id, bloqueado_id)
);
```

**Explicação:**
- Armazena os bloqueios entre usuários
- `UNIQUE`: Garante que não há bloqueio duplicado

#### Tabela: `status_usuarios`

```sql
CREATE TABLE status_usuarios (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  usuario_id UUID NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
  status TEXT NOT NULL,
  ativo_ate TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(usuario_id)
);
```

**Explicação:**
- Rastreia o status e quando expira
- Importante para "última vez visto"

### 4.3 Criar Storage Buckets

No dashboard do Supabase, em "Storage", criar:

1. **Bucket: `avatares`** (público)
   - Para armazenar avatares de usuários

2. **Bucket: `audios`** (público)
   - Para armazenar mensagens de áudio

3. **Bucket: `imagens`** (público)
   - Para armazenar imagens compartilhadas

4. **Bucket: `videos`** (público)
   - Para armazenar vídeos compartilhados

5. **Bucket: `documentos`** (público)
   - Para armazenar documentos

### 4.4 Copiar Credenciais

No dashboard, em "Project Settings" → "API":

- Copiar a **URL do Projeto**
- Copiar a **Anon Key (Public)**

Essas serão usadas no `.env`

---

## Passo 5: Variáveis de Ambiente

### 5.1 Criar arquivo `.env.local` na raiz do projeto

```env
VITE_SUPABASE_URL=https://seu-projeto.supabase.co
VITE_SUPABASE_ANON_KEY=sua-chave-anon-aqui
```

**Explicação:**
- `.env.local`: Arquivo que armazena variáveis sensíveis
- `VITE_` prefix: Vite injeta essas variáveis no bundle
- Nunca fazer commit deste arquivo (adicioner ao `.gitignore`)

### 5.2 Atualizar `.gitignore`

```
# Variáveis de ambiente
.env
.env.local
.env.*.local

# Dependências
node_modules/

# Build
dist/

# IDE
.vscode/
.idea/
```

---

## Passo 6: Setup do Projeto

### 6.1 Configurar Supabase Client

Criar arquivo `src/lib/supabase.ts`:

```typescript
import { createClient } from '@supabase/supabase-js';

// Pegar as variáveis de ambiente
const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

// Validar se as variáveis foram definidas
if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error('Supabase URL and Anon Key são necessários.');
}

// Criar cliente Supabase
export const supabase = createClient(supabaseUrl, supabaseAnonKey);

// Definir tipos para TypeScript
export type Usuario = {
  id: string;
  email: string;
  nome: string;
  avatar_url: string | null;
  status: 'online' | 'offline';
  ultimo_acesso: string | null;
  created_at: string;
  updated_at: string;
  username: string | null;
  bio: string | null;
  telefone: string | null;
  configuracoes: {
    notificacoes: boolean;
    tema: 'light' | 'dark';
    idioma: string;
  } | null;
}
```

**Explicação:**
- `createClient`: Cria conexão com banco de dados
- `import.meta.env`: Acessa variáveis de ambiente do Vite
- `export type Usuario`: Define a estrutura de um usuário (TypeScript)

### 6.2 Configurar TailwindCSS

Atualizar `tailwind.config.js`:

```javascript
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
```

### 6.3 Configurar Vite

Arquivo `vite.config.ts`:

```typescript
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  css: {
    postcss: './postcss.config.js'
  }
})
```

---

## Passo 7: Componentes Principais

### 7.1 ErrorBoundary (Tratamento de Erros)

Criar `src/components/ErrorBoundary.tsx`:

```typescript
import React, { ReactNode } from 'react';

interface Props {
  children: ReactNode;
}

interface State {
  hasError: boolean;
  error: Error | null;
}

class ErrorBoundary extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { hasError: false, error: null };
  }

  static getDerivedStateFromError(error: Error): State {
    return { hasError: true, error };
  }

  componentDidCatch(error: Error, errorInfo: React.ErrorInfo) {
    console.error('Erro capturado:', error, errorInfo);
  }

  render() {
    if (this.state.hasError) {
      return (
        <div className="min-h-screen flex items-center justify-center bg-red-50">
          <div className="bg-white p-8 rounded-lg shadow-lg">
            <h1 className="text-2xl font-bold text-red-600 mb-4">
              Oops! Algo deu errado
            </h1>
            <p className="text-gray-600 mb-4">
              {this.state.error?.message}
            </p>
            <button
              onClick={() => window.location.reload()}
              className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600"
            >
              Recarregar página
            </button>
          </div>
        </div>
      );
    }

    return this.props.children;
  }
}

export default ErrorBoundary;
```

**Explicação:**
- **ErrorBoundary**: Componente que captura erros dos filhos
- `getDerivedStateFromError`: Atualiza estado quando erro ocorre
- `componentDidCatch`: Executa quando erro é capturado
- Evita que a app quebre completamente

### 7.2 RotaProtegida (Proteção de Rotas)

Criar `src/components/RotaProtegida.tsx`:

```typescript
import { useAuth } from '../hooks/useAuth';
import { Navigate } from 'react-router-dom';
import { ReactNode } from 'react';

interface Props {
  children: ReactNode;
}

export function RotaProtegida({ children }: Props) {
  const { isAuthenticated, loading } = useAuth();

  if (loading) {
    return (
      <div className="flex items-center justify-center h-screen">
        <div className="text-center">
          <div className="inline-block animate-spin rounded-full h-12 w-12 border-b-2 border-blue-500"></div>
          <p className="mt-4 text-gray-600">Carregando...</p>
        </div>
      </div>
    );
  }

  if (!isAuthenticated) {
    return <Navigate to="/" replace />;
  }

  return <>{children}</>;
}
```

**Explicação:**
- Verifica se usuário está autenticado
- Se não está, redireciona para login
- `loading`: Mostra spinner enquanto carrega

### 7.3 Toast (Notificações)

Criar `src/components/Toast.tsx`:

```typescript
import { useState, useEffect } from 'react';

interface ToastProps {
  mensagem: string;
  tipo: 'sucesso' | 'erro' | 'info';
  duracao?: number;
  onClose?: () => void;
}

export function Toast({ mensagem, tipo, duracao = 3000, onClose }: ToastProps) {
  const [isVisible, setIsVisible] = useState(true);

  useEffect(() => {
    const timer = setTimeout(() => {
      setIsVisible(false);
      onClose?.();
    }, duracao);

    return () => clearTimeout(timer);
  }, [duracao, onClose]);

  if (!isVisible) return null;

  const cores = {
    sucesso: 'bg-green-500',
    erro: 'bg-red-500',
    info: 'bg-blue-500'
  };

  return (
    <div className={`${cores[tipo]} text-white px-6 py-3 rounded shadow-lg`}>
      {mensagem}
    </div>
  );
}
```

**Explicação:**
- Componente reutilizável para notificações
- `useEffect`: Remove após duração definida
- Três tipos: sucesso, erro, info

### 7.4 Avatar

Criar `src/components/Avatar.tsx`:

```typescript
interface AvatarProps {
  src?: string;
  nome: string;
  tamanho?: 'pequeno' | 'medio' | 'grande';
}

export function Avatar({ src, nome, tamanho = 'medio' }: AvatarProps) {
  const tamanhos = {
    pequeno: 'w-8 h-8 text-xs',
    medio: 'w-12 h-12 text-sm',
    grande: 'w-16 h-16 text-lg'
  };

  const iniciais = nome
    .split(' ')
    .map(n => n[0])
    .join('')
    .toUpperCase()
    .slice(0, 2);

  return (
    <div className={`${tamanhos[tamanho]} rounded-full bg-blue-500 text-white flex items-center justify-center font-bold`}>
      {src ? (
        <img src={src} alt={nome} className="w-full h-full rounded-full object-cover" />
      ) : (
        iniciais
      )}
    </div>
  );
}
```

**Explicação:**
- Componente para mostrar avatar do usuário
- Se não há imagem, mostra iniciais
- Tamanhos customizáveis

---

## Passo 8: Services (Serviços)

Os services são funções que encapsulam a lógica de comunicação com o backend.

### 8.1 Auth Service

Criar `src/services/auth.ts`:

```typescript
import { supabase } from '../lib/supabase';
import type { Usuario } from '../lib/supabase';
import { statusService } from './status';

export interface SignUpData {
  email: string;
  password: string;
  nome: string;
}

export interface SignInData {
  email: string;
  password: string;
}

export const authService = {
  // Cadastro de novo usuário
  async signUp({ email, password, nome }: SignUpData) {
    try {
      // 1. Verificar se email já existe
      const { data: existingUser } = await supabase
        .from('usuarios')
        .select('id')
        .eq('email', email)
        .maybeSingle(); // Pode retornar null

      if (existingUser) {
        throw new Error('Este email já está cadastrado!');
      }

      // 2. Criar usuário na autenticação
      const { data: authData, error: authError } = await supabase.auth.signUp({
        email,
        password,
        options: {
          data: {
            nome: nome,
          }
        }
      });

      if (authError) throw authError;

      // 3. Criar perfil do usuário na tabela 'usuarios'
      if (authData.user) {
        const { error: profileError } = await supabase
          .from('usuarios')
          .insert({
            id: authData.user.id,
            email,
            nome,
            status: 'offline',
            configuracoes: {
              notificacoes: true,
              tema: 'light',
              idioma: 'pt-BR'
            }
          });

        if (profileError) throw profileError;
      }

      return { user: authData.user, error: null };
    } catch (error: any) {
      return { user: null, error };
    }
  },

  // Login
  async signIn({ email, password }: SignInData) {
    try {
      // 1. Fazer login
      const { data: authData, error: authError } = await supabase.auth.signInWithPassword({
        email,
        password,
      });

      if (authError) throw authError;

      if (authData.user) {
        // 2. Buscar dados do usuário
        const { data: userData } = await supabase
          .from('usuarios')
          .select('*')
          .eq('id', authData.user.id)
          .single();

        // 3. Atualizar status para online
        if (userData) {
          await statusService.setStatusOnline(authData.user.id);
        }
      }

      return { user: authData.user, error: null };
    } catch (error: any) {
      return { user: null, error };
    }
  },

  // Logout
  async signOut() {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      
      if (user) {
        await statusService.setStatusOffline(user.id);
      }

      await supabase.auth.signOut();
      return { error: null };
    } catch (error: any) {
      return { error };
    }
  },

  // Obter usuário atual
  async getCurrentUser() {
    try {
      const { data: { user: authUser } } = await supabase.auth.getUser();

      if (!authUser) {
        return { user: null, error: null };
      }

      const { data: userData } = await supabase
        .from('usuarios')
        .select('*')
        .eq('id', authUser.id)
        .single();

      return { user: userData as Usuario, error: null };
    } catch (error: any) {
      return { user: null, error };
    }
  }
};
```

**Explicação:**
- **signUp**: Cadastro em 2 passos (Auth + Perfil)
- **signIn**: Login + atualizar status online
- **signOut**: Logout + atualizar status offline
- **getCurrentUser**: Obter dados do usuário atual
- Try/catch: Captura erros e retorna objeto com erro

### 8.2 Mensagens Service

Criar `src/services/mensagens.ts`:

```typescript
import { supabase } from '../lib/supabase';
import { bloqueiosService } from './bloqueios';

export interface Mensagem {
  id: string;
  remetente_id: string;
  destinatario_id: string;
  texto: string;
  tipo: 'texto' | 'imagem' | 'audio' | 'video' | 'documento';
  audio_url?: string;
  imagem_url?: string;
  video_url?: string;
  documento_url?: string;
  lida_remetente: boolean;
  lida_destinatario: boolean;
  created_at: string;
  updated_at?: string;
  deletada?: boolean;
  editada?: boolean;
}

export const mensagensService = {
  // Enviar mensagem de texto
  async enviarMensagem(remetenteId: string, destinatarioId: string, texto: string) {
    try {
      const { data, error } = await supabase
        .from('msg_chat')
        .insert({
          remetente_id: remetenteId,
          destinatario_id: destinatarioId,
          texto,
          tipo: 'texto',
          lida_remetente: true,
          lida_destinatario: false,
          created_at: new Date().toISOString()
        })
        .select()
        .single();

      if (error) throw error;
      return { mensagem: data, error: null };
    } catch (error: any) {
      return { mensagem: null, error };
    }
  },

  // Buscar mensagens de uma conversa
  async buscarMensagens(usuarioAtualId: string, outroUsuarioId: string) {
    try {
      // Verificar se está bloqueado
      const { bloqueado } = await bloqueiosService.verificarBloqueio(
        usuarioAtualId,
        outroUsuarioId
      );

      // Buscar mensagens bidirecionais
      const { data, error } = await supabase
        .from('msg_chat')
        .select('*')
        .or(
          `and(remetente_id.eq.${usuarioAtualId},destinatario_id.eq.${outroUsuarioId}),and(remetente_id.eq.${outroUsuarioId},destinatario_id.eq.${usuarioAtualId})`
        )
        .order('created_at', { ascending: true });

      if (error) throw error;

      // Se bloqueado, filtrar apenas mensagens enviadas
      const mensagensFiltradas = bloqueado
        ? data.filter(msg => msg.remetente_id === usuarioAtualId)
        : data;

      return { mensagens: mensagensFiltradas as Mensagem[], error: null };
    } catch (error: any) {
      return { mensagens: [], error };
    }
  },

  // Marcar mensagens como lidas
  async marcarComoLida(conversaId: string, usuarioId: string) {
    try {
      const { error } = await supabase
        .from('msg_chat')
        .update({ lida_destinatario: true })
        .eq('destinatario_id', usuarioId)
        .eq('remetente_id', conversaId)
        .eq('lida_destinatario', false);

      if (error) throw error;
      return { error: null };
    } catch (error: any) {
      return { error };
    }
  },

  // Editar mensagem
  async editarMensagem(mensagemId: string, novoTexto: string) {
    try {
      const { error } = await supabase
        .from('msg_chat')
        .update({
          texto: novoTexto,
          editada: true,
          updated_at: new Date().toISOString()
        })
        .eq('id', mensagemId);

      if (error) throw error;
      return { error: null };
    } catch (error: any) {
      return { error };
    }
  },

  // Deletar mensagem
  async deletarMensagem(mensagemId: string) {
    try {
      const { error } = await supabase
        .from('msg_chat')
        .update({
          deletada: true,
          texto: '[Mensagem deletada]',
          updated_at: new Date().toISOString()
        })
        .eq('id', mensagemId);

      if (error) throw error;
      return { error: null };
    } catch (error: any) {
      return { error };
    }
  },

  // Enviar arquivo (imagem, áudio, vídeo)
  async enviarArquivo(
    remetenteId: string,
    destinatarioId: string,
    arquivo: File,
    tipo: 'imagem' | 'audio' | 'video' | 'documento'
  ) {
    try {
      // 1. Fazer upload do arquivo
      const nomeArquivo = `${remetenteId}_${Date.now()}_${arquivo.name}`;
      const bucket = `${tipo}s`; // 'imagens', 'audios', etc

      const { data: uploadData, error: uploadError } = await supabase.storage
        .from(bucket)
        .upload(nomeArquivo, arquivo);

      if (uploadError) throw uploadError;

      // 2. Obter URL pública do arquivo
      const { data: { publicUrl } } = supabase.storage
        .from(bucket)
        .getPublicUrl(nomeArquivo);

      // 3. Inserir mensagem com URL
      const urlField = `${tipo}_url`;
      const { data, error } = await supabase
        .from('msg_chat')
        .insert({
          remetente_id: remetenteId,
          destinatario_id: destinatarioId,
          tipo,
          [urlField]: publicUrl,
          lida_remetente: true,
          lida_destinatario: false,
          created_at: new Date().toISOString()
        })
        .select()
        .single();

      if (error) throw error;
      return { mensagem: data, error: null };
    } catch (error: any) {
      return { mensagem: null, error };
    }
  }
};
```

**Explicação:**
- **enviarMensagem**: Envia texto
- **buscarMensagens**: Busca conversa bidirecional (A→B e B→A)
- **marcarComoLida**: Atualiza flag de mensagem lida
- **editarMensagem/deletarMensagem**: Modifica status da mensagem
- **enviarArquivo**: Upload + insere mensagem com URL

### 8.3 Conversas Service

Criar `src/services/conversas.ts`:

```typescript
import { supabase } from '../lib/supabase';
import type { Conversa } from '../pages/Chat';

export const conversasService = {
  // Buscar todas as conversas do usuário
  async buscarConversas(usuarioId: string) {
    try {
      // Busca todas as mensagens
      const { data: mensagens, error } = await supabase
        .from('msg_chat')
        .select(`
          *,
          remetente:remetente_id(id, nome, avatar_url),
          destinatario:destinatario_id(id, nome, avatar_url)
        `)
        .or(`remetente_id.eq.${usuarioId},destinatario_id.eq.${usuarioId}`)
        .order('created_at', { ascending: false });

      if (error) throw error;

      // Agrupar por conversa (outro usuário)
      const conversasMap = new Map<string, Conversa>();

      mensagens.forEach((msg: any) => {
        const outroUsuario = msg.remetente_id === usuarioId 
          ? msg.destinatario 
          : msg.remetente;
        const conversaId = outroUsuario.id;

        if (!conversasMap.has(conversaId)) {
          // Formatar última mensagem
          let ultimaMensagem = '';
          if (msg.deletada) {
            ultimaMensagem = msg.remetente_id === usuarioId
              ? 'Você apagou uma mensagem'
              : 'Uma mensagem foi apagada';
          } else if (msg.tipo === 'audio') {
            ultimaMensagem = msg.remetente_id === usuarioId
              ? 'Você: Mensagem de áudio'
              : 'Mensagem de áudio';
          } else {
            ultimaMensagem = msg.remetente_id === usuarioId
              ? `Você: ${msg.texto}`
              : msg.texto;
          }

          conversasMap.set(conversaId, {
            id: conversaId,
            nome: outroUsuario.nome,
            ultimaMensagem,
            horario: new Date(msg.updated_at || msg.created_at).toLocaleTimeString(),
            avatar: outroUsuario.avatar_url || '',
            naoLidas: msg.remetente_id !== usuarioId && !msg.lida_destinatario ? 1 : 0
          });
        }
      });

      return { conversas: Array.from(conversasMap.values()), error: null };
    } catch (error: any) {
      return { conversas: [], error };
    }
  },

  // Escutar novas conversas em tempo real
  inscreverNovasConversas(usuarioId: string, callback: (conversa: Conversa) => void) {
    const channel = supabase
      .channel('novas-mensagens')
      .on(
        'postgres_changes',
        {
          event: 'INSERT',
          schema: 'public',
          table: 'msg_chat',
          filter: `destinatario_id=eq.${usuarioId}`
        },
        async (payload: any) => {
          // Buscar info do remetente
          const { data: remetente } = await supabase
            .from('usuarios')
            .select('nome, avatar_url')
            .eq('id', payload.new.remetente_id)
            .single();

          if (remetente) {
            const novaConversa: Conversa = {
              id: payload.new.remetente_id,
              nome: remetente.nome,
              ultimaMensagem: payload.new.texto || 'Mensagem de áudio',
              horario: new Date(payload.new.created_at).toLocaleTimeString(),
              avatar: remetente.avatar_url || '',
              naoLidas: 1
            };
            callback(novaConversa);
          }
        }
      )
      .subscribe();

    return channel;
  }
};
```

**Explicação:**
- **Agrupamento**: Transforma lista de mensagens em conversas
- **Realtime**: `channel.on` escuta mudanças em tempo real
- **Última mensagem**: Formata a visualização

---

## Passo 9: Contextos e Hooks

### 9.1 AuthContext

Criar `src/contexts/AuthContext.tsx`:

```typescript
import { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { authService } from '../services/auth';
import type { Usuario } from '../lib/supabase';

// Tipo do contexto
interface AuthContextType {
  usuarioAtual: Usuario | null;
  loading: boolean;
  isAuthenticated: boolean;
}

// Criar contexto
const AuthContext = createContext<AuthContextType>({
  usuarioAtual: null,
  loading: true,
  isAuthenticated: false
});

// Provider (wrapper que fornece os dados)
export function AuthProvider({ children }: { children: ReactNode }) {
  const [usuarioAtual, setUsuarioAtual] = useState<Usuario | null>(null);
  const [loading, setLoading] = useState(true);

  // Carregar usuário ao montar o componente
  useEffect(() => {
    async function carregarUsuario() {
      const { user } = await authService.getCurrentUser();
      setUsuarioAtual(user);
      setLoading(false);
    }

    carregarUsuario();
  }, []);

  return (
    <AuthContext.Provider value={{
      usuarioAtual,
      loading,
      isAuthenticated: !!usuarioAtual // Converte para boolean
    }}>
      {children}
    </AuthContext.Provider>
  );
}

// Hook para usar o contexto
export function useAuth() {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth deve ser usado dentro de AuthProvider');
  }
  return context;
}
```

**Explicação:**
- **Context**: Compartilha dados entre componentes sem prop drilling
- **Provider**: Componente que envolve a aplicação
- **useAuth**: Hook reutilizável para acessar dados
- **isAuthenticated**: Booleano derivado (user ? true : false)

### 9.2 useAuth Hook

Criar `src/hooks/useAuth.ts`:

```typescript
import { useContext } from 'react';
import { AuthContext } from '../contexts/AuthContext';

// Reutilização simples
export function useAuth() {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth deve ser usado dentro de AuthProvider');
  }
  return context;
}
```

**Nota**: Este hook é uma duplicação do contexto por conveniência.

---

## Passo 10: Integrações com Supabase

### 10.1 Row Level Security (RLS)

No Supabase, em "Auth" → "Policies":

#### Tabela: `usuarios`

```sql
-- Qualquer um pode ler
CREATE POLICY "Usuarios são publicos" ON usuarios
  FOR SELECT USING (true);

-- Usuário só pode atualizar a si mesmo
CREATE POLICY "Usuarios podem atualizar a si mesmo" ON usuarios
  FOR UPDATE USING (auth.uid() = id);
```

#### Tabela: `msg_chat`

```sql
-- Usuário pode ler mensagens que enviou ou recebeu
CREATE POLICY "Mensagens sao privadas" ON msg_chat
  FOR SELECT USING (
    auth.uid() = remetente_id OR auth.uid() = destinatario_id
  );

-- Usuário só pode inserir mensagens como remetente
CREATE POLICY "Usuarios podem enviar mensagens" ON msg_chat
  FOR INSERT WITH CHECK (auth.uid() = remetente_id);
```

**Explicação:**
- **RLS**: Garante que usuários não acessem dados de outros
- **auth.uid()**: ID do usuário autenticado
- **Policies**: Regras de acesso no banco

### 10.2 Realtime (WebSockets)

Para habilitar realtime:

1. No Supabase, ir em "Database" → "Replication"
2. Habilitar replication para a tabela `msg_chat`
3. Agora o `channel.on()` funcionará

**Fluxo:**
```
INSERT na tabela → Supabase envia via WebSocket
  ↓
Cliente recebe em tempo real
  ↓
Callback atualiza estado React
  ↓
Componente re-renderiza
```

### 10.3 Storage (Upload de Arquivos)

```typescript
// Estrutura esperada:
// storage/
//   ├── avatares/
//   ├── audios/
//   ├── imagens/
//   ├── videos/
//   └── documentos/
```

Cada bucket DEVE estar com acesso público para os usuários conseguirem ver os arquivos.

---

## Fluxo Completo: Do Login ao Chat

### 1️⃣ Usuário Faz Login

```
App.tsx (formulário)
  ↓ handleSubmit
  ↓ authService.signIn()
  ↓ supabase.auth.signInWithPassword()
  ↓ Supabase valida credenciais
  ↓ Retorna usuário
  ↓ statusService.setStatusOnline()
  ↓ Navigate('/chat')
```

### 2️⃣ Página de Chat Carrega

```
Chat.tsx monta
  ↓ useEffect -> authService.getCurrentUser()
  ↓ Supabase busca usuário atual
  ↓ conversasService.buscarConversas()
  ↓ Busca todas as mensagens
  ↓ Agrupa por conversa
  ↓ ListaConversas renderiza
```

### 3️⃣ Usuário Seleciona Conversa

```
ListaConversas (onClick)
  ↓ setConversaSelecionada()
  ↓ mensagensService.buscarMensagens()
  ↓ ChatContent renderiza mensagens
```

### 4️⃣ Usuário Escreve e Envia

```
ChatInput.tsx
  ↓ handleEnviarMensagem()
  ↓ mensagensService.enviarMensagem()
  ↓ supabase INSERT msg_chat
  ↓ Realtime websocket notifica outro cliente
  ↓ ChatContent atualiza com nova mensagem
```

---

## Estrutura Recomendada de Pastas Finais

```
falai/
├── node_modules/
├── public/
│   └── logo.png
├── src/
│   ├── assets/
│   ├── components/
│   │   ├── AudioPlayer.tsx
│   │   ├── Avatar.tsx
│   │   ├── ChatContent.tsx
│   │   ├── ChatInput.tsx
│   │   ├── ConversaItem.tsx
│   │   ├── ErrorBoundary.tsx
│   │   ├── ImagemPreview.tsx
│   │   ├── ListaConversas.tsx
│   │   ├── MensagemBalao.tsx
│   │   ├── ModalBuscaUsuarios.tsx
│   │   ├── RotaProtegida.tsx
│   │   └── Toast.tsx
│   ├── contexts/
│   │   └── AuthContext.tsx
│   ├── hooks/
│   │   └── useAuth.ts
│   ├── lib/
│   │   └── supabase.ts
│   ├── pages/
│   │   └── Chat.tsx
│   ├── services/
│   │   ├── auth.ts
│   │   ├── bloqueios.ts
│   │   ├── conversas.ts
│   │   ├── mensagens.ts
│   │   └── status.ts
│   ├── utils/
│   │   └── documentos.tsx
│   ├── App.tsx
│   ├── App.css
│   ├── main.tsx
│   ├── index.css
│   └── vite-env.d.ts
├── .env.local
├── .gitignore
├── eslint.config.js
├── index.html
├── package.json
├── postcss.config.js
├── tailwind.config.js
├── tsconfig.json
├── vite.config.ts
└── README.md
```

---

## Próximas Fichas Técnicas

### Para Aprofundar:
- [ ] React Hooks (useState, useEffect, useContext)
- [ ] TypeScript Avançado (Generics, Types, Interfaces)
- [ ] Supabase RLS e Policies
- [ ] WebSockets em Tempo Real
- [ ] Upload de Arquivos
- [ ] Tratamento de Erros
- [ ] Performance (Memoization, Lazy Loading)

---

## Comandos Úteis

```bash
# Instalar dependências
npm install

# Iniciar desenvolvimento
npm run dev

# Build para produção
npm run build

# Preview da build
npm run preview

# Linting
npm run lint
```

---

## Troubleshooting

### "Supabase URL e Anon Key são necessários"
✓ Verificar `.env.local`
✓ Restart do `npm run dev`

### Mensagens não aparecem
✓ Verificar RLS policies
✓ Checar se Realtime está habilitado
✓ Verificar console para erros

### Avatar não carrega
✓ Verificar permissions do storage
✓ Verificar URL pública gerada

### Componentes não re-renderizam
✓ Verificar se está usando `useState` corretamente
✓ Verificar se está em `useEffect` quando necessário
✓ Usar React DevTools

---

## Conclusão

Parabéns! Você tem agora uma roadmap completa para criar o Falaí do zero com seus alunos. A estrutura é modular, escalável e segue as melhores práticas de React e TypeScript.

**Dicas para Aula:**
1. Desenvolva passo a passo, explicando cada conceito
2. Faça demos ao vivo para os alunos entenderem o fluxo
3. Deixe os alunos codificarem junto
4. Breakpoints e debugging visual
5. Mostre erros comuns e como resolvê-los

Boa sorte! 🚀
