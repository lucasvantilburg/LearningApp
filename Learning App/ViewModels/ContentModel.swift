//
//  ContentModel.swift
//  Learning App
//
//  Created by Lucas Van Tilburg on 26/6/21.
//

import Foundation

class ContentModel: ObservableObject {
    
    //list of modules
    @Published var modules = [Module]()
    
    //current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    //current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    //current lesson explanation
    @Published var lessonDescription = NSAttributedString()
    
    var styleData:Data?
    
    init() {
        
        getLocalData()
        
    }
    
    // MARK: Data Methods
    
    func getLocalData() {
        //get url to json file
        let jsonURL = Bundle.main.url(forResource: "data", withExtension: "json")
        
        //read file into data object
        do {
            let jsonData = try Data(contentsOf: jsonURL!)
            
            //try to decode json into array of modules
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            self.modules = modules
        }
        catch {
            //log error
            print("Couldn't parse local json data")
        }
        
        //parse the style data
        let styleURL = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            let styleData = try Data(contentsOf: styleURL!)
            
            self.styleData = styleData
        }
        catch {
            print("Couldn't parse local html data")
        }
        
        
    }
    
    // MARK: Module navigation methods
    
    func beginModule(_ moduleID:Int) {
        
        //find index for module ID
        for index in 0..<modules.count {
            if modules[index].id == moduleID {
                currentModuleIndex = index
                break
            }
        }
        
        //set current module
        currentModule = modules[currentModuleIndex]
    }
    
    func beginLesson(_ lessonIndex:Int) {
        
        //check that index is in range
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        }
        else {
            currentLessonIndex = 0
        }
        
        //set the current lesson and description
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        lessonDescription = addStyling(currentLesson!.explanation)
    }
    
    func hasNextLesson() -> Bool {
        return currentLessonIndex+1 < currentModule!.content.lessons.count
    }
    
    func nextLesson() {
        //advance the lesson index
        currentLessonIndex += 1
        
        //check it is in range
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            //set current lesson and description
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            lessonDescription = addStyling(currentLesson!.explanation)
        }
        else {
            currentLessonIndex = 0
            currentLesson = nil
        }
        
        
    }
    
    // MARK: code styling
    
    private func addStyling(_ htmlString:String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        //add styling data
        if styleData != nil {
            data.append(styleData!)
        }
        
        //add html data
        data.append(Data(htmlString.utf8))
        
        //convert to attributed string
        
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType:NSAttributedString.DocumentType.html], documentAttributes: nil) {
            
            resultString = attributedString
        }
        
        
        return resultString
        
    }
}
