//
//  Helpers.swift
//  Sheetify
//
//  Created by Iñaki Sigüenza on 20/04/25.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

#if canImport(UIKit)
/// Removes default sheet shadow via UIKit hack
struct RemoveSheetShadow: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        DispatchQueue.main.async {
            if let shadowView = view.dropShadowView {
                shadowView.layer.shadowColor = UIColor.clear.cgColor
            }
        }
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}

extension UIView {
    /// Recursively find the UIDropShadowView to remove its shadow
    var dropShadowView: UIView? {
        if let superview, String(describing: type(of: superview)) == "UIDropShadowView" {
            return superview
        }
        return superview?.dropShadowView
    }
}
#endif

/// Shape for rounded corners on specified edges
public struct RoundedCorner: Shape {
    public var radius: CGFloat
    public var corners: UIRectCorner

    public func path(in rect: CGRect) -> Path {
        #if canImport(UIKit)
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
        #else
        return Path(rect)
        #endif
    }
}
