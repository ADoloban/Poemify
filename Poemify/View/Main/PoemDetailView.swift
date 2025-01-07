import SwiftUI

struct PoemDetailView: View {
    var poem: Poem
    @EnvironmentObject var collectionsViewModel: PoemCollectionsViewModel
    @State private var isShareSheetShowing = false
    @State private var isSelectCollectionsPresented = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                        Text("Back")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                    }
                    .foregroundColor(Color("C6EBC5"))
                }
                
                Spacer()
                
                Button(action: {
                    isShareSheetShowing = true
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(Color("C6EBC5"))
                }
            }
            .padding()
            .background(Color("01204E"))
            .frame(maxWidth: .infinity)
            .sheet(isPresented: $isShareSheetShowing) {
                ActivityViewController(activityItems: [poem.createShareableText()])
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
            ScrollView {
                VStack(alignment: .center, spacing: 16) {
                    HStack(spacing: 20) {
                        Text(poem.title)
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("C6EBC5"))
                        
                        Button(action: {
                            isSelectCollectionsPresented = true
                        }) {
                            Image(systemName: collectionsViewModel.isPoemSavedInAnyCollection(poem) ? "bookmark.fill" : "bookmark")
                                .foregroundColor(Color("C6EBC5"))
                                .font(.system(size: 8))
                                .scaleEffect(3)
                                .contentTransition(.symbolEffect(.replace))
                        }
                    }
                    
                    Text(poem.author)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(Color("C6EBC5"))
                        .multilineTextAlignment(.center)
                    
                    Text(poem.lines.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.joined(separator: "\n"))
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .padding()
                        .padding(.leading, 20)
                        .background(Color(.white).opacity(0.7))
                        .cornerRadius(10)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Text("\(poem.cleanedLines.count) lines")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(Color("C6EBC5"))
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .sheet(isPresented: $isSelectCollectionsPresented) {
                    AddToCollectionsView(poem: poem)
                        .environmentObject(collectionsViewModel)
                }
            }
        }
        .background(LinearGradient(
                    gradient: Gradient(colors: [Color("01204E"), Color("257180")]),
                    startPoint: .top,
                    endPoint: .bottom
                ))
        .navigationBarHidden(true)
    }
}
