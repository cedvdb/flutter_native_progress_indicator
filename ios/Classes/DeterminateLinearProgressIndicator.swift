import SwiftUI

struct DeterminateLinearProgressIndicator: View {
    var value: Float
    var trackColor: Color
    var progressColor: Color
    var thickness: Float
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height;
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(trackColor)
                    .frame(width: width, height: height)

                RoundedRectangle(cornerRadius: 12)
                    .fill(progressColor)
                    .frame(width: CGFloat(value) * width, height: height)
                    .onAppear()
                    .animation(.easeOut, value: value)
            }
        }.frame(height: CGFloat(thickness), alignment: .leading) 
    }
}
