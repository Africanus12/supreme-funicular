import SwiftUI
import MapKit

struct City: Identifiable {
    let id: String
    let name: String
    let coordinate: CLLocationCoordinate2D
    let temp: Int
}

struct ContentView: View {
    @State private var selectedCity: String?
    @State private var selectedTemp: Int?
    @State private var showAlert = false

    let cities = [
        City(id: "sf", name: "San Francisco", coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), temp: 68),
        // ... Add other cities here
    ]
    
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    var body: some View {
        Map(
            coordinateRegion: $mapRegion,
            annotationItems: cities
        ) { city in
            MapAnnotation(coordinate: city.coordinate) {
                Image(systemName: "mappin.circle.fill")
                    .resizable()
                    .foregroundColor(.red)
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        self.selectedCity = city.name
                        self.selectedTemp = city.temp
                        self.showAlert = true
                    }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Selected City"),
                message: Text("The temperature in \(selectedCity ?? "the city") is \(selectedTemp ?? 0)°F."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}