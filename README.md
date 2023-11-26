# Não é um Vírus

## Visão geral

## Execução
### Requisitos
O principal requisito para executar o programa é ter um sistema compatível com OpenGL 2.1 ou OpenGL ES 2, bem como os drivers gráficos relevantes. Em todas as três principais plataformas de desktop (Linux, macOS e Windows), o OpenGL geralmente vem integrado ao sistema. No entanto, você precisará baixar e instalar um driver recente para seu hardware gráfico caso ocorram erros de inicialização.

Para instalar os drivers necessários (bem como verificar se o seu sistema é compatível) consulte a [página oficial de download do OpenGL](https://www.khronos.org/opengl/wiki/Getting_Started#Downloading_OpenGL).

### Passos
Depois de verificar todos os requisitos, basta clicar duas vezes no executável `not-a-virus.exe`. Se tudo correr bem, o programa será executado com sucesso.

## Compilação a partir do código-fonte
### Windows
Se você estiver no Windows, as coisas são muito mais simples, já que existe um arquivo em lote especial para construir o projeto: [make.bat](https://github.com/Hylley/nao-e-um-virus/blob/main/make.bat).

Existem apenas quatro variações diferentes que este programa aceita como argumentos:
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
Por padrão os resultados da compilação são armazenados numa pasta chamada especial que obedece o esquema:
```
.
├── build
│   ├── x64		:: Versão do programa para computadores operando em 64 bits
│   └── x86		:: Versão do programa para computadores operando em 32 bits
└── ...
```

### Outros
Definitivamente existe uma maneira de construir o programa para outros sistemas operacionais, como Linux. Mas isso provavelmente envolve vários comandos enigmáticos na linha de comando. Por enquanto, você pode acessar a [documentação oficial do Love2D aqui](https://love2d.org/wiki/Game_Distribution) e reunir informações úteis para fazer sua própria automação de build para o seu SO em particular.