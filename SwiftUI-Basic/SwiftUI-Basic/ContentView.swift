import SwiftUI

struct ContentView: View {
    var body: some View {
        MyImageView()
    }
}



struct MyImageView: View {
    var body: some View {
        VStack(spacing: 70) {
            Image("taco")
                .resizable() // 큰 이미지를 frame 에 맞추기 위해 사용
                .aspectRatio(contentMode: .fill) // frame에 맞추면 이미지 비율이 맞지 않을때 사용
                .frame(width: 200, height: 200)
                .clipped() // 이미지를 frame에 맞춰서 자를 수 있음
                .background(.orange)
                .border(.brown, width: 5)
            // fit: 이미지 비율 유지
            // fill: frame 을 꽉채운다(이미지 비율이 맞지않다면, frame을 튀어나옴)
            
            Image(systemName: "heart.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.pink)
                .frame(width: 100, height: 100)
            
//            Image(systemName: "heart.fill")
//                .resizable()
//                .scaledToFill()
//                .frame(width: 100, height: 200, alignment: .center)
//                .clipped()
            
            // .aspectRatio(contentMode: .fill) 과 같은 효과
            // .scaledToFit() // .aspectRatio(contentMode: .fit) 과 같은 효과
            
            Image("skype_alien")
                .frame(width: 300, height: 300, alignment: .top)
                .background(.yellow)
                .border(.black, width: 2)
        }
    }
}

struct MyTextView2: View {
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
