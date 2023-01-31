import SwiftUI

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

struct MyButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MyButtonView()
    }
}
