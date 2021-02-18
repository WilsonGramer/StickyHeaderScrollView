import Foundation

internal extension FloatingPoint {
    func scaled(from: (min: Self, max: Self), to: (min: Self, max: Self)) -> Self {
        (self - from.min) * (to.max - to.min) / (from.max - from.min) + to.min
    }
    
    func scaled(from: (min: Self, max: Self), clampingTo to: (min: Self, max: Self)) -> Self {
        let (clampMin, clampMax) = to.min <= to.max ? (to.min, to.max) : (to.max, to.min)
        
        return min(max(self.scaled(from: from, to: to), clampMin), clampMax)
    }
}
