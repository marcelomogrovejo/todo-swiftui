//
//  MainButtonView.swift
//  TodoSwiftUI
//
//  Created by Marcelo Mogrovejo on 15/12/2023.
//

import SwiftUI

struct MainButtonView: View {

    // MARK: - Private properties

    private struct Constants {
        static let buttonInsets = UIEdgeInsets(top: 0.0, left: 30.0, bottom: 30.0, right: -30.0)
        static let buttonHeight: CGFloat = 40.0
        static let buttonCorner: CGFloat = 20.0
    }

    // MARK: - Public properties

    var buttonAction: (() -> ())?

    // MARK: - View

    var body: some View {

        Button {
            guard let buttonAction = buttonAction else { return }
            buttonAction()
        } label: {
            Text("Todo List")
                .frame(width: UIScreen.main.bounds.width - (Constants.buttonInsets.left * 2), height: Constants.buttonHeight)
                .overlay(RoundedRectangle(cornerRadius: Constants.buttonCorner)
                    .stroke(Color.white, lineWidth: 0)
                )
                .background(Color(.Button.backgroundColor ?? .systemGray))
                .foregroundColor(Color(.Button.foregroundColor ?? .systemGray))
        }
        .buttonStyle(.borderless)
        .cornerRadius(Constants.buttonCorner)
        .controlSize(.regular)
        .padding([.leading, .trailing], Constants.buttonInsets.left)
        .padding(.bottom, Constants.buttonInsets.bottom)
    }
}

#Preview {
    MainButtonView()
}
