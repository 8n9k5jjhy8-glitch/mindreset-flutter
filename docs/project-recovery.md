# MindReset — Документ восстановления проекта

Дата: 2026-05-22
Последняя рабочая сессия: 2026-05-21 / 2026-05-22

---

## 1. Общая информация

- Проект: MindReset — AI-ассистент по управлению ментальным состоянием
- Платформа: Flutter (iOS, Android, macOS)
- Backend: Supabase (Postgres + Auth + Storage + Edge Functions)
- Репозиторий: /Users/a/projects/mindreset_ai/mindreset_flutter
- Supabase Project URL: https://wvonejpospfjldcobjyl.supabase.co
- Supabase Anon Key: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind2b25lanBvc3BmamxkY29ianlsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzkxNzQ2NzMsImV4cCI6MjA5NDc1MDY3M30._lX8fH4YMPn8YvA5x4iJzbNk9oH6I0nAFcpVJPBzOw4
- Email Confirmation Landing: https://mindreset-confirm.netlify.app/confirmed.html
- Netlify Account: clinquant-profiterole-0b83cc (переименован в mindreset-confirm)

---

## 2. Что полностью готово

### 2.1 Авторизация
- Auth screen с лого MindReset и лотосом (assets/images/logo.png, flower.png)
- Регистрация с именем, email, паролем
- Email confirmation: письмо с фирменным дизайном, landing на Netlify
- AuthGate через GoRouter redirect (не StreamBuilder)
- Экран EmailConfirmScreen для неподтверждённых пользователей
- Сохранение сессии между запусками
- Восстановление пароля через resetPasswordForEmail
- macOS entitlements: com.apple.security.network.client = true

### 2.2 Профили (Supabase)
- Таблица public.profiles (id, email, name, avatar_url, created_at, updated_at)
- RLS включен: 3 политики (select_own, update_own, insert_own)
- Триггер on_auth_user_created -> handle_new_user()
- Триггер profiles_touch_updated_at -> touch_updated_at()
- Flutter: ProfileService (fetchCurrentProfile, updateName, updateAvatar)
- Flutter: Profile модель (fromMap, toUpdateMap, copyWith)

### 2.3 Архитектура
- GoRouter 17.x с StatefulShellRoute для bottom navigation
- MaterialApp.router (не MaterialApp с home)
- Фирменная тема buildMindResetTheme() в lib/app/theme.dart
- Палитра AppColors в lib/core/constants/app_colors.dart
- Утилита greetingForNow() в lib/core/utils/greeting.dart
- Шкала состояний StateLevel (calm, mild, stress, high) в lib/features/home/domain/state_level.dart

### 2.4 HomeScreen
- Лого MindReset (140px)
- Волна (wave.png как Image.asset, без ColorFiltered)
- Приветствие по времени суток
- Метрики 72 уд/мин и 18 стресс (demo)
- Карточка состояния с цветком, меняющимся по уровню (demo тап-переключатель)
- 4 горизонтальные карточки режимов: Режим спокойствия, Нужна энергия, Подготовка ко сну, Хочу сфокусироваться
- Нижняя навигация: Главная / История / Профиль

### 2.5 ProfileScreen
- Аватар с инициалом, имя, email
- Поле редактирования имени + кнопка Сохранить
- Кнопка Выйти из аккаунта

### 2.6 Дополнительное
- Продуктовый бриф: docs/product.md
- Email confirmation landing: web-confirm/confirmed.html (также загружен на Netlify)
- Supabase Storage bucket public-pages (confirmed.html)

---

## 3. Структура файлов проектаlib/
app/
app.dart - MindResetApp с MaterialApp.router
router.dart - GoRouter с redirect, StatefulShellRoute
theme.dart - buildMindResetTheme()
main_shell.dart - MainShell с bottom navigation
core/
config/
supabase_config.dart - SupabaseConfig (url, anonKey)
constants/
app_colors.dart - AppColors палитра
utils/
greeting.dart - greetingForNow()
features/
auth/
data/
auth_service.dart - AuthService (signIn, signUp, resetPassword, resendConfirmation, signOut)
presentation/
auth_screen.dart - Экран входа/регистрации с лого и лотосом
email_confirm_screen.dart - Экран подтверждения email
home/
domain/
state_level.dart - StateLevel enum + extension
presentation/
home_screen.dart - HomeScreen
widgets/
modes_grid.dart - ModesGrid (4 карточки режимов)
state_hero.dart - StateHero (карточка состояния с цветком)
wave_header.dart - WaveHeader (волна Image.asset)
history/
presentation/
history_screen.dart - Заглушка экрана истории
profile/
data/
profile_service.dart - ProfileService (fetch, updateName, updateAvatar)
domain/
profile.dart - Profile модель
presentation/
profile_screen.dart - ProfileScreen
main.dart - Entry point с Supabase.initialize
assets/
images/
logo.png
flower.png (старый, не используется напрямую)
flower_calm.png - белый лотос (уровень 1)
flower_mild.png - бежевый лотос (уровень 2)
flower_stress.png - оранжевый цветок (уровень 3)
flower_high.png - красный цветок (уровень 4)
wave.png - волна пульса
docs/
product.md - Продуктовый бриф MindReset
web-confirm/
confirmed.html - Landing страница подтверждения email
index.html - Копия для Netlify

