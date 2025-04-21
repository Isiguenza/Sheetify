//
//  Helpers.swift
//  Sheetify
//
//  Created by Iñaki Sigüenza on 20/04/25.
//

import SwiftUI

/// Removes default sheet shadow via UIKit
fileprivate struct RemoveSheetShadow: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        DispatchQueue.main.async {
            if let shadow = view.dropShadowView {
                shadow.layer.shadowColor = UIColor.clear.cgColor
            }
        }
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}

/// Shape for rounded corners on specific edges
fileprivate struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension UIView {
    /// Recursively find the UIDropShadowView to remove its shadow
    fileprivate var dropShadowView: UIView? {
        if let superview = superview,
           String(describing: type(of: superview)) == "UIDropShadowView" {
            return superview
        }
        return superview?.dropShadowView
    }
}

/// UIKit wrapper for UIBlurEffect in SwiftUI
fileprivate struct VisualEffectView: UIViewRepresentable {
    let effect: UIVisualEffect?
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: effect)
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
