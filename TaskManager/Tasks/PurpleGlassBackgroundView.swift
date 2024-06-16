//
//  PurpleGlassBackgroundView.swift
//  TaskManager
//
//  Created by Borys Bednarski on 16/06/2024.
//

import SwiftUI

struct PurpleGlassBackgroundView: View {
    var isCompleted: Bool
    
    var body: some View {
        ZStack {
            // Background gradient that changes color based on completion status
            LinearGradient(gradient: Gradient(colors: [
                Color.purple.opacity(0),
                isCompleted ? Color.green.opacity(0.7) : Color.red.opacity(0.7)
            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            .animation(.easeInOut(duration: 0.5), value: isCompleted)
            
            // Glass effect
            VisualEffectBlur(blurStyle: .systemUltraThinMaterial)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

// Blur effect view
struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: blurStyle)
    }
}

struct PurpleGlassBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PurpleGlassBackgroundView(isCompleted: false)
                .environment(\.colorScheme, .light)  // Preview in light mode
            PurpleGlassBackgroundView(isCompleted: true)
                .environment(\.colorScheme, .dark)  // Preview in dark mode
        }
    }
}
