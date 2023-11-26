# Não é um Vírus

## Visão geral

## Requisitos do sistema
O requisito mínimo para executar o jogo é ter um sistema compatível com OpenGL 2.1+ ou OpenGL ES 2+, além dos drivers gráficos relevantes. Nas três principais plataformas de desktop (Linux, macOS e Windows), o OpenGL geralmente está integrado ao sistema. No entanto, será necessário baixar e instalar um driver recente para o seu hardware gráfico caso ocorram erros de inicialização.

Para instalar os drivers necessários, bem como verificar a compatibilidade do seu sistema, consulte a [página oficial de download do OpenGL](https://www.khronos.org/opengl/wiki/Getting_Started#Downloading_OpenGL).

## Instalação
Após verificar todos os requisitos, você pode baixar a versão compatível com o seu sistema na [aba de lançamentos](https://github.com/Hylley/nao-e-um-virus/releases) e clicar duas vezes no executável `not-a-virus.exe`. Se tudo correr bem, o jogo será executado.

## Construção
### Dependências
- [Lua / LuaJIT / LLVM-lua (5.4.2)](https://luabinaries.sourceforge.net)
- [LÖVE framework (11.4)](https://love2d.org)
### Windows
No Windows as coisas são muito mais simples. Existe um arquivo em lote especial para construir o projeto: [make.bat](https://github.com/Hylley/nao-e-um-virus/blob/main/make.bat).

Existem apenas quatro variações diferentes que este lote aceita como argumentos:
```
make              :: Compila o projeto
```
```
make build        :: Idem
```
```
make run          :: Executa o projeto sem compilar
```
```
make build run    :: Compila o projeto e executa o resultado
```
Por padrão, os resultados da compilação são armazenados numa pasta especial chamada `build`, que segue o esquema:
```
.
├── build
│   ├── x64       :: Arquivos do programa para computadores operando em 64 bits
│   └── x86       :: Arquivos do programa para computadores operando em 32 bits
└── ...
```

### Outros
Definitivamente, existe uma maneira de construir o programa para outros sistemas operacionais, como Linux. Mas isso deve envolver vários comandos enigmáticos na linha de comando. Por enquanto, você pode acessar a [documentação oficial do Love2D aqui](https://love2d.org/wiki/Game_Distribution) e reunir informações úteis para fazer sua própria automação de build para o seu SO em particular.