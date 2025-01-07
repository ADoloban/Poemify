import SwiftUI

struct PoemGeneratorView: View {
    @State private var theme: String = ""
    @State private var keywords: String = ""
    @State private var generatedPoem: String = ""
    @State private var isLoading: Bool = false
    @State private var showResult: Bool = false
    @State private var selectedLanguage: String = "Українська"
    @State private var showAddToCollections: Bool = false
    @State private var isValidPoem: Bool = true
    @EnvironmentObject var collectionsViewModel: PoemCollectionsViewModel
    
    let apiClient = PoemGeneratorAPIClient()

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("01204E"), Color("257180")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 10) {
                ZStack {
                    Text("Generation")
                        .font(.title)
                        .foregroundStyle(Color("C6EBC5"))
                        .bold()
                    
                    HStack {
                        Button(action: {
                            showResult = false
                            theme = ""
                            keywords = ""
                            isValidPoem = true
                        }) {
                            Text("Clean")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color("C6EBC5"))
                                .padding(.trailing, 5)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            showAddToCollections = true
                            showResult = false
                        }) {
                            Text("Save")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color("C6EBC5"))
                                .padding(.trailing, 5)
                        }
                        .disabled(!isValidPoem)
                        .sheet(isPresented: $showAddToCollections) {
                            AddToCollectionsView(poem: createGeneratedPoem())
                                .environmentObject(collectionsViewModel)
                        }
                    }
                }
                .padding(.vertical, 10)
                
                if !showResult {
                    StyledTextField(
                        placeholder: "Theme of the poem",
                        text: $theme
                    )
                    .padding(.top, 10)
                    
                    HStack {
                        Text("Enter keywords with commas:")
                            .font(.headline)
                            .foregroundStyle(Color("C6EBC5"))
                            .bold()
                            .padding(.top, 20)
                            .padding(.horizontal, 10)
                        
                        Spacer()
                    }
                    
                    TextEditor(text: $keywords)
                        .scrollContentBackground(.hidden)
                        .foregroundColor(Color("C6EBC5"))
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .frame(height: 200)
                        .padding(.horizontal)
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("C6EBC5"), lineWidth: 2)
                                .padding(.horizontal, 10)
                        )
                    
                    HStack {
                        Text("Select Language:")
                            .font(.headline)
                            .foregroundStyle(Color("C6EBC5"))
                            .bold()
                        
                        Spacer()
                        
                        HStack(spacing: 20) {
                            Button(action: {
                                selectedLanguage = "Українська"
                            }) {
                                Text("Ukrainian")
                                    .padding(5)
                                    .frame(maxWidth: .infinity)
                                    .background(selectedLanguage == "Українська" ? Color("257180") : Color.clear)
                                    .foregroundColor(selectedLanguage == "Українська" ? Color("C6EBC5") : Color("C6EBC5"))
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("C6EBC5"), lineWidth: 2)
                                    )
                            }
                            
                            Button(action: {
                                selectedLanguage = "English"
                            }) {
                                Text("English")
                                    .padding(5)
                                    .frame(maxWidth: .infinity)
                                    .background(selectedLanguage == "English" ? Color("257180") : Color.clear)
                                    .foregroundColor(selectedLanguage == "English" ? Color("C6EBC5") : Color("C6EBC5"))
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("C6EBC5"), lineWidth: 2)
                                    )
                            }
                        }
                        .frame(height: 50)
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                    
                    Spacer()
                    
                    Button(action: generatePoem) {
                        Text("Generate Poem")
                            .frame(maxWidth: 200)
                            .padding()
                            .font(.system(size: 20, weight: .bold))
                            .background( theme.isEmpty || keywords.isEmpty  ? Color("B0A695") : Color("257180"))
                            .foregroundStyle(Color("EBE3D5"))
                            .cornerRadius(20)
                    }
                    .padding()
                    .disabled(isLoading || theme.isEmpty || keywords.isEmpty)
                } else {
                    if isLoading {
                        Spacer()
                        
                        VStack(spacing: 10) {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .scaleEffect(1.5)
                                .tint(Color("C6EBC5"))
                        }
                    } else {
                        if !isValidPoem {
                            Text("Generating error")
                                .font(.largeTitle)
                                .foregroundStyle(Color("C6EBC5"))
                                .bold()
                                .padding()
                        } else {
                            TextEditor(text: $generatedPoem)
                                .scrollContentBackground(.hidden)
                                .foregroundColor(Color("C6EBC5"))
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .frame(maxHeight: .infinity)
                                .padding(.horizontal)
                                .background(Color.clear)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color("C6EBC5"), lineWidth: 2)
                                        .padding(.horizontal, 10)
                                )
                        }
                        
                    }
                    
                    Spacer()
                }
                
            }
            .padding()
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private func generatePoem() {
        guard !theme.isEmpty, !keywords.isEmpty else { return }
        isLoading = true
        showResult = true
        generatedPoem = ""
        
        let keywordsArray = keywords.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        
        apiClient.generatePoem(theme: theme, keywords: keywordsArray, language: selectedLanguage) { response in
            DispatchQueue.main.async {
                isLoading = false
                if let poem = response {
                    generatedPoem = poem
                    validatePoem()
                } else {
                    generatedPoem = "Generating error"
                    isValidPoem = false
                }
            }
        }
    }
    
    private func createGeneratedPoem() -> Poem {
        let lines = generatedPoem.split(separator: "\n").map(String.init)
        let author = "Generated"
        let newPoem = Poem(title: "Your own poem", author: author, lines: lines, linecount: "\(lines.count)")
        theme = ""
        keywords = ""
        return newPoem
    }
    
    private func validatePoem() {
        if generatedPoem.contains("error") || generatedPoem.isEmpty {
            isValidPoem = false
        } else {
            isValidPoem = true
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
