# Não é um Vírus

## Building and Development
### Windows
Se você estiver no Windows, as coisas serão muito mais fáceis, pois existe um arquivo em lote especial para construir o projeto: make.bat.

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
Por padrão os resultados da compilação são armazenados numa pasta chamada "build" que obedece o esquema:
```
build/
|-- x64/
	|-- love.dll
	|-- love.dll
|-- x86/
	|-- ...

```

### Other
Definitivamente existe uma maneira de construir o programa para outros sistemas operacionais, como Linux. Mas isso provavelmente envolve vários comandos enigmáticos na linha de comando. Por enquanto, você pode acessar a [documentação oficial do Love2D aqui](https://love2d.org/wiki/Game_Distribution) e reunir informações úteis para fazer sua própria automação de build.