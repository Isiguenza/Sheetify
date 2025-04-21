//
//  View+Sheetify.swift
//  Sheetify
//
//  Created by Iñaki Sigüenza on 20/04/25.
//

import SwiftUI

public extension View {
    /// Presents a styled tray sheet (Sheetify) with optional header and custom content.
    /// - Parameters:
    ///   - isPresented: Binding to control sheet visibility
    ///   - title: Optional title displayed in the header
    ///   - config: TrayConfig for visual and behavioral customization
    ///   - content: A view builder providing the sheet's main content
    /// - Returns: A view modified to present the styled sheet
    func sheetify<Content: View>(
        _ isPresented: Binding<Bool>,
        title: String? = nil,
        config: TrayConfig = .init(),
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.sheet(isPresented: isPresented, onDismiss: {
            config.onDismiss?()
        }) {
            ZStack(alignment: .bottom) {
                // Background overlay
                backgroundOverlay(style: config.backgroundStyle)
                    .onTapGesture {
                        if !config.isInteractiveDismissDisabled {
                            isPresented.wrappedValue = false
                        }
                    }

                // Sheet container with header and content
                VStack(spacing: 16) {
                    if let title = title {
                        SheetHeader(title: title) {
                            isPresented.wrappedValue = false
                        }
                    }
                    content()
                }
                .background(Color(UIColor.systemBackground))
                .clipShape(RoundedCorner(radius: config.cornerRadius, corners: .allCorners))
                .padding(.horizontal, 15)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .background(RemoveSheetShadow())
            .presentationDetents(config.detents)
            .presentationDragIndicator(config.showDragIndicator ? .visible : .hidden)
            .interactiveDismissDisabled(config.isInteractiveDismissDisabled)
            .onAppear {
                config.onAppear?()
            }
            .transaction { transaction in
                transaction.animation = config.animation
            }
        }
    }

    /// Generates the background overlay view based on the chosen style
    @ViewBuilder private func backgroundOverlay(style: TrayConfig.BackgroundStyle) -> some View {
        switch style {
        case .clear:
            Color.clear.edgesIgnoringSafeArea(.all)
        case .dim(let opacity):
            Color.black.opacity(opacity).edgesIgnoringSafeArea(.all)
        case .blur:
            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
                .edgesIgnoringSafeArea(.all)
        }
    }
}
