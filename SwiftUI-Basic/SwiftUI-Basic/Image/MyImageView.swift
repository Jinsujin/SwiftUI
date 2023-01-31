import SwiftUI

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

struct MyImageView_Previews: PreviewProvider {
    static var previews: some View {
        MyImageView()
    }
}
