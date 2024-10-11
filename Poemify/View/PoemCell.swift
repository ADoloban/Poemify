//
//  PoemCell.swift
//  Poemify
//
//  Created by Artem Doloban on 09.10.2024.
//

import SwiftUI

struct PoemCell: View {
    var poem: Poem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(poem.title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            HStack {
                Text("By \(poem.author)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()  // Додаємо відступ між автором і кількістю рядків
                
                Text("\(poem.lines.count) lines")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Divider()  // Додаємо розділювач для візуальної сегментації
            
            // Для прикладу виведемо кілька рядків із вірша
            Text(poem.lines.prefix(3).map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.joined(separator: "\n"))
                .font(.body)
                .foregroundColor(.primary)
                .lineLimit(3)
            
        }
        .padding()  // Додаємо відступи для кращої візуалізації
        .background(Color(.systemGray6))  // Тло для клітинки
        .cornerRadius(10)  // Закруглення кутів
        .shadow(radius: 2)  // Тінь для кращого вигляду
        .frame(maxWidth: .infinity)
    }
}
