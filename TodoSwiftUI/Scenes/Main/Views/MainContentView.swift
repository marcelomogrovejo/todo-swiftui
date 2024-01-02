//
//  MainContentView.swift
//  TodoSwiftUI
//
//  Created by Marcelo Mogrovejo on 13/12/2023.
//

import SwiftUI

struct MainContentView: View {

    @State private var showList = false

    var body: some View {
        NavigationStack {
            VStack {
                AnimationView()
    //            Image(systemName: "globe")
    //                .resizable()
    //                .imageScale(.large)
    //                .foregroundStyle(.tint)
    //                .frame(width: 100, height: 100)

                Spacer()

                MainButtonView {
                    print("Tapped !!")

                    self.showList.toggle()
                }
                .sheet(isPresented: $showList) {
                    ListContentView()
                        .interactiveDismissDisabled(true)
                }
            }
            .navigationTitle("ToDo SwiftUI App")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(.NavBar.backgroundColor ?? .white), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    MainContentView()
}
