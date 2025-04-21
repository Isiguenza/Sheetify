//
//  TrayConfig.swift
//  Sheetify
//
//  Created by Iñaki Sigüenza on 20/04/25.
//

import SwiftUI

/// Configuration for the styled sheet
public struct TrayConfig {
    /// The stopping detent for the sheet (e.g., .fraction(0.5), .large)
    public var maxDetent: PresentationDetent
    /// Corner radius for the sheet background
    public var cornerRadius: CGFloat = 30
    /// Whether tapping outside should dismiss the sheet
    public var isInteractiveDismissDisabled: Bool = false
    /// Custom animation for sheet presentation duration
    public var appearanceAnimationDuration: Double = 0.1

    public init(
        maxDetent: PresentationDetent,
        cornerRadius: CGFloat = 30,
        isInteractiveDismissDisabled: Bool = false,
        appearanceAnimationDuration: Double = 0.1
    ) {
        self.maxDetent = maxDetent
        self.cornerRadius = cornerRadius
        self.isInteractiveDismissDisabled = isInteractiveDismissDisabled
        self.appearanceAnimationDuration = appearanceAnimationDuration
    }
}



