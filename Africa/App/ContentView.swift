//
//  ContentView.swift
//  Africa
//
//  Created by Christopher J. Roura on 9/30/20.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    
    let animals: [Animal]                       = Bundle.main.decode("animals.json")
    
    @State private var isGridViewActive: Bool   = false
    
    let haptics                                 = UIImpactFeedbackGenerator(style: .medium)
    
    @State private var gridLayout: [GridItem]   = [GridItem(.flexible())]
    @State private var gridColumn: Int          = 1
    @State private var toolbarIcon: String      = "square.grid.2x2"
    
    
    // MARK: - FUNCTIONS
    
    func gridSwitch() {
        gridLayout  = Array(repeating: .init(.flexible()), count: gridLayout.count % 3 + 1)
        gridColumn  = gridLayout.count
        print("Grid Number: \(gridColumn)")
        
        switch gridColumn {
            case 1: toolbarIcon     = "square.grid.2x2"
            case 2: toolbarIcon     = "square.grid.3x2"
            case 3: toolbarIcon     = "rectangle.grid.1x2"
            default: toolbarIcon    = "square.grid.2x2"
        }
    }
    
    
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            Group {
                if !isGridViewActive {
                    List {
                        CoverImageView()
                            .frame(height: 300)
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        ForEach(animals) { animal in
                            NavigationLink(destination: AnimalDetailView(animal: animal)) {
                                AnimalListItemView(animal: animal)
                            } //: NAVIGATIONLINK
                        } //: FOREACH
                        CreditsView()
                            .modifier(CenterModifier())
                    } //: LIST
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                            ForEach(animals) { animal in
                                NavigationLink(destination: AnimalDetailView(animal: animal)) {
                                    AnimalGridItemView(animal: animal)
                                } //: NAVIGATIONLINK
                            } //: FOREACH
                        } //: LAZYVGRID
                        .padding(10)
                        .animation(.easeIn)
                    } //: SCROLLVIEW
                }
            } //: GROUP
            .navigationBarTitle("Africa", displayMode: .large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 16) {
                        // List
                        Button(action: {
                            print("List view is activated")
                            isGridViewActive = false
                            haptics.impactOccurred()
                        }) {
                            Image(systemName: "square.fill.text.grid.1x2")
                                .font(.title2)
                                .foregroundColor(isGridViewActive ? .primary : .accentColor)
                        }
                        
                        //GRID
                        Button(action: {
                            print("Grid view is activated")
                            isGridViewActive = true
                            haptics.impactOccurred()
                            gridSwitch()
                        }) {
                            Image(systemName: toolbarIcon)
                                .font(.title2)
                                .foregroundColor(isGridViewActive ? .accentColor : .primary)
                        }
                    } //: HSTACK
                } //: TOOLBARITEM
            } //: TOOLBAR
        } //: NAVIGATIONVIEW
    }
}


// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
