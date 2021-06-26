//
//  ContentView.swift
//  Learning App
//
//  Created by Lucas Van Tilburg on 26/6/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                
                //confirm current module is set
                if model.currentModule != nil {
                    ForEach(0..<model.currentModule!.content.lessons.count) { index in
                        
                        NavigationLink(
                            destination:
                                ContentDetailView()
                                    .onAppear(perform: {
                                        model.beginLesson(index)
                                }),
                            label: {
                                ContentRowView(index: index)
                            })
                        
                        
                       
                    }
                }
                
                
            }
            .accentColor(.black)
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}
