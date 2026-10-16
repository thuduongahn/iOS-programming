import SwiftUI

struct Fish: Identifiable {
    var id: Int
    var name: String
    var color: String
    var price: Double
    var imageName: String
    
    func getInfo() -> String {
        return "\(self.id) \(self.name) - \(self.color) - \(self.price) - \(self.imageName)"
    }
}
struct ContentView: View {
  
    @State private var fishes: [Fish] = [
        Fish(id: 1, name: "Neon Fish", color: "Red", price: 20.0, imageName: "neonfish"),
        Fish(id: 2, name: "Beta Fish", color: "Blue", price: 35.0, imageName: "betafish"),
        Fish(id: 3, name: "Gold Fish", color: "Orange", price: 25.0, imageName: "goldfish"),
        Fish(id: 4, name: "Angel Fish", color: "Silver", price: 40.0, imageName: "Angelfish")
    ]
    
    var body: some View {
        TabView {
            
            NavigationView {
                List(fishes) { fish in
                    let infoParts = fish.getInfo().components(separatedBy: " - ")
               
                    NavigationLink(destination: Text("Chi tiết \(infoParts[0])")) {
                        HStack(spacing: 16) {
                     
                            Image(infoParts[3])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            
                            VStack(alignment: .leading, spacing: 4) {
                               
                                let rawName = infoParts[0]
                                let cleanName = rawName.split(separator: " ", maxSplits: 1).last.map(String.init) ?? ""
                                
                                Text(cleanName)
                                    .font(.headline)
                                    .foregroundColor(.black)

                                Text("\(infoParts[1]) - $\(infoParts[2])")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                
                               
                                .toolbar {
                                    ToolbarItem(placement: .principal) {
                                        Text("My Aquarium")
                                            .font(.largeTitle)
                                            .fontWeight(.bold)
                                    }
                                    
                                    ToolbarItem(placement: .navigationBarTrailing) {
                                        Button(action: {
                                            
                                        }) {
                                            Image(systemName: "plus")
                                                .font(.title3)
                                                .fontWeight(.semibold)
                                        }
                                    }
                                }
            }
            .tabItem {
                Image(systemName: "fish.fill")
                Text("Fishes")
            }
            
            Text("Statistics Screen")
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Statistics")
                }
        }
    }
}

#Preview {
    ContentView()
}
