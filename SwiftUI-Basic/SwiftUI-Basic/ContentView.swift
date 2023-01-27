//
//  ContentView.swift
//  SwiftUI-Basic
//
//  Created by Sujin Jin on 2022/12/09.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello SwiftUI")
    }
}

struct ButtonView: View {
    var body: some View {
        Button {
            print("hello")
        } label: {
            HStack {
                Image(systemName: "folder")
                    .resizable()
                    .frame(width: 80, height: 60, alignment: .center)
                Text("Save File")
                    .foregroundColor(.brown)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
