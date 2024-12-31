import SwiftUI

struct DeterminateCircularProgressIndicator: View {
    
    var value: Float
    var trackColor: Color
    var progressColor: Color
    var thickness: Float
    
    var body: some View {
        ZStack {
            // track
            Circle()
                .stroke(lineWidth: CGFloat(thickness))
                .foregroundColor(trackColor)
            
            // progress
            Circle()
                .trim(from: CGFloat(0), to: CGFloat(value))
                .stroke(style: StrokeStyle(lineWidth: CGFloat(thickness), lineCap: .round))
                .foregroundColor(progressColor)
                .rotationEffect(Angle(degrees: -90))
                .onAppear()
                .animation(.easeOut, value: value)
            
        }
    }
}


