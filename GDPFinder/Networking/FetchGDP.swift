//
//  FetchGDP.swift
//  GDPFinder
//
//  Created by Nafisa Rahman on 1/9/18.
//  Copyright © 2018 com.nafisa. All rights reserved.
//

import Foundation

import Foundation
import SwiftyJSON

class FetchGDP{
    
    //MARK:- properties
    private var gdp : Double
    private var gdpYear: String
    
    weak var GDPdelegate : GDPOperations?
    
    init(){
        
        gdp = 0.0
        gdpYear = ""
    }
    
    //MARK:- methods
    
    //MARK:- get gdp data from world bank
    func getGDP(_ ISOCountry : String, currYear: Int) {
        
        //setup url request
        let dateRange : String = "\(currYear - 2):\(currYear - 1)"
        
        let endpoint: String = "http://api.worldbank.org/countries/" + ISOCountry + "/indicators/NY.GDP.MKTP.CD?format=json&date=" + dateRange
        
        guard let url = URL(string: endpoint) else {
            print("error in creating URL")
            
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        
        //create task
        let task = session.dataTask(with: urlRequest, completionHandler: { [weak self] (data, response, error) in
            
            if let weakSelf = self {
                
                guard let responseData = data else {
                    print("did not receive gdp data")
                    return
                }
                
                guard error == nil else {
                    print("error calling gdp")
                    return
                }
                
                //MARK: parse JSON using Swifty JSON
                weakSelf.addData(data: responseData)
                
            }
            
        })
        //send
        task.resume()
        
    }
    
    //MARK:- parse response data in JSON using SwiftyJSON
    func addData(data : Data){
        
        do {
            
            let jsonData = try JSON(data: data)
            print(jsonData)
            
            //check whether error message exist
            if jsonData[0]["message"]["id"].isEmpty {
                
                //extract no of years returned
                let yearDataCount = jsonData[1].count
                
                for  i in 0..<yearDataCount {
                    
                    print(jsonData[1][i]["value"])
                    
                    if jsonData[1][i]["value"] != JSON.null {
                        
                        //extract gdp value name
                        let gdpValue = jsonData[1][i]["value"].doubleValue
                        
                        
                        if gdpValue > 0 {
                            
                            gdp = gdpValue
                            gdpYear = jsonData[1][i]["date"].stringValue
                            
                            
                            //format GDP
                            GDPdelegate?.updateGDP(largeGDP: gdp, gdpYear: gdpYear)
                            
                            break
                            
                        }//if gdpValue > 0
                    }//if jsonData[1][i]["value"] != nil
                        
                    else {
                        //show GDP data is not available
                        GDPdelegate?.noGDP(info: "No GDP data available")
                    }
                }//for
            }//if !jsonData[0]["message"]["id"].isExists()
            else{
                //show GDP data is not available
                GDPdelegate?.noGDP(info: "No GDP data available")
                
            }
            
        }catch {
            print("error in JSON parsing")
        }
        
    }
    
}
