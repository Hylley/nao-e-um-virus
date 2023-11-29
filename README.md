# Não é um Vírus

## Visão geral
Recentemente, assisti a um [vídeo do GT Live sobre um jogo chamado Outcore](https://youtu.be/fgdQdBQmhXU?si=lOthmH7r1aLDPGUf) que utiliza o desktop — bloco de notas, paint e outras funcionalidades nativas do Windows — como ambiente do jogo, e fiquei apaixonado pela ideia. É algo tão simples, mas pouco explorado devido a questões de compatibilidade. Depois de conhecer a [RetroJam](https://youtu.be/N31GWL9G4A4?si=apMUyDtsA06biokv), pensei que seria interessante fazer uma mistura entre os dois conceitos e aproveitar para aprender um novo framework.

## Requisitos do sistema
O requisito mínimo para executar o jogo são os mesmos do LÖVE: ter um sistema compatível com OpenGL 2.1+ ou OpenGL ES 2+, além dos drivers gráficos relevantes. Nas três principais plataformas de desktop (Linux, macOS e Windows), o OpenGL geralmente vem integrado ao sistema. No entanto, será necessário baixar e instalar um driver recente para o seu hardware gráfico caso ocorram erros de inicialização:

- Para instalar os drivers necessários para placas de vídeo e verificar a compatibilidade do seu sistema, consulte a [página oficial de download do OpenGL](https://www.khronos.org/opengl/wiki/Getting_Started#Downloading_OpenGL).

- Se ocorrerem erros na inicialização no Windows em ambiente de máquina virtual, considere atualizar o OpenGL [extraindo esse arquivo](https://github.com/pal1000/mesa-dist-win/releases/download/23.3.0-rc5/mesa3d-23.3.0-rc5-release-msvc.7z) e executando `systemwidedeploy.cmd`.

## Instalação
Após verificar todos os requisitos, você pode baixar a versão compatível com o seu sistema na [aba de lançamentos](https://github.com/Hylley/nao-e-um-virus/releases) e clicar duas vezes no executável `não-é-um-vírus.exe`. Se tudo correr bem, o jogo será executado.

## Construção
### Dependências
- [Lua / LuaJIT / LLVM-lua (5.4.2)](https://luabinaries.sourceforge.net)
- [LÖVE framework (11.4)](https://love2d.org)
### Windows
No Windows, as coisas são muito mais simples. Existe um arquivo em lote especial para construir o projeto: [make.bat](https://github.com/Hylley/nao-e-um-virus/blob/main/make.bat).

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
Definitivamente, existe uma maneira de construir o programa para outros sistemas operacionais, como Linux. Eu não recomendaria, já que o jogo acessa funcionalidades específicas do Windows 10/11, além de que isso deve envolver vários comandos enigmáticos na linha de comando. Por enquanto, você pode acessar a [documentação oficial do Love2D aqui](https://love2d.org/wiki/Game_Distribution) e reunir informações úteis para fazer sua própria automação de build para o seu SO em particular.