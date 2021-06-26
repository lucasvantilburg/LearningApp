//
//  ContentModel.swift
//  Learning App
//
//  Created by Lucas Van Tilburg on 26/6/21.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    
    var styleData:Data?
    
    init() {
        
        getLocalData()
        
    }
    
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
}
