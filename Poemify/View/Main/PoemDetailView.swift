//
//  PoemDetailView.swift
//  Poemify
//
//  Created by Artem Doloban on 09.10.2024.
//

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
                    HStack {
                        Text(poem.title)
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("C6EBC5"))
                        
                        Button(action: {
                            isSelectCollectionsPresented = true
                        }) {
                            Image(systemName: collectionsViewModel.isPoemSavedInAnyCollection(poem) ? "bookmark.fill" : "bookmark")
                                .foregroundColor(.gray)
                                .font(.system(size: 24))
                        }
                    }
                    
                    Text(poem.author)
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    
                    Text(poem.lines.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.joined(separator: "\n"))
                        .font(.callout)
                        .padding(.leading, 20)
                        .padding(.trailing, 16)
                        .padding(.top, 16)
                        .padding(.bottom, 16)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Text("\(poem.lines.count) lines")
                            .font(.subheadline)
                            .foregroundColor(.gray)
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
