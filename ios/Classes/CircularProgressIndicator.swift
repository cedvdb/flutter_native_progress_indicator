//
//  CircularProgressIndicator.swift
//  Pods
//
//  Created by Cedric Vanden bosch on 03/01/2025.
//
import SwiftUI

struct CircularProgressIndicator: View {
    var params: [String: Any]

    private var trackColor: Color {
        guard let trackColorDictionary = params["trackColor"] as? [String: Double],
              let red = trackColorDictionary["r"],
              let green = trackColorDictionary["g"],
              let blue = trackColorDictionary["b"],
              let opacity = trackColorDictionary["a"] else {
            return .gray // Default color
        }
        return Color(red: red, green: green, blue: blue, opacity: opacity)
    }

    private var progressColor: Color {
        guard let progressColorDictionary = params["progressColor"] as? [String: Double],
              let red = progressColorDictionary["r"],
              let green = progressColorDictionary["g"],
              let blue = progressColorDictionary["b"],
              let opacity = progressColorDictionary["a"] else {
            return .blue // Default color
        }
        return Color(red: red, green: green, blue: blue, opacity: opacity)
    }

    private var strokeWidth: CGFloat {
        CGFloat((params["strokeWidth"] as? NSNumber)?.floatValue ?? 4)
    }

    private var value: CGFloat? {
        guard let floatValue = (params["value"] as? NSNumber)?.floatValue else { return nil }
        return CGFloat(floatValue)
    }

    var body: some View {
        Group {
            if let value = value {
                DeterminateCircularProgressIndicator(
                    value: Float(value),
                    trackColor: trackColor,
                    progressColor: progressColor,
                    strokeWidth: Float(strokeWidth)
                )
            } else {
                IndeterminateCircularProgressIndicator(
                    trackColor: trackColor,
                    progressColor: progressColor,
                    strokeWidth: Float(strokeWidth)
                )
            }
        }
    }
}

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
        Timer.scheduledTimer(withTimeInterval: 1.333, repeats: true) { _ in
            runAnimation()
            toggleDirection()
        }
    }
}

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
                .animation(.easeOut, value: value)
        }
    }
}
