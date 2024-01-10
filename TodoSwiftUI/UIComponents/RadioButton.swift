//
//  RadioButton.swift
//  TodoSwiftUI
//
//  Created by Marcelo Mogrovejo on 15/12/2023.
//

import SwiftUI

struct RadioButton: View {

    struct Constants {
        static let filledState: String = "largecircle.fill.circle"
        static let regularState: String = "circle"
        static let defaultColor: Color = .primary
        static let defaultSize: CGFloat = 20.0
    }

    @Binding var isSet: Bool

    var size: CGFloat? = Constants.defaultSize
    var color: Color? = Constants.defaultColor

    var body: some View {
        Button {
            print("Toggle \(isSet)")
            isSet.toggle()
            
        } label: {
            Image(systemName: self.isSet ? Constants.filledState : Constants.regularState)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: self.size, height: self.size)
        }
        // To avoid the whole row is selectable.
        .buttonStyle(PlainButtonStyle())
        .foregroundColor(color)
    }
}

#Preview {
    RadioButton(isSet: .constant(false))
}
