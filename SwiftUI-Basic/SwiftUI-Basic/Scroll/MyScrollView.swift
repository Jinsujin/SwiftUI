import SwiftUI


struct MyScrollView: View {
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<100) {
                        Text("menu \($0)")
                            .bold()
                            .frame(width: 100, height: 50)
                            .background(.mint)
                    }
                }
                .background(.gray)
                .padding()
            }
            Text("Contents")
                .background(.orange)
                .padding()
        }
    }
}

struct ScrollVerticalView: View {
    var body: some View {
        // Note: ScrollView 의 기본 스크롤 방향은 세로
        ScrollView {
            Text("1")
                .bold()
                .frame(width: 300, height: 500)
                .background(.red)
            Text("2")
                .bold()
                .frame(width: 300, height: 500)
                .background(.orange)
            Text("3")
                .bold()
                .frame(width: 300, height: 500)
                .background(.blue)
        }.background(.gray)
    }
}


struct ScrollHorizontalView: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Text("1")
                    .bold()
                    .frame(width: 300, height: 500)
                    .background(.red)
                Text("2")
                    .bold()
                    .frame(width: 300, height: 500)
                    .background(.orange)
                Text("3")
                    .bold()
                    .frame(width: 300, height: 500)
                    .background(.blue)
            }
        }.background(.gray)
    }
}

struct MyScrollView_Previews: PreviewProvider {
    static var previews: some View {
        MyScrollView()
    }
}
