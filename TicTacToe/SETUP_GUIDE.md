# Инструкция по настройке автоматической сборки IPA

Этот проект настроен для автоматической сборки IPA файла через GitHub Actions.

## Шаг 1: Создай аккаунт Apple Developer

1. Зайди на https://developer.apple.com
2. Зарегистрируйся (есть бесплатный вариант для тестирования)
3. Если нужна публикация в App Store - подпишись на платный план ($99/год)

## Шаг 2: Создай сертификаты (требуется Mac)

На Mac выполни следующие команды:

### 2.1 Создай сертификат разработчика

```bash
# Открой Keychain Access → Certificate Assistant → Request a Certificate From a Certificate Authority
# Сохрани файл как CertificateSigningRequest.certSigningRequest
```

### 2.2 Скачай сертификат с Apple Developer Portal

1. Зайди на https://developer.apple.com/account/resources/certificates/list
2. Создай новый сертификат (iOS App Development или iOS Distribution)
3. Загрузи CertificateSigningRequest.certSigningRequest
4. Скачай сертификат (.cer файл)
5. Двойной клик по сертификату для установки в Keychain

### 2.3 Экспортируй сертификат в .p12

```bash
# В Keychain Access найди свой сертификат
# Right click → Export
# Сохрани как Certificates.p12
# Установи пароль (запомни его!)
```

### 2.4 Создай Provisioning Profile

1. Зайди на https://developer.apple.com/account/resources/profiles/list
2. Создай новый профиль (iOS App Development или Ad Hoc)
3. Выбери App ID (создай новый с bundle ID: com.tictactoe.app)
4. Выбери сертификат
5. Выбери устройства (для Ad Hoc - добавь UDID твоего iPhone)
6. Скачай .mobileprovision файл

### 2.5 Узнай UDID своего iPhone

```bash
# Подключи iPhone к Mac
# Открой Finder → iPhone → вкладка "General"
# Нажми на серийный номер - появится UDID
# Или используй команду:
system_profiler SPUSBDataType | grep "Serial Number" -A 1
```

## Шаг 3: Создай ExportOptions.plist

Создай файл ExportOptions.plist:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>ad-hoc</string>
    <key>teamID</key>
    <string>YOUR_TEAM_ID</string>
    <key>signingStyle</key>
    <string>manual</string>
    <key>provisioningProfiles</key>
    <dict>
        <key>com.tictactoe.app</key>
        <string>YOUR_PROVISIONING_PROFILE_NAME</string>
    </dict>
</dict>
</plist>
```

Замени:
- `YOUR_TEAM_ID` - найди на https://developer.apple.com/account (Team ID)
- `YOUR_PROVISIONING_PROFILE_NAME` - имя твоего provisioning profile

## Шаг 4: Конвертируй файлы в Base64

```bash
# Конвертируй сертификат
base64 -i Certificates.p12 -o certificate.txt

# Конвертируй provisioning profile
base64 -i YourProfile.mobileprovision -o profile.txt

# Конвертируй ExportOptions.plist
base64 -i ExportOptions.plist -o export.txt
```

## Шаг 5: Добавь Secrets в GitHub

1. Зайди в свой репозиторий на GitHub
2. Settings → Secrets and variables → Actions → New repository secret

Добавь следующие secrets:

| Secret Name | Значение |
|------------|----------|
| `BUILD_CERTIFICATE_BASE64` | Содержимое certificate.txt |
| `P12_PASSWORD` | Пароль от .p12 файла |
| `BUILD_PROVISION_PROFILE_BASE64` | Содержимое profile.txt |
| `KEYCHAIN_PASSWORD` | Любой пароль (например: temp_password_123) |
| `EXPORT_OPTIONS_PLIST` | Содержимое export.txt |

## Шаг 6: Загрузи код на GitHub

```bash
cd C:\scrips\TicTacToe
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/TicTacToe.git
git push -u origin main
```

## Шаг 7: Запусти сборку

1. Зайди в свой репозиторий на GitHub
2. Actions → Build IPA → Run workflow
3. Дождись завершения сборки (5-10 минут)
4. Скачай IPA файл из Artifacts

## Шаг 8: Установи IPA на iPhone

### Способ 1: AltStore (рекомендуется для Windows)

1. Скачай AltStore: https://altstore.io/
2. Установи AltStore на свой ПК и iPhone
3. Перетащи IPA файл в AltStore на iPhone
4. Готово!

### Способ 2: Sideloadly

1. Скачай Sideloadly: https://sideloadly.io/
2. Подключи iPhone к ПК
3. Загрузи IPA файл
4. Введи свой Apple ID
5. Установи

### Способ 3: Apple Configurator (только Mac)

1. Скачай Apple Configurator из App Store
2. Подключи iPhone
3. Перетащи IPA файл на устройство

## Упрощенный способ (без сертификатов)

Для тестирования можешь использовать **облачные сервисы**:

### Codemagic (30 минут сборки бесплатно в месяц)

1. Зайди на https://codemagic.io
2. Подключи свой GitHub репозиторий
3. Codemagic автоматически определит iOS проект
4. Настрой code signing или используй Codemagic signing
5. Запусти сборку

### Bitrise (бесплатный план доступен)

1. Зайди на https://bitrise.io
2. Добавь свой GitHub репозиторий
3. Выбери iOS workflow
4. Настрой signing
5. Запусти сборку

## Важные замечания

⚠️ **Бесплатный Apple Developer аккаунт:**
- IPA работает только 7 дней
- Нужно переустанавливать каждую неделю
- Можно установить только на зарегистрированные устройства

✅ **Платный Apple Developer ($99/год):**
- IPA работает 1 год
- Можно опубликовать в App Store
- TestFlight для бета-тестирования

## Решение проблем

**Ошибка: "No matching provisioning profiles found"**
- Проверь, что Bundle ID совпадает с Provisioning Profile
- Убедись, что UDID устройства добавлен в профиль

**Ошибка: "Code signing failed"**
- Проверь правильность сертификатов в GitHub Secrets
- Убедись, что пароли верные

**IPA не устанавливается на iPhone**
- Убедись, что UDID твоего iPhone добавлен в Provisioning Profile
- Проверь, что метод экспорта - "ad-hoc" или "development"

## Нужна помощь?

Если что-то не получается, дай знать на каком шаге возникла проблема!
