import SwiftUI

public struct StickyHeaderMetric {
    public let initial: CGFloat
    public let scrolling: (distance: CGFloat, value: CGFloat)
    public let bouncing: (distance: CGFloat, value: CGFloat)
    
    public init(initial: CGFloat, scrolling: (distance: CGFloat, value: CGFloat), bouncing: (distance: CGFloat, value: CGFloat)) {
        self.initial = initial
        self.scrolling = scrolling
        self.bouncing = bouncing
    }
    
    public func value(for state: StickyHeaderScrollViewState) -> CGFloat {
        switch state {
        case .readingInitialHeight:
            return self.initial
        case .scrolling(let distance):
            return distance.scaled(from: (0, self.scrolling.distance), clampingTo: (self.initial, self.scrolling.value))
        case .bouncing(let distance):
            return distance.scaled(from: (0, self.bouncing.distance), clampingTo: (self.initial, self.bouncing.value))
        }
    }
}

public struct StickyHeaderFontMetric {
    public let metric: StickyHeaderMetric
    
    public init(scaling textStyle: UIFont.TextStyle, scrollDistance: CGFloat = 48) {
        let initialFontSize = UIFont.preferredFont(forTextStyle: textStyle).pointSize

        self.metric = StickyHeaderMetric(
            initial: initialFontSize,
            scrolling: (distance: scrollDistance, value: initialFontSize / 1.2),
            bouncing: (distance: scrollDistance, value: initialFontSize * 1.2)
        )
    }
    
    public init(initial: UIFont.TextStyle, scrolling: UIFont.TextStyle, scrollDistance: CGFloat = 48) {
        let initialFontSize = UIFont.preferredFont(forTextStyle: initial).pointSize
        let scrollingFontSize = UIFont.preferredFont(forTextStyle: scrolling).pointSize

        self.metric = StickyHeaderMetric(
            initial: initialFontSize,
            scrolling: (distance: scrollDistance, value: scrollingFontSize),
            bouncing: (distance: scrollDistance, value: initialFontSize * 1.2)
        )
    }
    
    public func fontSize(for state: StickyHeaderScrollViewState) -> CGFloat {
        self.metric.value(for: state)
    }
    
    public func font(_ name: String, for state: StickyHeaderScrollViewState) -> Font {
        Font.custom(name, fixedSize: self.fontSize(for: state))
    }
    
    public func systemFont(for state: StickyHeaderScrollViewState) -> Font {
        Font.system(size: self.fontSize(for: state))
    }
}
