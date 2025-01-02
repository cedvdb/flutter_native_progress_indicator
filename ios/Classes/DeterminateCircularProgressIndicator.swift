import SwiftUI

struct DeterminateCircularProgressIndicator: View {
    
    var value: Float
    var trackColor: Color
    var progressColor: Color
    var strokeWidth: Float
    
    var body: some View {
        ZStack {
            // track
            Circle()
                .stroke(lineWidth: CGFloat(strokeWidth))
                .foregroundColor(trackColor)
            
            // progress
            Circle()
                .trim(from: CGFloat(0), to: CGFloat(value))
                .stroke(style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
                .foregroundColor(progressColor)
                .rotationEffect(Angle(degrees: -90))
                .onAppear()
                .animation(.easeOut, value: value)
            
        }
    }
}


