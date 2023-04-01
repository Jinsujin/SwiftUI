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
                NavigationLink(destination: FavoritePrimesView(state: self.$state.favoritePrimesState)) {
                    Text("Favorite primes")
                }
            }
            .navigationTitle("State management")
            .toolbar {
                ToolbarItem {
                    Button {
                        nthPrime(1_000_000) { p in // p == Int?
                            print(p)
                        }
                    } label: {
                        Text("Prime Request")
                    }
                }
            }
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
    @Published var loggedInUser: User? = nil
    @Published var activityFeed: [Activity] = []
    
    struct Activity {
        let timestamp: Date
        let type: ActivityType
        
        enum ActivityType {
            case addedFavoritePrime(Int)
            case removedFavoritePrime(Int)
        }
    }
    
    struct User {
        let id: Int
        let name: String
        let bio: String
    }
}

extension AppState {
  var favoritePrimesState: FavoritePrimesState {
    get {
      FavoritePrimesState(
        favoritePrimes: self.favoritePrimes,
        activityFeed: self.activityFeed
      )
    }
    set {
      self.favoritePrimes = newValue.favoritePrimes
      self.activityFeed = newValue.activityFeed
    }
  }
}

struct PrimeAlert: Identifiable {
    let prime: Int
    
    var id: Int { self.prime }
}

struct CounterView: View {
    @ObservedObject var state: AppState
    @State var isPrimeModalShown: Bool = false
    @State var alertNthPrime: PrimeAlert?
    @State var isNthPrimeButtonDisabled = false
    
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
            Button {
                nthPrimeButtonAction()
            } label: {
                Text("What is the \(ordinal(self.state.count)) prime?")
            }
            .disabled(self.isNthPrimeButtonDisabled)
        }
        .font(.title)
        .navigationTitle("Counter Demo")
        .sheet(isPresented: self.$isPrimeModalShown) {
            IsPrimeModalView(state: self.state)
        }
        // alertNthPrime 에 값이 있을때, alert 을 띄운다
        .alert(item: self.$alertNthPrime) { alert in
            Alert(
                title: Text("The \(ordinal(self.state.count)) prime is \(alert.prime)"),
                dismissButton: .default(Text("Ok"))
            )
        }
    }
    
    func nthPrimeButtonAction() {
        self.isNthPrimeButtonDisabled = true
        nthPrime(self.state.count) { prime in
            print("response::", prime)
            self.alertNthPrime = prime.map(PrimeAlert.init(prime:))
            self.isNthPrimeButtonDisabled = false
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
                        self.state.favoritePrimes.removeAll(where: { $0 == self.state.count })
                        self.state.activityFeed.append(.init(timestamp: Date(), type: .removedFavoritePrime(self.state.count)))
                    } label: {
                        Text("Remove favorite primes")
                    }
                } else {
                    Button {
                        self.state.favoritePrimes.append(self.state.count)
                        self.state.activityFeed.append(.init(timestamp: Date(), type: .addedFavoritePrime(self.state.count)))
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


struct WolframAlphaResult: Decodable {
    let queryresult: QueryResult
    
    struct QueryResult: Decodable {
        let pods: [Pod]
        
        struct Pod: Decodable {
            let primary: Bool?
            let subpods: [SubPod]
            
            struct SubPod: Decodable {
                let plaintext: String
            }
        }
    }
}


struct FavoritePrimesState {
  var favoritePrimes: [Int]
  var activityFeed: [AppState.Activity]
}

// MARK: - FavoritePrimesView
struct FavoritePrimesView: View {
//    @ObservedObject var state: AppState
    @Binding var state: FavoritePrimesState
    
    var body: some View {
        List {
            ForEach(self.state.favoritePrimes, id: \.self) { prime in
                Text("\(prime)")
            }
            .onDelete { indexSet in
                for index in indexSet {
                    let prime = self.state.favoritePrimes[index]
                    self.state.favoritePrimes.remove(at: index)
                    self.state.activityFeed.append(AppState.Activity(timestamp: Date(), type: .removedFavoritePrime(prime)))
                }
            }
        }
        .navigationBarTitle(Text("Favorite Primes"))
    }
}

// MARK: - wolframe API
private let wolframAlphaApiKey = "??"

func wolframAlpha(query: String, callback: @escaping (WolframAlphaResult?) -> Void) -> Void {
    var components = URLComponents(string: "https://api.wolframalpha.com/v2/query")!
    components.queryItems = [
        URLQueryItem(name: "input", value: query),
        URLQueryItem(name: "format", value: "plaintext"),
        URLQueryItem(name: "output", value: "JSON"),
        URLQueryItem(name: "appid", value: wolframAlphaApiKey),
    ]
    
    URLSession.shared.dataTask(with: components.url(relativeTo: nil)!) { data, response, error in
        callback(
            data
                .flatMap { try? JSONDecoder().decode(WolframAlphaResult.self, from: $0) }
        )
    }
    .resume()
}

// n: 쿼리에 보낼 숫자값 , callback: API 호출후에 가져올 결과값
func nthPrime(_ n: Int, callback: @escaping (Int?) -> Void) -> Void {
    wolframAlpha(query: "prime \(n)") { result in
        callback(
            result
                .flatMap {
                    $0.queryresult // $0 == WolframAlphaResult
                        .pods
                        .first(where: { $0.primary == .some(true) })?
                        .subpods
                        .first?
                        .plaintext
                }
                .flatMap(Int.init)
        )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(state: AppState())
    }
}
