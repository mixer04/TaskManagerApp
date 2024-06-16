//
//  StaticPurpleBackgroundView.swift
//  TaskManager
//
//  Created by Borys Bednarski on 16/06/2024.
//

import SwiftUI

struct StaticPurpleBackgroundView: View {
    var body: some View {
        ZStack {
            // Static purple background gradient
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 25/255, green: 25/255, blue: 112/255),
                Color(red: 75/255, green: 0/255, blue: 130/255)
            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            // Glass effect
            VisualEffectBlurView(blurStyle: .systemThinMaterialDark)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct StaticPurpleBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        StaticPurpleBackgroundView()
            .environment(\.colorScheme, .light)  // Preview in light mode
        StaticPurpleBackgroundView()
            .environment(\.colorScheme, .dark)  // Preview in dark mode
    }
}
