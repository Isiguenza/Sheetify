<p align="center">
  <img src="Assets/SheetifyLogo.png" alt="Sheetify Logo" width="520"/>
</p>

# Sheetify
**Stylish, configurable SwiftUI sheets — with optional multi‑step flows**

![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20macCatalyst-blue) ![Swift](https://img.shields.io/badge/swift-5.7-orange)

A powerful SwiftUI package that transforms the built‑in `.sheet` into a polished, interactive _tray_ — complete with custom corners, animations, and even multi‑step wizards. If you love UIKit’s bottom sheets or want to delight your users with modern, fluid modals, _Sheetify_ is for you.

---

## 🚀 Features

- **Single-shot sheets** with:
  - Customizable detents (fractional heights)
  - Adjustable corner radii
  - Tap‑outside dismissal control
  - Configurable entry animations and durations
  - Built‑in header with title and close button
- **Automatic multi‑step flows** (`.sheetifyFlow`):
  - Define your steps as a `CaseIterable` enum
  - Header auto‑titles to current step
  - Back (X) button navigates to previous step or dismisses
  - Content‑driven height (shrink‑wrap) — no hard‑coded detents
  - Smooth transitions and spring animations

---

## 📦 Installation

**Swift Package Manager**

1. In Xcode, go to **File → Add Packages...**
2. Enter the repository URL: `https://github.com/youruser/Sheetify.git`
3. Choose the latest version tag and add the **Sheetify** library.

Or in your `Package.swift`:

```swift
.package(url: "https://github.com/youruser/Sheetify.git", from: "1.0.0")
```

Then add `"Sheetify"` as a dependency for your target.

---

## 🎉 Quick Start

Import and apply the modifier anywhere you’d use `.sheet`:

```swift
import Sheetify

struct MyView: View {
  @State private var showModal = false
  var body: some View {
    Button("Open Sheet") { showModal.toggle() }
      .sheetify($showModal, title: "Hello Sheet") {
        Text("Hello, Sheetify!")
          .padding()
      }
  }
}
```

That’s it! You get a header, close button, and default detent at 99% screen height.

---

## 🔧 Configuration (`TrayConfig`)

```swift
public struct TrayConfig {
  public var maxDetent: PresentationDetent // e.g. .fraction(0.5), .large
  public var cornerRadius: CGFloat         // sheet corner radius
  public var isInteractiveDismissDisabled: Bool
  public var appearanceAnimationDuration: Double
  // ... plus others (background style, callbacks, drag indicator)
}
```

Pass your custom config:

```swift
.sheetify(
  $show, title: "Custom",
  config: TrayConfig(maxDetent: .fraction(0.6), cornerRadius: 24)
) {
  // content
}
```

---

## 🧙 Multi‑Step Flows (`.sheetifyFlow`)

When you need a wizard-like sequence, define your steps as a `CaseIterable` enum:

```swift
enum WizardStep: CaseIterable, Hashable {
  case intro, details, confirm
}
```

Then attach:

```swift
.sheetifyFlow(
  $showWizard,
  startStep: .intro
) { step in
  switch step.wrappedValue {
  case .intro:
    VStack { Text("Welcome!")
      Button("Next") { step.wrappedValue = .details }
    }
  case .details:
    VStack { Text("Enter details")
      // ...
      Button("Next") { step.wrappedValue = .confirm }
    }
  case .confirm:
    VStack { Text("All set!")
      Button("Finish") { showWizard = false }
    }
  }
}
```

- **Header** automatically shows “Intro”, “Details”, “Confirm”
- **Back button** on header steps back; first step X dismisses
- **Content‑driven height**: each step’s sheet height matches its content
- **Smooth springs & transitions** out of the box

---

## 📖 Examples

**Basic**
```swift
.sheetify($show, title: "Hello") {
  Text("Simple content")
}
```

**Rounded Corners & Half Height**
```swift
.sheetify(
  $show,
  title: "Half Sheet",
  config: TrayConfig(maxDetent: .fraction(0.5), cornerRadius: 20)
) {
  Text("Half the screen with 20pt corners")
}
```

**3‑Step Wizard**
```swift
.sheetifyFlow($showWizard, startStep: .step1) { step in
  // ... switch/steps as shown above ...
}
```

---

## 💡 Tips & Tricks

- **Shrink-wrap height**: Remove `.presentationDetents` in your config to let the sheet size itself to content
- **Custom animations**: override `appearanceAnimationDuration` or wrap step changes in `withAnimation(.spring())`
- **Background styles**: use `TrayConfig`’s `backgroundStyle` to dim or blur
- **Lifecycle callbacks**: `config.onAppear` and `config.onDismiss` for event handling

---

## ✨ Contributing

1. Fork the repo
2. Branch from `main`
3. Create your feature branch
4. Submit a pull request

We welcome issues, feature requests, and pull requests. Let’s make SwiftUI sheets unforgettable!

---

## 📜 License

[MIT](./LICENSE) © 2025 Your Name

