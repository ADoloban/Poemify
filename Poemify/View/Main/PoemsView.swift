import SwiftUI

struct PoemsView: View {
    @EnvironmentObject var viewModel: PoemViewModel
    @EnvironmentObject var collectionsViewModel: PoemCollectionsViewModel
    
    @State private var isSearchActive = false
    @State private var isSettingsActive = false
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("01204E"), Color("257180")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack{
                ZStack {
                    Text("Poems")
                        .font(.title)
                        .foregroundStyle(Color("C6EBC5"))
                        .bold()
                    
                    HStack {
                        Button(action: {
                            isSettingsActive = true
                        }) {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 22))
                                .foregroundColor(Color("C6EBC5"))
                                .padding(.leading, 16)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 20) {
                            Button(action: {
                                isSearchActive = true
                            }) {
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size: 22))
                                    .foregroundColor(Color("C6EBC5"))
                            }
                            
                            Button(action: {
                                reloadPoems()
                            }) {
                                Image(systemName: "arrow.clockwise")
                                    .font(.system(size: 22))
                                    .foregroundColor(Color("C6EBC5"))
                            }
                        }
                        .padding(.trailing, 16)
                    }
                }
                .padding(.vertical, 10)
                
                Spacer()
                
                if isLoading {
                    VStack(spacing: 10) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5)
                            .tint(Color("C6EBC5"))
                        
                        Text("Loading Poems...")
                            .foregroundColor(Color("C6EBC5"))
                            .font(.system(size: 25, weight: .heavy, design: .rounded))
                    }
                } else {
                    if let errorMessage = viewModel.errorMessage {
                        ContentUnavailableView {
                            Label("No Results", systemImage: "magnifyingglass")
                                .foregroundColor(Color("C6EBC5"))
                                .font(.system(size: 25, weight: .heavy, design: .rounded))
                        } description: {
                            Text(errorMessage)
                                .foregroundColor(Color("C6EBC5"))
                                .font(.system(size: 20, weight: .heavy, design: .rounded))
                        }
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 10) {
                                ForEach(viewModel.poems, id: \.self) { poem in
                                    NavigationLink(destination: PoemDetailView(poem: poem)
                                        .environmentObject(viewModel)
                                        .environmentObject(collectionsViewModel)) {
                                            PoemCell(poem: poem)
                                                .padding(.horizontal, 8)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    Divider()
                                        .background(Color("C6EBC5"))
                                        .padding(.horizontal, 20)
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
        }
        .onAppear {
            if viewModel.poems.isEmpty {
                viewModel.fetchAllPoems {
                    withAnimation {
                        isLoading = false
                    }
                }
            } else {
                isLoading = false
            }
        }
        .sheet(isPresented: $isSearchActive) {
            SearchView(isSearchActive: $isSearchActive, viewModel: viewModel)
        }
        .fullScreenCover(isPresented: $isSettingsActive) {
            SettingsView()
        }
    }
    
    private func reloadPoems() {
        viewModel.errorMessage = nil
        isLoading = true
        viewModel.fetchAllPoems {
            withAnimation {
                isLoading = false
            }
        }
    }
}

