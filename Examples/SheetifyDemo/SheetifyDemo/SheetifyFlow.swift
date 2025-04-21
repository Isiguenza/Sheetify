// ContentViewFlow.swift
// SheetifyDemo
//
// Demonstrates the new automatic sheetifyFlow with dynamic header, back button,
// and shrink‑wrap content. Each step adjusts its own size and transitions smoothly.

import SwiftUI
import Sheetify

/// Enum defining the distinct steps of the flow.
/// Conforms to CaseIterable so FlowContainer can automatically determine step order.
enum DemoStep: CaseIterable, Hashable {
    case step1, step2, step3
}

struct ContentViewFlow: View {
    /// Controls whether the sheet is currently presented.
    @State private var showFlow = false
    /// Holds the color selected in step 2, used in step 3 for display and button styling.
    @State private var selectedColor: Color = .blue

    var body: some View {
        VStack(spacing: 24) {
            // MARK: Header for the demo view
            Text("🔄 Automatic Flow Sheet")
                .font(.title2)
                .padding(.top)

            // Button to open the multi‑step flow sheet
            Button("Start Flow") {
                showFlow.toggle()  // Toggle presentation state
            }
            .buttonStyle(DemoButton(color: .purple))
            
            // Attach the custom sheetifyFlow modifier
            // It presents a sheet that adapts its height to content and
            // provides its own header/back button via FlowContainer.
            .sheetifyFlow($showFlow, startStep: DemoStep.step1) { step in
                VStack(spacing: 20) {
                    // Switch on the current step to determine which UI to show
                    switch step.wrappedValue {
                    case .step1:
                        // Step 1: Simple welcome message and Next button
                        Text("Welcome to Step 1!")
                            .padding(.vertical, 10)
                        Button("Next →") {
                            // Advance to step2 with default animation
                            step.wrappedValue = .step2
                        }
                        .buttonStyle(DemoButton(color: .blue))

                    case .step2:
                        // Step 2: Let the user select a color
                        VStack(spacing: 12) {
                            Text("Choose a color:")
                            HStack(spacing: 16) {
                                // Three ColorCircle buttons
                                ColorCircle(color: .red) {
                                    selectedColor = .red          // Store selection
                                    step.wrappedValue = .step3   // Advance to step3
                                }
                                ColorCircle(color: .green) {
                                    selectedColor = .green
                                    step.wrappedValue = .step3
                                }
                                ColorCircle(color: .orange) {
                                    selectedColor = .orange
                                    step.wrappedValue = .step3
                                }
                            }
                        }

                    case .step3:
                        // Step 3: Display the selected color and a Finish button
                        VStack(spacing: 16) {
                            Text("You picked:")
                            Circle()
                                .fill(selectedColor)  // Show chosen color
                                .frame(width: 60, height: 60)
                                .shadow(radius: 4)
                            Button("Finish") {
                                showFlow = false    // Dismiss sheet
                            }
                            .buttonStyle(DemoButton(color: selectedColor))
                        }
                    }
                }
                .padding()
                
                // Apply a combined fade-and-slide transition for each step
                .transition(
                    .opacity
                        .combined(with: .slide)
                )
                // Use a spring animation on step changes for a natural bounce
                .animation(
                    .spring(response: 0.5, dampingFraction: 0.6),
                    value: step.wrappedValue
                )
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - Reusable UI Components

/// Circular button displaying a solid color.
/// Calls the provided action when tapped.
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
