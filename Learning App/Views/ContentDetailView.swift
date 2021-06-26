//
//  ContentDetailView.swift
//  Learning App
//
//  Created by Lucas Van Tilburg on 26/6/21.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        
        let url = URL(string: Constants.videoHostURL + (lesson?.video ?? ""))
        
        
        VStack {
            //only show video if we get a valid url
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
            }
            
            //Description
            CodeTextView()
            
        
            //show next lesson button only if there is a next lesson
            if model.hasNextLesson() {
                Button(action: {
                    
                    //advance the lesson
                    model.nextLesson()
                    
                }, label: {
                    
                    ZStack {
                        Rectangle()
                            .frame(height: 48)
                            .foregroundColor(Color.green)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .foregroundColor(.white)
                            .bold()
                    }
                    
                })
            }
        }
            .padding()
            .navigationBarTitle(lesson?.title ?? "")
    }
}

