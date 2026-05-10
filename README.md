# Mutual Fund Browser

A Flutter app for browsing Indian mutual fund schemes using the public [mfapi.in](https://mfapi.in) API.

---

## How to Run Locally

### Prerequisites
- Flutter SDK ≥ 3.0 (stable channel)
- Android Studio / Xcode for a connected device or emulator

### Setup

```bash
# 1. Install dependencies
flutter pub get

# 2. Create your environment file from the template
cp .env.json.example .env.json
# Fill in AUTH_EMAIL and AUTH_PASSWORD in .env.json

# 3. Run the app
flutter run --dart-define-from-file=.env.json
```

> **VS Code users:** a `launch.json` is already configured — press **F5** and the env file is picked up automatically.

### Build a release APK

```bash
flutter build apk --release --dart-define-from-file=.env.json
# Output: build/app/outputs/flutter-apk/app-release.apk
```

---

## Login Credentials

| Field | Value |
|---|---|
| Email | `calathea.tester@finroles.com` |
| Password | `Calathea#1234` |

These are hardcoded dummy credentials — no real authentication backend is involved. On successful login a token (`dummy-<timestamp>`) is written to secure storage (Keychain on iOS, EncryptedSharedPreferences on Android) and persists across restarts.

---

## Assumptions

- **No real auth** — credentials are validated locally against hardcoded values. The token is a generated string; there is no backend.
- **Search scope** — the full 30 000+ scheme list is fetched once and filtered entirely in memory. Search covers both scheme name and scheme code.
- **Pagination** — the scheme list renders 50 items at a time and loads the next batch as the user scrolls, to keep the initial render fast.
- **Offline handling** — API responses are cached to disk (scheme list: 1 h TTL, detail: 15 min). On a network failure the app silently serves stale cached data if available; the error screen only appears when there is no cache at all.
- **NAV history** — displayed newest-first as returned by the API. No date-range filtering is applied.
- **Invest flow** — tapping Confirm shows a success snackbar. No payment or order API is called.
