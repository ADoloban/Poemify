//
//  PoemDetailView.swift
//  Poemify
//
//  Created by Artem Doloban on 09.10.2024.
//

import SwiftUI

struct PoemDetailView: View {
    var poem: Poem
    @State private var isShareSheetShowing = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {
                
                Text(poem.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    
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
            .sheet(isPresented: $isShareSheetShowing, content: {
                ActivityViewController(activityItems: [poem.createShareableText()])
            })
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isShareSheetShowing = true
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}
