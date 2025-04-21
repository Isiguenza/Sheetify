import XCTest
import SwiftUI
@testable import Sheetify
import ViewInspector

// Conform custom views to Inspectable
extension SheetHeader: Inspectable {}
extension RoundedCorner: Inspectable {}

// MARK: - TrayConfig Tests
final class TrayConfigTests: XCTestCase {
    func testDefaultValues() {
        let config = TrayConfig()
        XCTAssertEqual(config.detents, [.fraction(0.5), .fraction(0.99)])
        XCTAssertEqual(config.cornerRadius, 30)
        XCTAssertFalse(config.isInteractiveDismissDisabled)
        XCTAssertEqual(config.backgroundStyle, .clear)
        XCTAssertFalse(config.showDragIndicator)
        XCTAssertEqual(String(describing: config.animation), String(describing: Animation.easeInOut(duration: 0.1)))
        XCTAssertNil(config.onAppear)
        XCTAssertNil(config.onDismiss)
    }

    func testCustomInitialization() {
        var appeared = false
        var dismissed = false
        let style = TrayConfig.BackgroundStyle.dim(opacity: 0.7)
        let animation = Animation.spring(response: 0.3, dampingFraction: 0.5)
        let config = TrayConfig(
            detents: [.medium, .large],
            cornerRadius: 12,
            isInteractiveDismissDisabled: true,
            backgroundStyle: style,
            showDragIndicator: true,
            animation: animation,
            onAppear: { appeared = true },
            onDismiss: { dismissed = true }
        )
        XCTAssertEqual(config.detents, [.medium, .large])
        XCTAssertEqual(config.cornerRadius, 12)
        XCTAssertTrue(config.isInteractiveDismissDisabled)
        XCTAssertEqual(config.backgroundStyle, style)
        XCTAssertTrue(config.showDragIndicator)
        XCTAssertEqual(String(describing: config.animation), String(describing: animation))
        config.onAppear?()
        config.onDismiss?()
        XCTAssertTrue(appeared)
        XCTAssertTrue(dismissed)
    }
}


// MARK: - Helpers Tests
final class HelpersTests: XCTestCase {
    func testRoundedCornerProducesPath() {
        let shape = RoundedCorner(radius: 10, corners: .allCorners)
        let path = shape.path(in: CGRect(x: 0, y: 0, width: 100, height: 50))
        XCTAssertFalse(path.isEmpty)
    }

    func testVisualEffectViewStoresEffect() {
        let blur = UIBlurEffect(style: .systemMaterial)
        let visual = VisualEffectView(effect: blur)
        let mirror = Mirror(reflecting: visual)
        let effectValue = mirror.children.first { $0.label == "effect" }?.value as? UIBlurEffect
        XCTAssertTrue(effectValue === blur)
    }

    func testRemoveSheetShadowExists() {
        let remove = RemoveSheetShadow()
        XCTAssertNotNil(remove)
    }
}
