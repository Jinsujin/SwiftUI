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
    @Published var favoritePrimes: [Int] = []
}

struct CounterView: View {
    @ObservedObject var state: AppState
    @State var isPrimeModalShown: Bool = false
    
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
            
            Button(action: { self.isPrimeModalShown = true }) {
                Text("is this prime?")
            }
            Button(action: {}) {
                Text("What is the \(ordinal(self.state.count)) prime?")
            }
        }
        .font(.title)
        .navigationTitle("Counter Demo")
        .sheet(isPresented: self.$isPrimeModalShown) {
            IsPrimeModalView(state: self.state)
        }
    }
}

private func isPrime (_ p: Int) -> Bool {
  if p <= 1 { return false }
  if p <= 3 { return true }
  for i in 2...Int(sqrtf(Float(p))) {
    if p % i == 0 { return false }
  }
  return true
}

struct IsPrimeModalView: View {
    @ObservedObject var state: AppState
    
    var body: some View {
        VStack {
            if isPrime(state.count) {
                Text("\(state.count) is Prime!")
                if state.favoritePrimes.contains(self.state.count) {
                    Button {
                        state.favoritePrimes
                        .removeAll(where: { $0 == self.state.count })
                    } label: {
                        Text("Remove favorite primes")
                    }
                } else {
                    Button {
                        state.favoritePrimes
                        .append(self.state.count)
                    } label: {
                        Text("Save favorite primes")
                    }
                }
            } else {
                Text("\(state.count) is Not Prime....")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(state: AppState())
    }
}
