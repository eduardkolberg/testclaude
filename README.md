# 🌐 Hello World Web Application

Простое веб-приложение на Node.js, которое отображает "hello world".

## 🚀 Быстрый старт

**Смотрите:** [FINAL_INSTRUCTIONS.md](FINAL_INSTRUCTIONS.md) - полная инструкция на русском языке

**Или:** [QUICK_START.txt](QUICK_START.txt) - краткая шпаргалка

## 📝 Три простых шага:

1. **Настройте GitHub Secrets** (2 минуты)
   - https://github.com/eduardkolberg/testclaude/settings/secrets/actions
   - Добавьте: `SSH_HOST`, `SSH_USER`, `SSH_PASSWORD`

2. **Настройте сервер** (5 минут)
   ```bash
   ssh root@116.203.251.113
   curl -fsSL https://raw.githubusercontent.com/eduardkolberg/testclaude/claude/hello-world-github-actions-3RoPr/quick-setup.sh | bash
   ```

3. **Откройте в браузере:**
   - 🌐 **http://116.203.251.113**

## 🔧 Технологии

- **Backend**: Node.js 18 + Express
- **Process Manager**: PM2
- **Web Server**: Nginx (reverse proxy)
- **CI/CD**: GitHub Actions

## 📦 Что включено

- ✅ Веб-приложение "Hello World"
- ✅ Автоматический деплой через GitHub Actions
- ✅ Скрипты автоматической установки сервера
- ✅ Подробная документация на русском языке

## 🌍 Endpoints

- **GET /** - Возвращает "hello world"
- **GET /health** - Health check {"status":"ok"}

## 🏗 Архитектура

```
Internet → Nginx (port 80) → Node.js App (port 3000)
```

## 📚 Документация

- [FINAL_INSTRUCTIONS.md](FINAL_INSTRUCTIONS.md) - 🎯 Полная инструкция (НАЧНИТЕ ОТСЮДА)
- [SETUP_GUIDE_RU.md](SETUP_GUIDE_RU.md) - Детальное руководство
- [QUICK_START.txt](QUICK_START.txt) - Краткая шпаргалка
- [DEPLOY_INSTRUCTIONS.md](DEPLOY_INSTRUCTIONS.md) - Техническая документация

## 🔄 Автоматический деплой

После настройки, каждый `git push` в ветку `claude/hello-world-github-actions-3RoPr` автоматически деплоит изменения на сервер через GitHub Actions.

**Статус деплоев:** https://github.com/eduardkolberg/testclaude/actions

## 💻 Локальная разработка

```bash
npm install
npm start
```

Приложение будет доступно по адресу: http://localhost:3000

## 🎯 Результат

После выполнения всех шагов приложение будет доступно по адресу:

# 🌐 http://116.203.251.113

На странице отобразится: **hello world**
