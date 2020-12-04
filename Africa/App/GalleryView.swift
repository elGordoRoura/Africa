//
//  GalleryView.swift
//  Africa
//
//  Created by Christopher J. Roura on 9/30/20.
//

import SwiftUI

struct GalleryView: View {
    // MARK: - PROPERTIES
    
    @State private var selectedAnimal: String   = "lion"
    
    let animals: [Animal]                       = Bundle.main.decode("animals.json")
    let haptics                                 = UIImpactFeedbackGenerator(style: .medium)
    
    
    @State private var gridLayout: [GridItem]   = [.init(.flexible())]
    @State private var gridColumn: Double       = 3.0
    
    
    func gridSwitch() {
        gridLayout = Array(repeating: .init(.flexible()), count: Int(gridColumn))
    }
    
    
    // MARK: - BODY
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 30) {
                // MARK: - Image
                Image(selectedAnimal)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 8))
                
                // MARK: - Slider
                Slider(value: $gridColumn, in: 2 ... 4, step: 1)
                    .padding(.horizontal)
                    .onChange(of: gridColumn) { value in
                        gridSwitch()
                    }
                
                // MARK: - Grid
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                    ForEach(animals) { item in
                        Image(item.image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                            .onTapGesture {
                                selectedAnimal = item.image
                                haptics.impactOccurred()
                            }
                    } //: FOREACH
                } //: LAZYVGRID
                .animation(.easeInOut)
                .onAppear {
                    gridSwitch()
                }
            } //: VSTACK
            .padding(.horizontal, 10)
            .padding(.vertical, 15)
        } //: SCROLLVIEW
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(MotionAnimationView().edgesIgnoringSafeArea(.top))
    }
}


// MARK: - PREVIEW

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
