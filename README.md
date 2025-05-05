# My7Quotes 📜🎵

**My7Quotes** is a Flutter-based Android app that displays emotional, relatable quotes in a TikTok-style vertical scroll. Each quote is beautifully presented with background music and can be favorited or downloaded as an image with the app's branding.

---

## 📱 Features

- 🔁 Vertical quote feed (TikTok-style swipe)
- 🎶 Background music for each quote
- 💖 Add to favorites
- 🖼️ Download quote as an image (with logo/header)
- ☁️ Sync with Firebase Firestore
- 📦 Offline access via Hive

---

## 🔗 APK Download

You can try the app by downloading the latest APK:

👉 [Download My7Quotes APK](https://drive.google.com/file/d/1H-dxeIxzEEyyIyL0hfdqWQ8ewPH-_HpR/view?usp=sharing)

---

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/your-username/my7quotes.git
cd my7quotes
```

### 2. Set up Firebase

This app uses Firebase for syncing quotes and user favorites. You must create your own Firebase project to use it.

#### 🔧 Firebase Setup Steps:

1. Go to [https://console.firebase.google.com](https://console.firebase.google.com) and create a new project.
2. Add an Android app to your Firebase project.
3. Download the `google-services.json` file and place it in:
   ```
   android/app/google-services.json
   ```
4. In your Flutter code (`main.dart` or `firebase_options.dart`), **replace the current `FirebaseOptions` values** with your own project’s details:
   - `apiKey`
   - `authDomain`
   - `projectId`
   - `storageBucket`
   - `messagingSenderId`
   - `appId`
   - `measurementId`

> 🔐 Never share your real Firebase credentials in public repos!

---

### 3. Install Flutter dependencies

```bash
flutter pub get
```

### 4. Run the app

```bash
flutter run
```

> ⚠️ Make sure you have Flutter SDK installed and a device/emulator connected.

---

## 📁 Project Structure

```
my7quotes/
├── lib/                  # Dart source code
│   ├── main.dart
│   ├── models/
│   ├── screens/
│   ├── services/
│   └── widgets/
├── android/              # Android native files
├── assets/               # Fonts, music, images
├── pubspec.yaml          # Dependencies and asset registration
├── pubspec.lock
└── README.md
```

---

## 🛠 Built With

- [Flutter](https://flutter.dev/)
- [Firebase Firestore](https://firebase.google.com/)
- [Hive](https://docs.hivedb.dev/)
- [Provider](https://pub.dev/packages/provider)

---

## 📸 Screenshots

_Screenshots coming soon..._

---

## 📄 License

This project is licensed under the MIT License. Feel free to use and modify it.

---

## 🙌 Contributions

Got ideas? Found a bug? Open an issue or submit a pull request! All contributions are welcome.
