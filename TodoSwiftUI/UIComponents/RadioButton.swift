//
//  RadioButton.swift
//  TodoSwiftUI
//
//  Created by Marcelo Mogrovejo on 15/12/2023.
//

import SwiftUI

struct RadioButton: View {

//    @Environment(\.colorScheme) var colorScheme

//    let id: String
//    let callback: (String)->()
//    let selectedID : String
    let size: CGFloat
    let color: Color
//    let textSize: CGFloat
//
    init(
//         _ id: String,
//         callback: @escaping (String) -> (),
//         selectedID: String,
         size: CGFloat = 20,
         color: Color = Color.primary,
//         textSize: CGFloat = 14
         value: Binding<Bool> = .constant(false)
        ) {
//        self.id = id
        self.size = size
        self.color = color
//        self.textSize = textSize
//        self.selectedID = selectedID
//        self.callback = callback
        self._value = value
    }

    @Binding var value: Bool

    var body: some View {
//        Button(action:{
//            self.callback(self.id)
//        }) {
//            HStack(alignment: .center, spacing: 10) {
//                Image(systemName: self.selectedID == self.id ? "largecircle.fill.circle" : "circle")
//                    .renderingMode(.original)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: self.size, height: self.size)
//                    .modifier(ColorInvert())
//                Text(id)
//                    .font(Font.system(size: textSize))
//            }
//            .foregroundColor(self.color)
//        }
//        .foregroundColor(self.color)

        Button(action: {
            value.toggle()
        }, label: {
            Image(systemName: self.value ? "largecircle.fill.circle" : "circle")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: self.size, height: self.size)
        })
        .foregroundColor(color)
    }
}

#Preview {
//    RadioButton(UUID().uuidString, callback: { string in
//        print(string)
//    }, selectedID: "selected-id")
    RadioButton(size: 20, value: .constant(false))
}
