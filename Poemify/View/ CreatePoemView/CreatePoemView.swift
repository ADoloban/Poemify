import SwiftUI

struct CreatePoemView: View {
    var collection: PoemCollection
    @EnvironmentObject var collectionsViewModel: PoemCollectionsViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var poemText: String = ""
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("01204E"), Color("257180")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .onTapGesture {
                hideKeyboard()
            }
            
            VStack(spacing: 20) {
                ZStack {
                    Text("Create Poem")
                        .font(.title)
                        .foregroundStyle(Color("C6EBC5"))
                        .bold()
                    
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Cancel")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundStyle(Color("C6EBC5"))
                                .padding(.leading, 16)
                        }
                        
                        Spacer()
                    }
                }
                .padding(.vertical, 10)
                
                ScrollView {
                    VStack(spacing: 40) {
                        StyledTextField(
                            placeholder: "Title",
                            text: $title
                        )
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        
                        StyledTextField(
                            placeholder: "Author (optional)",
                            text: $author
                        )
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        
                        TextEditor(text: $poemText)
                            .scrollContentBackground(.hidden)
                            .foregroundColor(Color("C6EBC5"))
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .frame(height: 400)
                            .padding(.horizontal, 8)
                            .background(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("C6EBC5"), lineWidth: 2)
                            )
                        
                    }
                    .padding(.horizontal, 16)
                    
                    Spacer()
                    
                    Button(action: savePoem) {
                        Text("Save Poem")
                            .font(.headline)
                            .frame(maxWidth: 200)
                            .padding()
                            .background(title.isEmpty || poemText.isEmpty ? Color.gray : Color("FD8B51"))
                            .foregroundColor(Color("C6EBC5"))
                            .cornerRadius(20)
                            .padding(16)
                    }
                    .disabled(title.isEmpty || poemText.isEmpty)
                    .padding(.bottom, 20)
                }
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private func savePoem() {
        let lines = poemText.split(separator: "\n").map(String.init)
        let poemAuthor = author.isEmpty ? "Your own poem" : author
        let newPoem = Poem(title: title, author: poemAuthor, lines: lines, linecount: "\(lines.count)")
        
        collectionsViewModel.addPoem(newPoem, to: collection)
        dismiss()
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

