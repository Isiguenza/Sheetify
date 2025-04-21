# 🚀 Sheetify

![Swift Package Manager](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen?logo=swift)&nbsp;![iOS 16+](https://img.shields.io/badge/Platform-iOS%2016%2B-orange?logo=apple)&nbsp;![License: MIT](https://img.shields.io/badge/License-MIT-blue)

> **The ultimate SwiftUI sheet framework**: Present ultra-stylish, animated sheets with headers, blur effects, and drag indicators in a single line of code.

---

## 🔥 Why Sheetify?

- **Effortless style**: Gorgeous headers, corner radii, and background effects out of the box.
- **Flexible layouts**: Multiple detents (half, large, custom fractions) with a tap-to-dismiss or drag indicator.
- **Animation control**: Customize easing and duration to match your brand’s feel.
- **Callback hooks**: `onAppear` & `onDismiss` closures for fine‑grained logic.
- **Super lightweight**: Pure SwiftUI and minimal UIKit for blur; zero dependencies.

---

## 📦 Installation

Add to your project via Swift Package Manager:

```swift
// In your Xcode project’s Swift Packages:
.package(url: "https://github.com/isiguenza/Sheetify.git", from: "1.0.0")
```

Then import:

```swift
import Sheetify
```

---

## 🚀 Quick Start

```swift
struct ContentView: View {
  @State private var showModal = false

  var body: some View {
    Button("Show Sheet") { showModal.toggle() }
      .sheetify($showModal,
                title: "Welcome to Sheetify",
                config: .init(
                  detents: [.fraction(0.4), .large],
                  backgroundStyle: .blur(radius: 20),
                  showDragIndicator: true,
                  animation: .spring(response: 0.4, dampingFraction: 0.8)
                )) {
      VStack {
        Text("🎉 Hello, SwiftUI!")
          .font(.headline)
        Spacer()
        Button("Close") { showModal = false }
      }
      .padding()
    }
  }
}
```

---

## ✨ Features

| Feature                      | Description
| ---------------------------- | --------------------------------------------------
| Multiple Detents             | Customize any number of sheet heights (`.medium`, `.large`, `.fraction(0.7)`)
| Background Styles            | `clear`, `dim(opacity:)`, or `blur(radius:)` blur effects
| Customizable Corner Radius   | Set your brand’s corner radius for sheets
| Drag Indicator               | Show/hide the native handle bar
| Tap-to-Dismiss               | Enable/disable interactive dismiss by tapping outside
| Animation Control            | Choose any SwiftUI `Animation` for arrival
| Callbacks                    | `onAppear {}`, `onDismiss {}` hooks for lifecycle events

---

## 🔧 Configuration (`TrayConfig`)

```swift
/// Full initializer:
let config = TrayConfig(
  detents: [.fraction(0.3), .fraction(0.8)],
  cornerRadius: 20,
  isInteractiveDismissDisabled: false,
  backgroundStyle: .dim(opacity: 0.5),
  showDragIndicator: true,
  animation: .easeInOut(duration: 0.2),
  onAppear: { print("Sheet appeared") },
  onDismiss: { print("Sheet dismissed") }
)
```

---

## 📖 Documentation

Auto-generated DocC:

```bash
open Package.swift; xcodebuild docbuild
```

Visit [GitHub Pages](https://youruser.github.io/Sheetify) for interactive docs.

---

## 📂 Example App

Clone the repo and open `Example/SheetifyDemo.xcodeproj` to explore a live demo.

---

## 🤝 Contributing

1. Fork this repo
2. Create a feature branch
3. Open a PR with tests and docs
4. Celebrate when merged! 🎉

---

## 📝 License

Released under MIT License – see [LICENSE](LICENSE) for details.

---

*Made with ❤️ for SwiftUI superstars.*


