//
//  LinearProgressIndicator.swift
//  Pods
//
//  Created by Cedric Vanden bosch on 03/01/2025.
//
import SwiftUI

struct LinearProgressIndicator: View {
    var params: [String: Any]

    private var height: CGFloat {
        CGFloat((params["height"] as? NSNumber)?.floatValue ?? 4)
    }

    private var value: Float? {
        (params["value"] as? NSNumber)?.floatValue
    }

    private var trackColor: Color {
        guard let trackColorDictionary = params["trackColor"] as? [String: Double],
              let red = trackColorDictionary["r"],
              let green = trackColorDictionary["g"],
              let blue = trackColorDictionary["b"],
              let opacity = trackColorDictionary["a"] else {
            return .gray // Default track color
        }
        return Color(red: red, green: green, blue: blue, opacity: opacity)
    }

    private var progressColor: Color {
        guard let progressColorDictionary = params["progressColor"] as? [String: Double],
              let red = progressColorDictionary["r"],
              let green = progressColorDictionary["g"],
              let blue = progressColorDictionary["b"],
              let opacity = progressColorDictionary["a"] else {
            return .blue // Default progress color
        }
        return Color(red: red, green: green, blue: blue, opacity: opacity)
    }

    var body: some View {
        Group {
            if let value = value {
                DeterminateLinearProgressIndicator(
                    value: value,
                    trackColor: trackColor,
                    progressColor: progressColor,
                    height: Float(height)
                )
            } else {
                IndeterminateLinearProgressIndicator(
                    trackColor: trackColor,
                    progressColor: progressColor,
                    height: Float(height)
                )
            }
        }
    }
}

struct IndeterminateLinearProgressIndicator: View {
    var trackColor: Color
    var progressColor: Color
    var height: Float
    
    @State private var width: Float = 20
    @State private var offset: Float = -20

    var body: some View {
        GeometryReader { geometry in
            let frameWidth = geometry.size.width

            ZStack(alignment: .leading) {
                // Background track
                RoundedRectangle(cornerRadius: 12)
                    .fill(trackColor)
                    .frame(width: frameWidth, height: CGFloat(height))

                // Moving progress
                RoundedRectangle(cornerRadius: 12)
                    .fill(progressColor)
                    .frame(width: CGFloat(width), height: CGFloat(height))
                    .offset(x: CGFloat(offset))
                    .onAppear { startAnimating(frameWidth: Float(frameWidth)) }
            }
        }
        .frame(height: CGFloat(height), alignment: .leading)
        .clipped()
    }
    
    private func startAnimating(frameWidth: Float) {
        withAnimation(.timingCurve(0.42, 0, 0.58, 1, duration: 1.337).repeatForever(autoreverses: false)) {
            width = 1.4 * frameWidth
            offset = frameWidth
        }
    }
}

struct DeterminateLinearProgressIndicator: View {
    var value: Float
    var trackColor: Color
    var progressColor: Color
    var height: Float

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width

            ZStack(alignment: .leading) {
                // Background track
                RoundedRectangle(cornerRadius: 12)
                    .fill(trackColor)
                    .frame(width: width, height: CGFloat(height))

                // Progress bar
                RoundedRectangle(cornerRadius: 12)
                    .fill(progressColor)
                    .frame(width: CGFloat(value) * width, height: CGFloat(height))
                    .animation(.easeOut, value: value)
            }
        }
        .frame(height: CGFloat(height), alignment: .leading)
    }
}
