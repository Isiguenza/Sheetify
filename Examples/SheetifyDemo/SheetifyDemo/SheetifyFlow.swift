// ContentViewFlow.swift
// SheetifyDemo
//
// Demonstrates the new automatic sheetifyFlow with dynamic header, back button, and shrink‑wrap content.

import SwiftUI
import Sheetify

/// Tres pasos genéricos para la demo
enum DemoStep: CaseIterable, Hashable {
    case step1, step2, step3
}

struct ContentViewFlow: View {
    @State private var showFlow = false
    @State private var selectedColor: Color = .blue  // Color elegido en step2

    var body: some View {
        VStack(spacing: 24) {
            Text("🔄 Automatic Flow Sheet")
                .font(.title2)
                .padding(.top)

            Button("Start Flow") {
                showFlow.toggle()
            }
            .buttonStyle(DemoButton(color: .purple))
            // Usamos sheetifyFlow sin detents; FlowContainer maneja header y back
            .sheetifyFlow($showFlow, startStep: DemoStep.step1) { step in
                VStack(spacing: 20) {
                    // Contenido dinámico para cada paso
                    switch step.wrappedValue {
                    case .step1:
                        Text("Welcome to Step 1!")
                            .padding(.vertical, 10)
                        Button("Next →") {
                            withAnimation { step.wrappedValue = .step2 }
                        }
                        .buttonStyle(DemoButton(color: .blue))

                    case .step2:
                        VStack(spacing: 12) {
                            Text("Choose a color:")
                            HStack(spacing: 16) {
                                ColorCircle(color: .red) {
                                    selectedColor = .red
                                    withAnimation { step.wrappedValue = .step3 }
                                }
                                ColorCircle(color: .green) {
                                    selectedColor = .green
                                    withAnimation { step.wrappedValue = .step3 }
                                }
                                ColorCircle(color: .orange) {
                                    selectedColor = .orange
                                    withAnimation { step.wrappedValue = .step3 }
                                }
                            }
                        }

                    case .step3:
                        VStack(spacing: 16) {
                            Text("You picked:")
                            Circle()
                                .fill(selectedColor)
                                .frame(width: 60, height: 60)
                                .shadow(radius: 4)
                            Button("Finish") {
                                withAnimation { showFlow = false }
                            }
                            .buttonStyle(DemoButton(color: selectedColor))
                        }
                    }
                }
                .padding()
                // Transición y animación de resorte al cambiar de paso
                .transition(.opacity.combined(with: .slide))
                .animation(.spring(response: 0.5, dampingFraction: 0.6), value: step.wrappedValue)
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - Reusable UI Components

/// Botón circular de color para selección
struct ColorCircle: View {
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Circle()
                .fill(color)
                .frame(width: 50, height: 50)
                .shadow(radius: 2)
        }
    }
}

#Preview {
    ContentViewFlow()
}
