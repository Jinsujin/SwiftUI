import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var store: Store<AppState>
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: CounterView(store: self.store)) {
                    Text("Counter Demo")
                }
                NavigationLink(destination: FavoritePrimesView(state: self.$store.value.favoritePrimesState)) {
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

struct AppState {
    var count = 0
    var favoritePrimes: [Int] = []
    var loggedInUser: User? = nil
    var activityFeed: [Activity] = []
    
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

// Store<AppState>
final class Store<Value>: ObservableObject {
    @Published var value: Value
    
    init(initialValue: Value) {
        self.value = initialValue
    }
}

enum CounterAction {
    case decrTapped
    case incrTapped
}


// 하려고 하는 바는 reduce 고차함수와 유사하다
// action 이 들어오면, 현재 state 를 변경한 state 로 반환한다
func counterReducer(state: AppState, action: CounterAction) -> AppState {
    var copy = state
    switch action {
    case .decrTapped:
        copy.count -= 1
        
    case .incrTapped:
        copy.count += 1
    }
    return copy
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
    @ObservedObject var store: Store<AppState>
    @State var isPrimeModalShown: Bool = false
    @State var alertNthPrime: PrimeAlert?
    @State var isNthPrimeButtonDisabled = false
    
    var body: some View {
        
        VStack {
            HStack {
                Button("-") {
                    self.store.value = counterReducer(state: self.store.value, action: .decrTapped)
//                    self.store.value.count -= 1
                }
                Text("\(self.store.value.count)")
                Button("+") {
                    self.store.value = counterReducer(state: self.store.value, action: .incrTapped)
//                    self.store.value.count += 1
                }
            }
            
            Button(action: { self.isPrimeModalShown = true }) {
                Text("is this prime?")
            }
            Button {
                nthPrimeButtonAction()
            } label: {
                Text("What is the \(ordinal(self.store.value.count)) prime?")
            }
            .disabled(self.isNthPrimeButtonDisabled)
        }
        .font(.title)
        .navigationTitle("Counter Demo")
        .sheet(isPresented: self.$isPrimeModalShown) {
            IsPrimeModalView(store: self.store)
        }
        // alertNthPrime 에 값이 있을때, alert 을 띄운다
        .alert(item: self.$alertNthPrime) { alert in
            Alert(
                title: Text("The \(ordinal(self.store.value.count)) prime is \(alert.prime)"),
                dismissButton: .default(Text("Ok"))
            )
        }
    }
    
    func nthPrimeButtonAction() {
        self.isNthPrimeButtonDisabled = true
        nthPrime(self.store.value.count) { prime in
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
    @ObservedObject var store: Store<AppState>
    
    var body: some View {
        VStack {
            if isPrime(self.store.value.count) {
                Text("\(self.store.value.count) is Prime!")
                if self.store.value.favoritePrimes.contains(self.store.value.count) {
                    Button {
                        self.store.value.favoritePrimes.removeAll(where: { $0 == self.store.value.count })
                        self.store.value.activityFeed.append(.init(timestamp: Date(), type: .removedFavoritePrime(self.store.value.count)))
                    } label: {
                        Text("Remove favorite primes")
                    }
                } else {
                    Button {
                        self.store.value.favoritePrimes.append(self.store.value.count)
                        self.store.value.activityFeed.append(.init(timestamp: Date(), type: .addedFavoritePrime(self.store.value.count)))
                    } label: {
                        Text("Save favorite primes")
                    }
                }
            } else {
                Text("\(self.store.value.count) is Not Prime....")
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
        ContentView(store: Store<AppState>(initialValue: AppState()))
    }
}
