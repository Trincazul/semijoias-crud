# Sistema de Cadastro de Semijoias (CRUD)

Projeto simples de CRUD em **Java + Spring Boot** para cadastro de semijoias.

## Tecnologias

- Java 17+
- Spring Boot 3.2 (Web, Data JPA, Validation)
- H2 (banco em memoria)
- Lombok

## Como rodar

```bash
mvn spring-boot:run
```

Acesse:
- API REST: http://localhost:8080/api/semijoias
- Interface web: http://localhost:8080
- Console H2: http://localhost:8080/h2-console (JDBC URL: `jdbc:h2:mem:semijoiasdb`)

## Endpoints

| Metodo | Rota | Descricao |
|--------|------|-----------|
| GET | /api/semijoias | Listar todas |
| GET | /api/semijoias/{id} | Buscar por id |
| GET | /api/semijoias/tipo/{tipo} | Buscar por tipo |
| GET | /api/semijoias/material/{material} | Buscar por material |
| GET | /api/semijoias/disponiveis | Listar disponiveis |
| POST | /api/semijoias | Criar |
| PUT | /api/semijoias/{id} | Atualizar |
| DELETE | /api/semijoias/{id} | Deletar |

## Exemplo de payload (POST/PUT)

```json
{
  "nome": "Anel Solitario",
  "tipo": "Anel",
  "material": "Banhado a ouro 18k",
  "preco": 89.90,
  "pesoGramas": 3.5,
  "descricao": "Anel com zirconia",
  "disponivel": true
}
```