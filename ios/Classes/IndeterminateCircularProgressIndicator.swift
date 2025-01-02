import SwiftUI

struct IndeterminateCircularProgressIndicator: View {
    var trackColor: Color
    var progressColor: Color
    var strokeWidth: Float
    
    @State private var start: Float = 0.4
    @State private var end: Float = 0.6
    @State private var rotationAngle: Double = 0
    @State private var forward = true

    var body: some View {
        ZStack {
            // track
            Circle()
                .stroke(lineWidth: CGFloat(strokeWidth))
                .foregroundColor(trackColor)
            
            // progress
            Circle()
                .trim(from: CGFloat(start), to: CGFloat(end))
                .stroke(style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
                .foregroundColor(progressColor)
                .rotationEffect(Angle(degrees: -90))
        }.rotationEffect(Angle(degrees: rotationAngle))
        .onAppear { startAnimating() }
    }
    

    private func startAnimating() {
        // Animate the rotation to give the indeterminate effect
        withAnimation(.linear(duration: 0.8).repeatForever(autoreverses: false)) {
            rotationAngle = 360
        }
        
        // Animate the trim's progress and the rotation
        let forwardAnimation = Animation.timingCurve(0.35, 0.05, 0.65, 0.95, duration: 1.333)
        let reverseAnimation = Animation.easeOut(duration: 1.333)

        func runAnimation() {
            withAnimation(forward ? forwardAnimation : reverseAnimation) {
                if forward {
                    start = 0.2
                    end = 1
                } else {
                    start = 0.45
                    end = 0.5
                }
            }
        }

        func toggleDirection() {
            forward.toggle()
        }

        // Recursive timer-based approach
        Timer.scheduledTimer(withTimeInterval: 1.333, repeats: true) { timer in
            runAnimation()
            toggleDirection()
        }
    }

}

