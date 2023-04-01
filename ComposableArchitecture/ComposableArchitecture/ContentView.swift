import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var state: AppState
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: CounterView(state: state)) {
                    Text("Counter Demo")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Favorite Primes")
                }
            }
            .navigationTitle("State management")
        }
    }
}

private func ordinal(_ n: Int) -> String {
  let formatter = NumberFormatter()
  formatter.numberStyle = .ordinal
  return formatter.string(for: n) ?? ""
}


class AppState: ObservableObject {
    @Published var count = 0
}

struct CounterView: View {
    @ObservedObject var state: AppState
    
     var body: some View {
         
        VStack {
            HStack {
                Button {
                    self.state.count -= 1
                } label: {
                    Text("-")
                }
                Text("\(self.state.count)")
                Button {
                    self.state.count += 1
                } label: {
                    Text("+")
                }
            }
            
            Button(action: {}) {
                Text("is this prime?")
            }
            Button(action: {}) {
                Text("What is the \(ordinal(self.state.count)) prime?")
            }
            
        }
        .font(.title)
        .navigationTitle("Counter Demo")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(state: AppState())
    }
}
