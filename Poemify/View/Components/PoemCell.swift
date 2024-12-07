import SwiftUI

struct PoemCell: View {
    var poem: Poem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(poem.title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(Color("01204E"))
            
            HStack {
                Text("\(poem.author)")
                Spacer()
                Text("\(poem.cleanedLines.count) lines")
            }
            .font(.callout)
            .foregroundColor(Color("5F6F65"))
            
            Divider()
                .background(Color("5F6F65"))
            
            Text(poem.lines.prefix(3).map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.joined(separator: "\n"))
                .font(.system(size: 17))
                .italic()
                .foregroundColor(.black)
                .lineLimit(3)
            
        }
        .padding()
        .background(Color("C6EBC5"))
        .cornerRadius(10)
        .shadow(radius: 2)
        .frame(maxWidth: .infinity)
    }
}
