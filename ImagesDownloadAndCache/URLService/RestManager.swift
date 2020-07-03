//
//  URLSessionTaskService.swift
//  ImagesDownloadAndCache
//
//  Created by Bhavin Gupta on 02/07/20.
//  Copyright © 2020 Bhavin Gupta. All rights reserved.
//

import Foundation
import SwiftyJSON

class RestManager: NSObject {
  
  // Service Call Method
  func getJson(completionHandler: @escaping (Response) -> Void){
    guard let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") else {return}
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard let dataResponse = data,
        error == nil else {
          print(error?.localizedDescription ?? "Response Error")
          return }
      let responseStrInISOLatin = String(data: dataResponse, encoding: String.Encoding.isoLatin1)
      guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
        print("could not convert data to UTF-8 format")
        return
      }
      do{
        //here dataResponse received from a network request
        let json = try JSON(data: modifiedDataInUTF8Format)
        var strTitle = String()
        if let title = json["title"].string {
          strTitle = title
        }
        var rowObject: [Rows] = []
        var rows: Rows?
        for item in json["rows"].arrayValue {
          var strTitle = String()
          var strDescription = String()
          var strImageURL = String()
          if let title = item["title"].string {
            strTitle = title
          }
          if let description = item["description"].string {
            strDescription = description
          }
          if let imageURL = item["imageHref"].string {
            strImageURL = imageURL
          }
          rows = Rows(title: strTitle, descriptions: strDescription, imageHref: strImageURL)
          rowObject.append(rows!)
        }
        let jsonResponse = Response(title: strTitle, rows:rowObject)
        completionHandler(jsonResponse)
      } catch let parsingError {
        print("Error", parsingError)
      }
    }
    task.resume()
  }
}
