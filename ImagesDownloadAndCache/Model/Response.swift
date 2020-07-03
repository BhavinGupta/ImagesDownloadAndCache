//
//  Response.swift
//  ImagesDownloadAndCache
//
//  Created by Bhavin Gupta on 03/07/20.
//  Copyright © 2020 Bhavin Gupta. All rights reserved.
//

import UIKit

class Response: NSObject {
  var title: String
  var rows: [Rows] = []
  
  init(title: String, rows: [Rows]) {
    self.title = title
    self.rows = rows
  }
}

class Rows: NSObject {
  var title: String
  var descriptions: String
  var imageHref: String
  
  init(title: String, descriptions: String, imageHref: String) {
    self.title = title
    self.descriptions = descriptions
    self.imageHref = imageHref
  }
}
