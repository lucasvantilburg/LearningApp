//
//  TestResultView.swift
//  Learning App
//
//  Created by Lucas Van Tilburg on 27/6/21.
//

import SwiftUI

struct TestResultView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var numCorrect:Int
    
    var resultHeading:String {
        
        guard model.currentModule != nil else {
            return ""
        }
        
        let pct = Double(numCorrect) / Double(model.currentModule!.test.questions.count)
        
        if (pct >= 0.5) {
            return "Awesome!"
        }
        else if pct >= 0.2 {
            return "Doing Great!"
        }
        else {
            return "Keep Working."
        }
    }
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text(resultHeading)
                .font(.title)
            
            Spacer()
            
            Text("You got \(numCorrect) out of \(model.currentModule?.test.questions.count ?? 0) questions")
            
            Spacer()
            
            Button(action: {
                model.currentTestSelected = nil
            }, label: {
                ZStack {
                    RectangleCard(color: .green)
                        .frame(height: 48)
                    
                    Text("Complete")
                        .bold()
                        .foregroundColor(.white)
                }
            })
            .padding()
            
            Spacer()
        }
    }
}
