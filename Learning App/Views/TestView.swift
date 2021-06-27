//
//  TestView.swift
//  Learning App
//
//  Created by Lucas Van Tilburg on 27/6/21.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model:ContentModel
    
    @State var selectedAnswerIndex:Int?
    @State var submitted = false
    
    @State var numCorrect = 0
    
    var body: some View {
        
        //To fix bug where TestView is empty- onAppear method has not run yet so if-statement fails
        VStack {
            if model.currentQuestion != nil {
                
                VStack (alignment: .leading) {
                    //question number
                    Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                        .padding(.leading, 20)
                    
                    //question
                    CodeTextView()
                        .padding(.horizontal, 20)
                    
                    //answers
                    ScrollView {
                        VStack {
                            ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { index in
      
                                Button(action: {
                                    //track the selected index
                                    selectedAnswerIndex = index
                                }, label: {
                                    ZStack {
                                        
                                        if submitted == false {
                                            RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                                .frame(height: 48)
                                        }
                                        else {
                                            //answer has been submitted
                                            
                                            //user selected correct answer
                                            if (index == selectedAnswerIndex && index == model.currentQuestion!.correctIndex) {
                                                //show green background
                                                RectangleCard(color: .green)
                                                    .frame(height: 48)
                                            }
                                            //user selected wrong answer
                                            else if (index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex) {
                                                //show red background
                                                RectangleCard(color: .red)
                                                    .frame(height: 48)
                                            }
                                            //display correct answer
                                            else if (index == model.currentQuestion!.correctIndex) {
                                                //show green background
                                                RectangleCard(color: .green)
                                                    .frame(height: 48)
                                            }
                                            //stays white
                                            else {
                                                RectangleCard(color: .white)
                                                    .frame(height: 48)
                                            }
                                        }
                                        
                                        
                                        Text(model.currentQuestion!.answers[index])
                                    }
                                })
                                .disabled(submitted)
                                
                            }
                        }
                        .padding()
                        .accentColor(.black)
                    }

                    //submit button
                    Button(action: {
                        
                        //check if answer has been submitted
                        if submitted == true {
                            //reset properties
                            submitted = false
                            selectedAnswerIndex = nil
                            
                            //move to next question
                            model.nextQuestion()
                        }
                        else {
                            //submit answer
                            submitted = true
                            
                            //check the answer and increment the counter if correct
                            if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                                numCorrect += 1
                            }
                        }
                    }, label: {
                        ZStack {
                            RectangleCard(color: .green)
                                .frame(height: 48)
                            
                            Text(buttonText)
                                .foregroundColor(.white)
                                .bold()
                        }
                        .padding()
                    })
                    .disabled(selectedAnswerIndex == nil)
                }
                .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
                
            }
        }
        
    }
    
    var buttonText:String {
        
        //check if answer has been submitted
        if submitted == true {
            if model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count {
                //this is last question
                return "Finish"
            }
            else {
                //there is a next question
                return "Next"
            }
        }
        else {
            return "Submit"
        }
    }
}

