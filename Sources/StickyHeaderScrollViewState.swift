import SwiftUI

public enum StickyHeaderScrollViewState: Equatable {
    case readingInitialHeight
    case scrolling(distance: CGFloat)
    case bouncing(distance: CGFloat)
    
    public var isReadingInitialHeight: Bool {
        switch self {
        case .readingInitialHeight:
            return true
        default:
            return false
        }
    }
    
    public var isScrolling: Bool {
        switch self {
        case .scrolling(_):
            return true
        default:
            return false
        }
    }
    
    public var isBouncing: Bool {
        switch self {
        case .bouncing(_):
            return true
        default:
            return false
        }
    }
}
