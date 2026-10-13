# App Flutter - Cadastro de Semijoias

App mobile que consome a API Spring Boot do projeto.

## Como rodar

1. Instale o Flutter SDK: https://docs.flutter.dev/get-started/install
2. Inicie o backend (Spring Boot) em `http://localhost:8080`
3. No emulador Android, altere `baseUrl` em `lib/services/api_service.dart` para `http://10.0.2.2:8080/api/semijoias`
4. Execute:

```bash
flutter pub get
flutter run
```