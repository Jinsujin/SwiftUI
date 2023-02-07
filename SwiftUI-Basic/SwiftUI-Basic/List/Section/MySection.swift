import SwiftUI

struct MySection: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Text("🧋")
                        Text("Bubble tea")
                    }
                    HStack {
                        Text("☕️")
                        Text("Coffee")
                    }
                } header: {
                    Text("fruit")
                } footer: {
                    Text("fruit footer")
                }
                
                Section {
                    HStack {
                        Text("🧁")
                        Text("Cupcake")
                    }
                    HStack {
                        Text("🍪")
                        Text("cookie")
                    }
                    HStack {
                        Text("🍦")
                        Text("ice cream")
                    }
                } header: {
                    Text("Dessert")
                } footer: {
                    Text("dessert footer")
                }
            }
            .navigationTitle("Caffee")
        }
    }
}

struct MySection_Previews: PreviewProvider {
    static var previews: some View {
        MySection()
    }
}
