import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var collectionsViewModel: PoemCollectionsViewModel
    @StateObject var poemViewModel = PoemViewModel()
    @State private var selectedTab = 0

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("01204E"), Color("257180")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            VStack {
                
                if selectedTab == 0 {
                    NavigationView {
                        PoemsView()
                            .environmentObject(collectionsViewModel)
                            .environmentObject(poemViewModel)
                    }
                } else if selectedTab == 1 {
                    NavigationView {
                        CollectionsView()
                            .environmentObject(collectionsViewModel)
                    }
                } else if selectedTab == 2 {
                    NavigationView {
                        PoemGeneratorView()
                            .environmentObject(collectionsViewModel)
                    }
                }
                
                HStack(spacing: 30) {
                    CustomTabItem(imageName: "house.fill", title: "Poems", isActive: selectedTab == 0) {
                        selectedTab = 0
                    }
                    CustomTabItem(imageName: "bookmark.fill", title: "Collections", isActive: selectedTab == 1) {
                        selectedTab = 1
                    }
                    CustomTabItem(imageName: "sparkles", title: "Generate", isActive: selectedTab == 2) {
                        selectedTab = 2
                    }
                }
                .shadow(radius: 10)
            }
            .onAppear {
                collectionsViewModel.loadCollectionsFromFirestore()
            }
        }
    }
    
    func CustomTabItem(imageName: String, title: String, isActive: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack {
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(isActive ? Color("257180") : Color("C6EBC5"))
                Text(title)
                    .font(.system(size: 12))
                    .foregroundColor(isActive ? Color("257180") : Color("C6EBC5"))
            }
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity)
            .background(isActive ? Color("C6EBC5") : Color.clear)
            .cornerRadius(20)
        }
        .frame(width: 100)
    }
}
