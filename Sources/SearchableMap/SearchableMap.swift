import MapKit
import SwiftUI

public struct SearchableMap: View {
    @ObservedObject private var viewModel: SearchableMapViewModel
    
    public init(textFieldPlaceHolder: String, search: Binding<String>, onSelectResult: @escaping (SearchResult) -> Void) {
        self.viewModel = SearchableMapViewModel(searchService: SearchLocationServiceFactory.make(), searchPlaceHolder: textFieldPlaceHolder, onSelectResult: onSelectResult)
    }
    
    public var body: some View {
        Map(position: $viewModel.position, interactionModes: .all) {
            if let selectedSearchLocation = viewModel.selectedSearchLocation {
                Marker(selectedSearchLocation.name, systemImage: "fork.knife", coordinate: selectedSearchLocation.coordinate)
                    .tint(.pink)
                
            }
        }
        .sheet(isPresented: .constant(true)) {
            SearchSheet(
                textFieldPlaceHolder: viewModel.searchPlaceHolder,
                search: $viewModel.searchQuery,
                selectedPresentationDetent: $viewModel.selectedPresentationDetent,
                results: viewModel.searchResults,
                didSelectResult: viewModel.didSelectResult
            )
        }
        .ignoresSafeArea()
    }
}
