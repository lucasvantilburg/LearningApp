//
//  TestView.swift
//  Learning App
//
//  Created by Lucas Van Tilburg on 27/6/21.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        //To fix bug where TestView is empty- onAppear method has not run yet so if-statement fails
        VStack {
            if model.currentQuestion != nil {
                
                VStack {
                    //question number
                    Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    
                    //question
                    CodeTextView()
                    
                    //answers
                    
                    
                    //button
                }
                .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
                
            }
        }
        
    }
}

