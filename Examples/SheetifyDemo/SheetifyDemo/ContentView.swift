// ContentViewSimple.swift
// SheetifyDemo
//
// This view demonstrates basic one–shot sheetify usage.

import SwiftUI
import Sheetify

struct ContentViewSimple: View {
    @State private var showDefault = false
    @State private var showCustom = false
    @State private var showAnimated = false

    var body: some View {
        VStack(spacing: 24) {
            Text("🔹 Simple Sheetify Examples")
                .font(.title2)
                .padding(.top)

            // 1. Default sheet
            Button("Show Default Sheet") {
                showDefault.toggle()
            }
            .buttonStyle(DemoButton(color: .blue))
            .sheetify($showDefault, title: "Default Sheet") {
                Text("This is a simple sheet with default settings.")
                    .padding()
            }

            // 2. Custom corner radius
            Button("Custom Corner Radius") {
                showCustom.toggle()
            }
            .buttonStyle(DemoButton(color: .green))
            .sheetify(
                $showCustom,
                title: "Rounded Corners",
                config: .init(
                    maxDetent: .fraction(0.6),
                    cornerRadius: 16
                )
            ) {
                Text("Sheet stops at 60% height and has 16pt corners.")
                    .padding()
            }

            // 3. Custom animation
            Button("Spring Animation") {
                showAnimated.toggle()
            }
            .buttonStyle(DemoButton(color: .orange))
            .sheetify(
                $showAnimated,
                title: "Springy Sheet",
                config: .init(
                    maxDetent: .fraction(0.8),
                    appearanceAnimationDuration: 0.0
                )
                
            ) {
                Text("This sheet enters with a spring animation!")
                    .padding()
            }

            Spacer()
        }
        .padding(.horizontal)
    }
}

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
    ContentViewSimple()
}
