import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Hello SwiftUI")
                .bold()
                .strikethrough()
            Text("Hello SwiftUI")
                .italic()
                .foregroundColor(.purple)
                .font(.system(size: 40))
            Text("Hello SwiftUI")
                .font(.custom("Gill Sans", size: 20))
                .bold()
                .foregroundColor(.indigo)
            Text("Hello SwiftUI")
                .underline(true, color: .red)
                .font(.system(size: 30))
            Text("Hello SwiftUI")
                .kerning(4)
        }
    }
}

struct MyTextView: View {
    var body: some View {
        Color.gray
            .ignoresSafeArea()
            .overlay {
                VStack {
                    Text("Hello SwiftUI")
                        .font(.custom("Jost", size: 20))
                    Text("Hello SwiftUI")
                        .font(.system(size: 60))
                    Text("Hello SwiftUI")
                        .underline(true, color: .orange)
                        .foregroundColor(.red)
                        .background(.gray)
                    Text("Hello SwiftUI")
                        .foregroundColor(.accentColor)
                        .bold()
                        .font(.system(size: 40, weight: .heavy, design: .rounded))
                    Text("Brevity is the soul of wit.")
                        .frame(width: 100)
                        .lineLimit(2)
                        .background(.red)
                        .font(.custom("Avenir Heavy", size: 16))
                }.background(.orange)
            }
            .onAppear {
                for family: String in UIFont.familyNames {
                        print(family)
                        for names : String in UIFont.fontNames(forFamilyName: family){
                            print("=== \(names)")
                        }
                    }
            }
    }
}

struct MyButtonView: View {
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
