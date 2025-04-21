
//
//  View+Sheetify.swift
//  Sheetify
//
//  Created by Iñaki Sigüenza on 20/04/25.
//

import SwiftUI

/// Internal container managing a multi-step flow with automatic header and back functionality.
///
/// `Step` must conform to `Hashable & CaseIterable`. The container:
/// 1. Displays a header with a dynamic title based on the current step (uses `String(describing: currentStep).capitalized`).
/// 2. Shows a close/back button: tapping X goes to the previous step if available, otherwise dismisses the sheet.
/// 3. Renders arbitrary content provided by the user, bound to the `Binding<Step>` to navigate between steps.
public struct FlowContainer<Step: Hashable & CaseIterable, Content: View>: View {
    @Binding private var isPresented: Bool
    @State private var currentStep: Step
    private let steps: [Step]
    private let content: (Binding<Step>) -> Content

    /// Initialize the flow container.
    /// - Parameters:
    ///   - isPresented: Binding controlling sheet visibility.
    ///   - startStep: The initial step of the flow.
    ///   - content: Closure providing the view for the current step, receiving a `Binding<Step>`.
    public init(isPresented: Binding<Bool>, startStep: Step, @ViewBuilder content: @escaping (Binding<Step>) -> Content) {
        self._isPresented = isPresented
        self._currentStep = State(initialValue: startStep)
        self.steps = Array(Step.allCases)
        self.content = content
    }

    private var currentIndex: Int { steps.firstIndex(of: currentStep)! }
    private var previousStep: Step? { currentIndex > 0 ? steps[currentIndex - 1] : nil }

    public var body: some View {
        
        
        ZStack{
            VStack(spacing: 0) {
                // Header with dynamic title and back/close button
                HStack {
                    Text(String(describing: currentStep).capitalized)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    Button {
                        if let back = previousStep {
                            withAnimation { currentStep = back }
                        } else {
                            isPresented = false
                        }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundStyle(Color.gray, Color.primary.opacity(0.1))
                    }
                }
                .padding()
                
                // Content for current step
                content($currentStep)
                    .frame(maxWidth: .infinity)
            }
            .background(Color(UIColor.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: config.cornerRadius))
            .padding(.horizontal)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .background(RemoveSheetShadow())
        .presentationDetents([config.maxDetent])
        .sheetBackgroundStyle()
        .presentationDragIndicator(.hidden)
        .interactiveDismissDisabled(config.isInteractiveDismissDisabled)
        .transaction { transaction in
            if config.appearanceAnimationDuration != 0.1 {
                transaction.animation = .easeInOut(duration: config.appearanceAnimationDuration)
            }
        }
    }
}

public extension View {
    /// Conditionally apply corner radius and clear background on iOS 16.4+.
    @ViewBuilder
    func sheetBackgroundStyle() -> some View {
        if #available(iOS 16.4, macCatalyst 16.4, *) {
            self.presentationCornerRadius(0)
                .presentationBackground(.clear)
        } else {
            self
        }
    }
    
    /// Presents a styled sheet with optional header and custom content.
    func sheetify<Content: View>(
        _ isPresented: Binding<Bool>,
        title: String? = nil,
        config: TrayConfig = .init(maxDetent: .fraction(0.99)),
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.sheet(isPresented: isPresented) {
            ZStack(alignment: .bottom) {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if !config.isInteractiveDismissDisabled {
                            isPresented.wrappedValue = false
                        }
                    }
                VStack(spacing: 16) {
                    HStack {
                        if let title = title {
                            Text(title)
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        Spacer()
                        Button(action: { isPresented.wrappedValue = false }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundStyle(Color.gray, Color.primary.opacity(0.1))
                        }
                    }
                    .padding()
                    content()
                        .frame(maxWidth: .infinity)
                }
                .background(Color(UIColor.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: config.cornerRadius))
                .padding(.horizontal)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .background(RemoveSheetShadow())
            .presentationDetents([config.maxDetent])
            .sheetBackgroundStyle()
            .presentationDragIndicator(.hidden)
            .interactiveDismissDisabled(config.isInteractiveDismissDisabled)
            .transaction { transaction in
                if config.appearanceAnimationDuration != 0.1 {
                    transaction.animation = .easeInOut(duration: config.appearanceAnimationDuration)
                }
            }
        }
    }
    
    /// Presents a styled multi-step flow inside a sheet with automatic header and back button.
    ///
    /// - Note: `Step` must conform to `Hashable & CaseIterable`.
    /// - Parameters:
    ///   - isPresented: Binding controlling sheet visibility.
    ///   - startStep: The initial step to display.
    ///   - config: `TrayConfig` customizing sheet appearance.
    ///   - content: Closure providing content for the current step, given a `Binding<Step>`.
    func sheetifyFlow<Step: Hashable & CaseIterable, Content: View>(
        _ isPresented: Binding<Bool>,
        startStep: Step,
        config: TrayConfig = .init(maxDetent: .fraction(0.99)),
        @ViewBuilder content: @escaping (Binding<Step>) -> Content
    ) -> some View {
        self.sheet(isPresented: isPresented) {
            FlowContainer(isPresented: isPresented, startStep: startStep, content: content)
        }
    }
}

