# AnimeGuide

Uma aplicação simples desenvolvida em **Swift**, utilizando **UIKit** e o padrão **MVVM**, que exibe uma lista de animes consumindo a [Jikan API](https://jikan.moe/). O objetivo principal do projeto é demonstrar habilidades no consumo de APIs REST, implementação de testes e uso de recursos modernos do Swift, como **Swift Concurrency** (`async/await`).

---

## 🎯 Objetivo

O projeto busca listar os animes mais populares e permitir que o usuário explore informações básicas sobre eles. Além disso, foi desenvolvido para demonstrar:

- Uso de **MVVM** para separação de responsabilidades e maior testabilidade.
- Integração de APIs REST com **Swift Concurrency**.
- Paginação (scroll infinito) para carregamento dinâmico.
- Implementação de testes unitários na camada de networking e na view model.

---

## 🛠️ Tecnologias e Ferramentas

- **Linguagem**: Swift
- **Arquitetura**: MVVM
- **Framework**: UIKit
- **API**: [Jikan API](https://jikan.moe/) para buscar dados de animes.
- **Concurrency**: Swift Concurrency (`async/await`) para requisições assíncronas.
- **Testes**: Testes unitários utilizando `XCTest`.

---

## ⚙️ Funcionalidades

1. **Listagem de Animes**:
   - Exibe os animes mais populares com informações como:
     - Nome.
     - Gêneros.
     - Ano de lançamento.
     - Nota média.
     - Imagem.

2. **Scroll Infinito**:
   - A lista suporta paginação para carregar mais dados conforme o usuário faz scroll.

3. **Gerenciamento de Erros**:
   - Caso ocorra um erro na requisição, uma mensagem é exibida ao usuário.

4. **Testes**:
   - A camada de networking e a view model possuem cobertura de testes unitários.

---

## 🚀 Como Executar o Projeto

1. **Pré-requisitos**:
   - macOS com Xcode instalado (versão 14.0 ou superior).
   - Conexão com a internet para consumir a API.

2. **Clonar o Repositório**:
   ```bash
   git clone https://github.com/baronebarbara/AnimeGuide.git
   cd AnimeGuide
### Abrir no Xcode:

- Abra o arquivo `AnimeGuide.xcodeproj` no Xcode.

### Executar no Simulador:

- Escolha um dispositivo simulador no Xcode e clique no botão **"Run"** (⌘ + R).

---

## 💡 Considerações Finais

### Decisões de Implementação

- **Arquitetura**: Escolhi o padrão **MVVM** por ser mais adequado a projetos que requerem separação de responsabilidades e testabilidade.
- **Concurrency**: Utilizei `async/await` para simplificar e modernizar o código de requisições de rede.
- **Testes**: Adicionei testes unitários para validar a camada de networking e a view model, garantindo confiabilidade no comportamento do app.

### O que faria diferente com mais tempo?

- **Interface com mais detalhes**: Adicionaria uma tela detalhada para cada anime, exibindo informações adicionais.
- **Cache de Imagens**: Implementaria uma solução de cache para reduzir o carregamento repetido de imagens.
- **SwiftUI**: Reescreveria a interface com SwiftUI para maior simplicidade e flexibilidade em projetos futuros.



