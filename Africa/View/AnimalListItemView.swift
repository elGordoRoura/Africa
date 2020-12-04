//
//  AnimalListItemView.swift
//  Africa
//
//  Created by Christopher J. Roura on 10/10/20.
//

import SwiftUI

struct AnimalListItemView: View {
    // MARK: - PROPERTIES
    
    let animal: Animal
    
    
    // MARK: - BODY
    
    var body: some View {
        HStack(alignment: .center, spacing: 16.0) {
            Image(animal.image)
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 90)
                .clipShape(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                )
            
            VStack(alignment: .leading, spacing: 8.0) {
                Text(animal.name)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(.accentColor)
                
                Text(animal.headline)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.trailing, 8)
            } //: VSTACK
        } //: HSTACK
    }
}


// MARK: - PREVIEW

struct AnimalListItemView_Previews: PreviewProvider {
    static let animals: [Animal] = Bundle.main.decode("animals.json")
    
    static var previews: some View {
        AnimalListItemView(animal: animals[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