---

## 4. Текущая проблема (незакрытая)

### Проблема с PNG-ассетами
- flower_calm.png - РАБОТАЕТ, прозрачный фон, отображается чисто
- flower_mild.png - НЕ РАБОТАЕТ, видна серая шахматка вместо прозрачного фона
- flower_stress.png - НЕ РАБОТАЕТ, аналогично
- flower_high.png - РАБОТАЕТ (красный цветок без фона)
- wave.png - НЕ РАБОТАЕТ, видны серые артефакты фона

### Причина
Файлы flower_mild.png, flower_stress.png и wave.png содержат шахматный паттерн как пиксельные данные вместо реального альфа-канала. hasAlpha: yes, но альфа-канал не используется правильно (прозрачные области заполнены шахматкой как пиксельными данными).

### Решение
Пересохранить проблемные файлы через remove.bg или аналогичный инструмент, который реально удаляет фон и сохраняет PNG с настоящими прозрачными пикселями. Либо сгенерировать новые изображения с явным промптом "transparent background, PNG with alpha channel, no checker pattern".

### Текущий код волны (wave_header.dart)
Показывает wave.png как Image.asset без ColorFiltered (потому что ColorFiltered заливал весь прямоугольник цветом из-за непрозрачного фона).

---

## 5. Supabase SQL (уже выполнен)

Таблица profiles и триггеры уже созданы. При необходимости пересоздания:

```sql
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text,
  name text,
  avatar_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.profiles enable row level security;

create policy "profiles_select_own" on public.profiles
  for select using (auth.uid() = id);

create policy "profiles_update_own" on public.profiles
  for update using (auth.uid() = id) with check (auth.uid() = id);

create policy "profiles_insert_own" on public.profiles
  for insert with check (auth.uid() = id);

create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.profiles (id, email, name)
  values (new.id, new.email, coalesce(new.raw_user_meta_data->>'name', split_part(new.email, '@', 1)))
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

create or replace function public.touch_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists profiles_touch_updated_at on public.profiles;
create trigger profiles_touch_updated_at
  before update on public.profiles
  for each row execute function public.touch_updated_at();
```

---

## 6. Supabase Auth Settings

- Email provider: включен
- Confirm email: включен
- Site URL: https://mindreset-confirm.netlify.app
- Redirect URLs:
  - https://mindreset-confirm.netlify.app/confirmed.html
  - https://mindreset-confirm.netlify.app/**
  - mindreset://auth/callback
  - mindreset://**
- Email Template (Confirm signup): кастомный HTML с зеленой кнопкой и лотосом

---

## 7. macOS Entitlements

В macos/Runner/DebugProfile.entitlements и Release.entitlements добавлено:
```xml
<key>com.apple.security.network.client</key>
<true/>
```

---

## 8. pubspec.yaml (ключевые зависимости)

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  supabase_flutter: ^2.8.0
  go_router: ^17.2.3

flutter:
  uses-material-design: true
  assets:
    - assets/images/
```

---

## 9. Следующие шаги (по плану)

1. ТЕКУЩИЙ: Починить PNG-ассеты (flower_mild, flower_stress, wave) - нужны файлы с реальной прозрачностью
2. Шаг A: Экран режима (тап по карточке режима -> экран с визуализацией и кнопкой Начать сессию)
3. Шаг D: AI Edge Function для генерации сессии
4. Шаг B: ProfileScreen v2 (настройки push, тактильные сигналы, тихие часы)
5. Шаг C: История (вкладка с сессиями)
6. Шаг E: Интеграция с часами

---

## 10. Как запустить проект

```bash
cd /Users/a/projects/mindreset_ai/mindreset_flutter
flutter clean
flutter pub get
flutter run -d macos
```

Для Chrome: flutter run -d chrome
Для iOS Simulator: flutter run (выбрать устройство)

---

## 11. Как продолжить в новой сессии

1. Открыть этот документ: docs/project-recovery.md
2. Прочитать раздел 4 (текущая проблема)
3. Починить PNG-ассеты
4. Продолжить с раздела 9 (следующие шаги)
5. Весь продуктовый контекст в docs/product.md
