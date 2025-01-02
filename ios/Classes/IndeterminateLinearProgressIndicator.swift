
import SwiftUI

struct IndeterminateLinearProgressIndicator: View {
    var trackColor: Color
    var progressColor: Color
    var height: Float
    
    @State var width: Float = 20
    @State var offset: Float = -20
    
    var body: some View {
        GeometryReader { geometry in
            let frameWidth = geometry.size.width
            let frameHeight = geometry.size.height;
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(trackColor)
                    .frame(width: frameWidth, height: frameHeight)

                RoundedRectangle(cornerRadius: 12)
                    .fill(progressColor)
                    .frame(width: CGFloat(width), height: frameHeight)
                    .offset(x: CGFloat(offset))
                    .onAppear { startAnimating(frameWidth: Float(frameWidth)) }
            }
        }.frame(height: CGFloat(height), alignment: .leading).clipped()
        
    }
    
    private func startAnimating(frameWidth: Float) {
        // Animate the trim's progress and the rotation
        withAnimation(.timingCurve(0.42, 0, 0.58, 1, duration: 1.337).repeatForever(autoreverses: false)) {
            width = 1.4 * frameWidth
            offset = frameWidth
        }
        
    }

}
