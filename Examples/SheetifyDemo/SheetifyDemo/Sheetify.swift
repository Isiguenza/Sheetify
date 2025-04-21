// ContentViewSimple.swift
// SheetifyDemo
//
// Demonstrates basic one–shot sheetify usage with various configurations.
// Simple examples to get you started with the .sheetify modifier.

import SwiftUI
import Sheetify

/// A view showing three different uses of the `sheetify` modifier:
/// 1. Default sheet
/// 2. Custom corner radius and detent
/// 3. Custom animation duration
struct ContentView: View {
    /// State for presenting the default sheet
    @State private var showDefault = false
    /// State for presenting the sheet with custom corners
    @State private var showCustom = false
    /// State for presenting the sheet with custom animation
    @State private var showAnimated = false

    var body: some View {
        VStack(spacing: 24) {
            // Title of the demo
            Text("🔹 Simple Sheetify Examples")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top)

            // MARK: Example 1 — Default settings
            Button("Show Default Sheet") {
                showDefault.toggle() // Toggle visibility
            }
            .buttonStyle(DemoButton(color: .blue))
            .sheetify($showDefault, title: "Default Sheet") {
                // Content inside the sheet
                Text("This is a simple sheet with default settings.")
                    .padding()
            }

            // MARK: Example 2 — Custom corner radius & detent
            Button("Custom Corner Radius") {
                showCustom.toggle()
            }
            .buttonStyle(DemoButton(color: .green))
            .sheetify(
                $showCustom,
                title: "Rounded Corners",
                config: .init(
                    maxDetent: .fraction(0.6),    // Sheet stops at 60% height
                    cornerRadius: 16              // 16pt rounded corners
                )
            ) {
                Text("Sheet stops at 60% height and has 16pt corners.")
                    .padding()
            }

            Spacer() // Push content to top
        }
        .padding(.horizontal)
    }
}

// MARK: - DemoButton style
/// A reusable button style for demo purposes —
/// full width, colored background, slight fade on tap.
struct DemoButton: ButtonStyle {
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .cornerRadius(10)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}

#Preview {
    
    ContentView()
}
