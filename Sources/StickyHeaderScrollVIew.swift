import SwiftUI

public struct StickyHeaderScrollView<Header: View, Content: View>: View {
    @Environment(\.sizeCategory) var sizeCategory
    
    public let showsIndicators: Bool
    public let header: (StickyHeaderScrollViewState) -> Header
    public let content: () -> Content
    
    public init(showsIndicators: Bool = true, @ViewBuilder header: @escaping (StickyHeaderScrollViewState) -> Header, @ViewBuilder content: @escaping () -> Content) {
        self.showsIndicators = showsIndicators
        self.header = header
        self.content = content
    }
    
    @State private var initialHeaderHeight: CGFloat?
    @State private var scrollDistance: CGFloat = 0
    
    public var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: self.showsIndicators) {
                self.content()
                    .frame(maxWidth: .infinity)
                    .trackingFrame(in: .named("scrollView")) { frame in
                        self.scrollDistance = (self.initialHeaderHeight ?? 0) - frame.minY
                    }
                    .padding(.top, self.initialHeaderHeight ?? 0)
            }
            .coordinateSpace(name: "scrollView")
            
            if let initialHeaderHeight = self.initialHeaderHeight {
                if self.scrollDistance >= 0 {
                    self.header(.scrolling(distance: self.scrollDistance))
                } else {
                    self.header(.bouncing(distance: -self.scrollDistance))
                        .frame(height: max(initialHeaderHeight - self.scrollDistance, initialHeaderHeight))
                }
            } else {
                self.header(.readingInitialHeight)
                    .getFrameOnce { frame in
                        self.initialHeaderHeight = frame.height
                    }
            }
        }
        .onChange(of: self.sizeCategory) { _ in
            self.initialHeaderHeight = nil
        }
    }
}

private extension View {
    func getFrameOnce(in coordinateSpace: CoordinateSpace = .global, _ onChange: @escaping (CGRect) -> Void) -> some View {
        self.background(GeometryReader { geometry in
            Color.clear
                .onAppear {
                    onChange(geometry.frame(in: coordinateSpace))
                }
        })
    }
    
    func trackingFrame(in coordinateSpace: CoordinateSpace = .global, _ onChange: @escaping (CGRect) -> Void) -> some View {
        self.background(GeometryReader { geometry in
            Color.clear
                .onChange(of: geometry.frame(in: coordinateSpace), perform: onChange)
        })
    }
}
