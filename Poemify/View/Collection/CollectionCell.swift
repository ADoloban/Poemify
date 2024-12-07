import SwiftUI

struct CollectionCell: View {
    var collection: PoemCollection
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(collection.name)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(Color("01204E"))
                
                Spacer()
                if !collection.poems.isEmpty {
                    Text("\(collection.poems.count) Poems")
                        .font(.callout)
                        .foregroundColor(Color("5F6F65"))
                }
            }
            Divider()
                .background(Color("5F6F65"))
            
            if !collection.poems.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(collection.poems.prefix(3), id: \.title) { poem in
                        Text(poem.title)
                            .font(.system(size: 17))
                            .foregroundColor(.black)
                            .lineLimit(1)
                    }
                }
            } else {
                Text("No poems available")
                    .font(.system(size: 17))
                    .italic()
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color("C6EBC5"))
        .cornerRadius(10)
        .shadow(radius: 2)
        .frame(maxWidth: .infinity)
    }
}

