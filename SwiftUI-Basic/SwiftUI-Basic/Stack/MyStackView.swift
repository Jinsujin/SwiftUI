import SwiftUI

struct MyStackView: View {
    var body: some View {
        HStackView()
    }
}


struct HStackView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text("Text 1")
                .bold()
                .cornerRadius(8)
                .padding()
                .background(.orange)
            Text("Text 2")
                .bold()
                .cornerRadius(8)
                .padding()
                .background(.orange)
            Text("Text 3")
                .bold()
                .cornerRadius(8)
                .padding()
                .background(.orange)
            Text("Text 4")
                .bold()
                .cornerRadius(8)
                .padding()
                .background(.orange)
        }
        .padding()
        .background(.gray)
    }
}

struct VStackView: View {
    var body: some View {
        // VStack 은 10개만 넣을 수 있음
        VStack(alignment: .center, spacing: 10) {
            Text("Text 1")
                .bold()
                .cornerRadius(8)
                .padding()
                .background(.orange)
            Text("Text 2")
                .bold()
                .cornerRadius(8)
                .padding()
                .background(.orange)
            Text("Text 3")
                .bold()
                .cornerRadius(8)
                .padding()
                .background(.orange)
        }
        .padding()
        .frame(width: 300, height: 200, alignment: .leading)
        .background(.gray)
    }
}




struct ZStackView: View {
    var body: some View {
        ZStack {
            Color.indigo
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?")
                .foregroundColor(.gray)
            Button {
                print("touched button!")
            } label: {
                Text("hit me")
                    .foregroundColor(.yellow)
                    .bold()
                    .font(.system(size: 40, weight: .heavy, design: .rounded))
                    .padding()
            }
            .background(.pink)
            .cornerRadius(20)

        }
    }
}



struct MyStackView_Previews: PreviewProvider {
    static var previews: some View {
        MyStackView()
    }
}
