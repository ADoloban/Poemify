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
            ScrollView {
                VStack(spacing: 20) {
                    Text("Search settings")
                        .font(.title2.bold())
                        .foregroundColor(.primary)
                        .padding(.bottom, 8)

                    CustomTextField(placeholder: "Author", text: $author)
                    CustomTextField(placeholder: "Title", text: $title)
                    CustomTextField(placeholder: "Number of lines", text: $numberOfLines, keyboardType: .numberPad)
                    CustomTextField(placeholder: "Result count", text: $resultCount, keyboardType: .numberPad)

                    Button(action: {
                        performSearch()
                        isSearchActive = false
                    }) {
                        Text("Search")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 16)
                    }
                    .padding(.top, 8)

                    Spacer()
                }
                .padding()
                .padding(.bottom, keyboardOffset)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isSearchActive = false
                    }
                }
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
        TextField(placeholder, text: $text)
            .padding()
            .background(Color.clear)
            .cornerRadius(10)
            .font(.system(size: 18))
            .fontWeight(.bold)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .foregroundStyle(.gray)
            .keyboardType(keyboardType)
            .padding(.horizontal, 16)
    }
}

#Preview {
    SearchView(isSearchActive: .constant(true), viewModel: PoemViewModel())
}
