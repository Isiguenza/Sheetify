//
//  TrayConfig.swift
//  Sheetify
//
//  Created by Iñaki Sigüenza on 20/04/25.
//

import SwiftUI

/// Configuration for the styled sheet
public struct TrayConfig {
    /// Array of allowed detents for the sheet (e.g., .medium, .large)
    public var detents: [PresentationDetent] = [.fraction(0.5), .fraction(0.99)]
    /// Corner radius for the sheet background
    public var cornerRadius: CGFloat = 30
    /// Whether tapping outside should dismiss the sheet
    public var isInteractiveDismissDisabled: Bool = false
    /// Style for the background overlay (clear, dim, blur)
    public var backgroundStyle: BackgroundStyle = .clear
    /// Whether to show the built-in drag indicator
    public var showDragIndicator: Bool = false
    /// Custom animation for sheet presentation
    public var animation: Animation = .easeInOut(duration: 0.1)
    /// Callback invoked when the sheet appears
    public var onAppear: (() -> Void)? = nil
    /// Callback invoked when the sheet is dismissed
    public var onDismiss: (() -> Void)? = nil

    /// Background overlay styles
    public enum BackgroundStyle: Equatable {
        /// No overlay
        case clear
        /// Semi-transparent dimmed overlay
        case dim(opacity: Double)
        /// Blur effect overlay
        case blur(radius: CGFloat)
    }

    /// Initialize a TrayConfig
    /// - Parameters:
    ///   - detents: Allowed sheet detents
    ///   - cornerRadius: Corner radius for background
    ///   - isInteractiveDismissDisabled: Disable outside tap to dismiss
    ///   - backgroundStyle: Overlay style
    ///   - showDragIndicator: Show drag indicator bar
    ///   - animation: Animation for appearance
    ///   - onAppear: Called on appear
    ///   - onDismiss: Called on dismiss
    public init(
        detents: [PresentationDetent] = [.fraction(0.5), .fraction(0.99)],
        cornerRadius: CGFloat = 30,
        isInteractiveDismissDisabled: Bool = false,
        backgroundStyle: BackgroundStyle = .clear,
        showDragIndicator: Bool = false,
        animation: Animation = .easeInOut(duration: 0.1),
        onAppear: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil
    ) {
        self.detents = detents
        self.cornerRadius = cornerRadius
        self.isInteractiveDismissDisabled = isInteractiveDismissDisabled
        self.backgroundStyle = backgroundStyle
        self.showDragIndicator = showDragIndicator
        self.animation = animation
        self.onAppear = onAppear
        self.onDismiss = onDismiss
    }
}
