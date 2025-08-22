# IPS PH4H App

Unified health app for Connectathon users to view, merge, and share IPS data securely—cross-border, patient-managed, FHIR-compatible, and easy to use.

## Supported features

- Customizable theme, icons and images
- Login and sign up flow with OAuth authentication
- Load IPS from national backend
- IPS viewer
- Filterable IPS and creation of VHL from selection
- QR code share screen

### Incoming features

- Read IPS QR code
- Merge IPS
- Add VHL to your Wallet
- Recover Password

## Requirements

- [Flutter SDK](https://flutter.dev/docs/get-started/install) >= 3.32.1
- Dart SDK >= 3.8.1
- Android Studio or Xcode (for iOS)
- A device or emulator

\*For Android you need Java 17.

To check your environment:

```bash
flutter doctor
```

## Setup your environment

Before you start running the project you will need to setup your configurations. We have the basic setup inside the `.env.sample` file. Please copy it into your custom `.env` file:

```bash
cp .env.sample .env
```

The `.env` will contain these values:

```shell
# Backend API
API_ENDPOINT=''

# Keycloak
KEYCLOAK_ENDPOINT=''
# Name of the realm created on keycloak
KEYCLOAK_REALM=''
# Client id you can get from inside keycloak admin-cli client credentials settings
KEYCLOAK_CLIENT_ID=''
# Refresh token key, on keycloak is refresh_token
KEYCLOAK_REFRESH_TOKEN_KEY=''

# IPS
# The number of days the user's IPS bundle will be stored in the device storage after fetching it from 
# the FHIR server
IPS_EXP_DAYS=6

# VHL
# The number of days the generated QR code will expire
VHL_EXPIRATION_DAYS=14
# In case you want to add a passcode to the generated QR code
VHL_PASS_CODE='0000'
```

All other settings are optional. If you want to customize color, icons, locales, etc, please check the details on this [guide](./docs/customize-your-app.md).

## How to Run the App

1. Install the dependencies

```bash
flutter pub get
```

2. If you are generating new translations you need to run this:

```bash
flutter gen-l10n
```

3. Run on device/emulator

```bash
flutter run
```

Note: iOS devices can only be run in MacOS machines.

## Build & Deploy

### Android (Debug / Release)

```bash
# Debug build
flutter build apk

# Release build (Play Store ready)
flutter build apk --release
```

### iOS (requires macOS)

```bash
# Debug build
flutter build ios

# Release build (App Store ready)
flutter build ipa --release
```

> Ensure you configure code signing and provisioning profiles for iOS before release builds.
