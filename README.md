# devsamurai-to-s3

Um script simples para realizar o backup do material disponibilizado no site [Dev Samurai](https://class.devsamurai.com.br/) para qualquer storage compatível com a API da AWS S3.

## Requisitos

Um terminal compatível com bash, git e docker.

## Como usar

1. Clone o repositório:

  ```bash
  git clone https://github.com/alanhoff/devsamurai-to-s3.git
  ```

2. Modifique o arquivo [.env](.env) com suas credenciais da S3
3. Execute o script [./build.sh](./build.sh) para iniciar o backup

## Licença

O script para backup é disponibilizado sob a licença ISC. O conteúdo baixado do Dev Samurai é de propriedade e responsabilidade de seus respectivos autores, não possuo qualquer relação com o site, com a marca, com o conteúdo ou com os autores. Antes de realizar o backup ou utilizar o conteúdo, verifique os termos de uso e peça autorização para os autores (se necessário) através de um dos links abaixo:

- [Dev Samurai](https://class.devsamurai.com.br/)
- [Mirror](https://web.archive.org/web/20250113234414/https://class.devsamurai.com.br/)