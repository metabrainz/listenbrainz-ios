

// Listen-brainz icons



import SwiftUI


struct LBIcon1: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.03935*width, y: 0.00417*height))
        path.addLine(to: CGPoint(x: 0.98379*width, y: 0.25208*height))
        path.addLine(to: CGPoint(x: 0.98379*width, y: 0.74792*height))
        path.addLine(to: CGPoint(x: 0.03935*width, y: 0.99583*height))
        path.addLine(to: CGPoint(x: 0.03935*width, y: 0.00417*height))
        path.closeSubpath()
        return path
    }
}

struct LBIcon2: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.96065*width, y: 0.00417*height))
        path.addLine(to: CGPoint(x: 0.0162*width, y: 0.25208*height))
        path.addLine(to: CGPoint(x: 0.0162*width, y: 0.74792*height))
        path.addLine(to: CGPoint(x: 0.96065*width, y: 0.99583*height))
        path.addLine(to: CGPoint(x: 0.96065*width, y: 0.00417*height))
        path.closeSubpath()
        return path
    }
}
