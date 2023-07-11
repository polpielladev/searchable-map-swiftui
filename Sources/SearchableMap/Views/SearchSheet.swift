import SwiftUI
import CoreLocation

public struct SearchResult: Identifiable {
    public let name: String
    public let title: String
    public let id: UUID
    public let coordinate: CLLocationCoordinate2D
    
    public init(name: String, title: String, id: UUID, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.title = title
        self.id = id
        self.coordinate = coordinate
    }
}

struct SearchSheet: View {
    let textFieldPlaceHolder: String
    @Binding var search: String
    @Binding var selectedPresentationDetent: PresentationDetent
    let results: [SearchResult]
    let didSelectResult: (SearchResult) -> Void
    
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField(textFieldPlaceHolder, text: $search)
                    .focused($isTextFieldFocused)
            }
            .modifier(TextFieldGrayBackgroundColor())
            
            if results.isEmpty {
                ContentUnavailableView("Get started by searching for a restaurant", systemImage: "fork.knife")
            } else {
                List {
                    ForEach(results) { result in
                        Button(action: { isTextFieldFocused = false; didSelectResult(result) }) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(result.name)
                                        .font(.headline)
                                Text(result.title)
                            }
                        }
                        .listRowBackground(Color.clear)
                        .foregroundStyle(.primary)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            
            Spacer()
        }
        .onChange(of: isTextFieldFocused) { selectedPresentationDetent = isTextFieldFocused ? .large : .height(200) }
        .padding()
        .presentationDetents([.height(200), .large], selection: $selectedPresentationDetent)
        .presentationBackground(.regularMaterial)
        .presentationBackgroundInteraction(.enabled(upThrough: .large))
        .interactiveDismissDisabled()
    }
}

struct TextFieldGrayBackgroundColor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(12)
            .background(.gray.opacity(0.1))
            .cornerRadius(8)
            .foregroundColor(.primary)
    }
}
