
# Flutter Firebase Login - Guia de Configuração

## 1. Clone o repositório
```bash
git clone https://github.com/GuibsonKrause/flutter_login_firebase.git
```

## 2. Crie um projeto no Firebase Console
1. Acesse https://console.firebase.google.com
2. Clique em **Adicionar projeto** e siga as instruções
3. No menu **Authentication ▶ Sign-in method**, habilite **Email/Password**

## 3. Adicione o app Android no Firebase
1. Em **Configurações do projeto ▶ Seus apps ▶ Android ▶ Adicionar app**
2. Informe o **Application ID** (ver `android/app/build.gradle.kts`)
3. Baixe o arquivo **google-services.json**
4. Copie para `android/app/google-services.json`

## 4. Instale as CLIs necessárias
- Git: `git --version`
- Firebase CLI: https://firebase.google.com/docs/cli#install_the_firebase_cli
  ```bash
  npm install -g firebase-tools
  firebase login
  ```
- FlutterFire CLI:
  ```bash
  dart pub global activate flutterfire_cli
  ```

## 5. Configure o Firebase no projeto
```bash
flutterfire configure --project=SEU_ID_DO_PROJETO_FIREBASE
```
Isso gera `lib/firebase_options.dart` com suas credenciais.

## 6. Atualize dependências e rode o app
```bash
flutter pub get
flutter run
```

## 7. Teste o Login
- Crie usuários em **Authentication ▶ Users** no Console
- Use os e-mails e senhas criados na tela de login
- Após login bem-sucedido, você será redirecionado para a tela Home

---

**Boas práticas:**
- Não versionar `android/app/google-services.json` e `lib/firebase_options.dart`
- Cada aluno deve usar seu próprio projeto Firebase  
