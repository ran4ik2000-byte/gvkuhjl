# Крестики-Нолики iOS 🎮

Красивое iOS приложение с игрой в крестики-нолики, написанное на SwiftUI.

## 🎨 Особенности

- Современный градиентный дизайн
- Плавные анимации
- Интуитивный интерфейс
- Определение победителя
- Быстрая перезагрузка игры
- Поддержка iPhone и iPad

## 📋 Требования

- Xcode 15.0+
- iOS 15.0+
- Swift 5.9+

## 🚀 Быстрый старт

### Вариант 1: Автоматическая сборка через GitHub Actions (рекомендуется)

1. **Загрузи проект на GitHub:**
   ```bash
   cd C:\scrips\TicTacToe
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/TicTacToe.git
   git push -u origin main
   ```

2. **Настрой сборку:**
   - Следуй подробной инструкции в файле `SETUP_GUIDE.md`
   - Настрой сертификаты Apple Developer
   - Добавь секреты в GitHub
   - Запусти автоматическую сборку

3. **Скачай IPA:**
   - После успешной сборки скачай IPA файл из GitHub Actions Artifacts
   - Установи на iPhone через AltStore, Sideloadly или Apple Configurator

### Вариант 2: Облачные сервисы (проще)

**Codemagic** (рекомендуется для новичков):
1. Зарегистрируйся на https://codemagic.io
2. Подключи свой GitHub репозиторий
3. Codemagic автоматически настроит сборку
4. Используй встроенный code signing
5. Получи IPA файл

**Bitrise**:
1. Зарегистрируйся на https://bitrise.io
2. Добавь репозиторий
3. Настрой iOS workflow
4. Запусти сборку

### Вариант 3: Локальная сборка (требуется Mac)

```bash
# Открой проект в Xcode
open TicTacToe.xcodeproj

# Или собери через командную строку
xcodebuild -project TicTacToe.xcodeproj \
  -scheme TicTacToe \
  -sdk iphoneos \
  -configuration Release \
  archive
```

## 🎯 Как играть

1. Игроки ходят по очереди
2. Первый ходит крестиком (✕), второй ноликом (◯)
3. Цель: поставить три своих символа в ряд
4. Победные клетки подсвечиваются желтым
5. Нажми "Новая игра" для перезапуска

## 📁 Структура проекта

```
TicTacToe/
├── TicTacToeApp.swift          # Точка входа приложения
├── ContentView.swift           # UI компоненты и views
├── GameViewModel.swift         # Игровая логика (MVVM)
├── Info.plist                  # Конфигурация приложения
├── TicTacToe.xcodeproj/        # Xcode проект
├── .github/workflows/          # GitHub Actions для CI/CD
│   ├── build-ipa.yml          # Основная сборка с подписью
│   └── build-ipa-unsigned.yml # Тестовая сборка для симулятора
├── SETUP_GUIDE.md             # Подробная инструкция по настройке
└── README.md                   # Этот файл
```

## 🎨 Дизайн

- **Градиент фона:** Фиолетовые оттенки (#667eea → #764ba2)
- **Крестики:** Красный цвет (#ff6b6b)
- **Нолики:** Бирюзовый цвет (#4ecdc4)
- **Эффекты:** Стеклянный морфизм, тени, плавные анимации
- **Шрифт:** SF Rounded

## 🔧 Технологии

- **SwiftUI** - современный декларативный UI фреймворк
- **Combine** - реактивное программирование
- **MVVM** - архитектурный паттерн
- **GitHub Actions** - автоматизация CI/CD

## 📱 Установка на iPhone

### Способ 1: AltStore (Windows/Mac)
1. Скачай AltStore: https://altstore.io/
2. Установи на ПК и iPhone
3. Перетащи IPA файл в приложение

### Способ 2: Sideloadly (Windows/Mac)
1. Скачай Sideloadly: https://sideloadly.io/
2. Подключи iPhone к ПК
3. Загрузи IPA и установи

### Способ 3: TestFlight (для платной подписки)
1. Загрузи IPA в App Store Connect
2. Отправь на бета-тестирование
3. Установи через TestFlight

## ⚠️ Важно

**Бесплатный Apple Developer аккаунт:**
- IPA работает 7 дней, потом нужно переустанавливать
- Максимум 3 приложения одновременно
- Только на зарегистрированных устройствах

**Платная подписка ($99/год):**
- IPA работает 1 год
- Публикация в App Store
- TestFlight для тестирования
- До 100 устройств для Ad Hoc

## 🐛 Решение проблем

**"Untrusted Developer"** на iPhone:
- Settings → General → VPN & Device Management
- Найди свой профиль разработчика
- Нажми "Trust"

**Сборка не запускается:**
- Проверь, что все GitHub Secrets добавлены
- Убедись, что Bundle ID совпадает
- Проверь срок действия сертификатов

**IPA не устанавливается:**
- Убедись, что UDID твоего iPhone в Provisioning Profile
- Проверь метод экспорта (должен быть ad-hoc или development)

## 📚 Документация

- [Подробная инструкция по настройке](SETUP_GUIDE.md)
- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)

## 📄 Лицензия

Этот проект создан для образовательных целей. Используй свободно!

## 🤝 Поддержка

Если нужна помощь с настройкой или возникли вопросы - обращайся!
