//
//  SearchView.swift
//  Poemify
//
//  Created by Artem Doloban on 11.10.2024.
//
import SwiftUI

struct SearchView: View {
    @Binding var isSearchActive: Bool
    @ObservedObject var viewModel: PoemViewModel

    @State private var author: String = ""
    @State private var title: String = ""
    @State private var numberOfLines: String = ""
    @State private var resultCount: String = ""
    @State private var returnRandomPoems: Bool = false
    @State private var keyboardOffset: CGFloat = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color("01204E"), Color("257180")]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 40) {
                        Text("Search settings")
                            .foregroundStyle(Color("EBE3D5"))
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .padding(.top, 40)
                        
                        VStack(spacing: 40) {
                            CustomTextField(placeholder: "Author", text: $author)
                            CustomTextField(placeholder: "Title", text: $title)
                            CustomTextField(placeholder: "Number of lines", text: $numberOfLines, keyboardType: .numberPad)
                            CustomTextField(placeholder: "Result count", text: $resultCount, keyboardType: .numberPad)
                        }
                        .padding(.top, 30)
                        
                        Button(action: {
                            viewModel.errorMessage = nil
                            performSearch()
                            isSearchActive = false
                            
                        }) {
                            Text("Search")
                                .frame(width: 150)
                                .padding(15)
                                .background(author.isEmpty && title.isEmpty && numberOfLines.isEmpty && resultCount.isEmpty ? Color("5F6F65") : Color("FD8B51"))
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                                .cornerRadius(20)
                                .foregroundStyle(Color("EBE3D5"))
                        }
                        .disabled(author.isEmpty && title.isEmpty && numberOfLines.isEmpty && resultCount.isEmpty)
                        .padding(.top, 20)
                        
                        Spacer()
                    }
                    .padding()
                    .padding(.bottom, keyboardOffset)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
    
    func performSearch() {
        viewModel.searchPoems(
            author: author,
            title: title,
            numberOfLines: Int(numberOfLines),
            resultCount: Int(resultCount),
            random: returnRandomPoems
        )
    }


}

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        VStack(spacing: 10) {
            TextField("", text: $text)
                .foregroundStyle(Color("EBE3D5"))
                .textFieldStyle(.plain)
                .autocapitalization(.none)
                .keyboardType(keyboardType)
                .placeholder(when: text.isEmpty) {
                    Text(placeholder)
                        .foregroundStyle(Color("EBE3D5"))
                        .bold()
                }
                .font(.system(size: 25, weight: .bold, design: .rounded))
            
            Rectangle()
                .frame(width: 350, height: 2)
                .foregroundStyle(Color("EBE3D5"))
        }
        .frame(width: 350)
    }
}

#Preview {
    SearchView(isSearchActive: .constant(true), viewModel: PoemViewModel())
}
