# Инструкция по развертыванию Hello World приложения

## Что уже готово

✅ Веб-приложение создано (Node.js + Express)
✅ Код закоммичен в GitHub
✅ GitHub Actions workflow настроен для автоматического деплоя
✅ Скрипты настройки сервера готовы

## Шаги для запуска (5-10 минут)

### Шаг 1: Настройка GitHub Secrets

Перейдите в настройки репозитория:
https://github.com/eduardkolberg/testclaude/settings/secrets/actions

Добавьте 3 секрета:

**SSH_HOST**
```
116.203.251.113
```

**SSH_USER**
```
root
```

**SSH_PASSWORD**
```
stxJTsTbV4bfRtKxXaaN
```

### Шаг 2: Подключитесь к серверу

```bash
ssh root@116.203.251.113
```
Пароль: `stxJTsTbV4bfRtKxXaaN`

### Шаг 3: Запустите скрипт установки (одна команда)

Скопируйте и выполните:

```bash
curl -fsSL https://raw.githubusercontent.com/eduardkolberg/testclaude/claude/hello-world-github-actions-3RoPr/quick-setup.sh | bash
```

Скрипт автоматически:
- Установит Node.js, Nginx, PM2, Git
- Клонирует репозиторий
- Установит зависимости
- Настроит Nginx как reverse proxy
- Запустит приложение
- Настроит firewall

Установка займет 3-5 минут.

### Шаг 4: Проверьте результат

После завершения установки откройте в браузере:

**🌐 http://116.203.251.113**

Вы должны увидеть: `hello world`

## Автоматический деплой

После настройки GitHub Secrets, каждый push в ветку `claude/hello-world-github-actions-3RoPr` будет автоматически деплоить изменения на сервер через GitHub Actions.

## Управление приложением на сервере

```bash
# Посмотреть логи
pm2 logs hello-world-app

# Перезапустить приложение
pm2 restart hello-world-app

# Статус приложения
pm2 status

# Проверить Nginx
systemctl status nginx
```

## Архитектура

```
Internet → Nginx (port 80) → Node.js App (port 3000)
```

- Nginx слушает на порту 80 и проксирует запросы к Node.js
- Node.js приложение работает на порту 3000 под управлением PM2
- PM2 обеспечивает автозапуск и мониторинг приложения
