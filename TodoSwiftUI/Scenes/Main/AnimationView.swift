//
//  AnimationView.swift
//  TodoSwiftUI
//
//  Created by Marcelo Mogrovejo on 14/12/2023.
//

import SwiftUI
import PSSplash

struct AnimationView: UIViewRepresentable {

    private let animationName = "ani-todo-check"

    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }

    func makeUIView(context: Context) -> some UIView {
        let splashView = PSSplashView()
        splashView.animationName = animationName
        splashView.loopMode = .playOnce
        return splashView
    }
}
