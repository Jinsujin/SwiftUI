import SwiftUI


struct Fruit: Identifiable {
    var id = UUID()
    let name: String
    let emoji: String
}
        
/// 데이터를 반복해서 보여줘야할때 사용
struct ListView: View {
    
    @State private var multiSelection = Set<UUID>()
    
    var body: some View {
        
        let fruits: [Fruit] = [
            Fruit(name: "Apple", emoji: "🍏"),
            Fruit(name: "Strawberry", emoji: "🍓"),
            Fruit(name: "Grape", emoji: "🍇"),
            Fruit(name: "Banana", emoji: "🍌"),
            Fruit(name: "Lemon", emoji: "🍋"),
            Fruit(name: "Cherry", emoji: "🍒")
        ]
        
        NavigationView {
            List(fruits, selection: $multiSelection) { fruit in
                HStack {
                    Text(fruit.emoji)
                        .bold()
                        .frame(width: 30, height: 80, alignment: .trailing)
                    Text(fruit.name)
                        .bold()
                }
            }
            .navigationTitle("Fruit shop")
            .toolbar { EditButton() }
        }
        Text("\(multiSelection.count) selections")
    }
}

struct ListView2: View {
    var body: some View {
        // 값이 고유하다는 것을 보장해야 하기 때문에 id 를 사용
        let animals = ["lion", "tiger", "elephant", "giraffe"]
        List(animals, id: \.self) { name in
            Text(name)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
