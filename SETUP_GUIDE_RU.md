# 🚀 Быстрый запуск приложения Hello World

## ✅ Что уже готово

- ✅ Веб-приложение "Hello World" создано (Node.js + Express)
- ✅ Код закоммичен в GitHub
- ✅ GitHub Actions настроен для автоматического деплоя
- ✅ Скрипты установки готовы

## 📝 Что нужно сделать (10 минут)

### Шаг 1: Настройте GitHub Secrets (2 минуты)

1. Откройте: https://github.com/eduardkolberg/testclaude/settings/secrets/actions

2. Нажмите **"New repository secret"** и добавьте 3 секрета:

**Секрет 1:** `SSH_HOST`
```
116.203.251.113
```

**Секрет 2:** `SSH_USER`
```
root
```

**Секрет 3:** `SSH_PASSWORD`
```
stxJTsTbV4bfRtKxXaaN
```

### Шаг 2: Подключитесь к серверу (1 минута)

Откройте терминал и выполните:

```bash
ssh root@116.203.251.113
```

Введите пароль: `stxJTsTbV4bfRtKxXaaN`

### Шаг 3: Запустите установку (одна команда, 5 минут)

Скопируйте и выполните эту команду на сервере:

```bash
curl -fsSL https://raw.githubusercontent.com/eduardkolberg/testclaude/claude/hello-world-github-actions-3RoPr/quick-setup.sh | bash
```

**Что делает этот скрипт:**
- Обновляет систему
- Устанавливает Node.js 18.x
- Устанавливает Nginx (веб-сервер)
- Устанавливает PM2 (менеджер процессов)
- Устанавливает Git
- Клонирует ваше приложение
- Настраивает Nginx как reverse proxy
- Запускает приложение
- Настраивает firewall

**Ожидаемое время:** 3-5 минут

### Шаг 4: Проверьте результат! 🎉

Откройте в браузере:

# 🌐 http://116.203.251.113

**Ожидаемый результат:** На странице должно отображаться `hello world`

---

## 🔄 Автоматический деплой

После выполнения всех шагов, каждый раз когда вы делаете `git push` в ветку `claude/hello-world-github-actions-3RoPr`, GitHub Actions автоматически деплоит изменения на сервер!

Проверить статус деплоя: https://github.com/eduardkolberg/testclaude/actions

---

## 🛠 Полезные команды на сервере

```bash
# Посмотреть логи приложения
pm2 logs hello-world-app

# Перезапустить приложение
pm2 restart hello-world-app

# Статус всех процессов
pm2 status

# Остановить приложение
pm2 stop hello-world-app

# Статус Nginx
systemctl status nginx

# Перезапустить Nginx
systemctl restart nginx

# Проверить приложение локально на сервере
curl http://localhost:3000
```

---

## 📊 Архитектура

```
Интернет → Nginx (порт 80) → Node.js приложение (порт 3000)
                ↑
         GitHub Actions (автоматический деплой)
```

- **Nginx** слушает на порту 80 и проксирует запросы к Node.js
- **Node.js** приложение работает на порту 3000 под управлением PM2
- **PM2** обеспечивает автозапуск при перезагрузке сервера и мониторинг
- **GitHub Actions** автоматически деплоит при каждом push

---

## ❓ Возможные проблемы

### Приложение не отвечает

```bash
# На сервере проверьте статус
pm2 status
pm2 logs hello-world-app

# Перезапустите приложение
pm2 restart hello-world-app
```

### Nginx не работает

```bash
# Проверьте статус
systemctl status nginx

# Проверьте конфигурацию
nginx -t

# Перезапустите
systemctl restart nginx
```

### GitHub Actions не может подключиться

Проверьте что все 3 секрета добавлены правильно в GitHub Secrets.

---

## 📚 Дополнительная информация

- Полная инструкция: `DEPLOY_INSTRUCTIONS.md`
- Конфигурация PM2: `ecosystem.config.js`
- Код приложения: `index.js`
- GitHub Actions workflow: `.github/workflows/deploy.yml`
