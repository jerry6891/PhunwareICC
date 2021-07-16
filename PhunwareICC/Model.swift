//
//  Model.swift
//  PhunwareICC
//
//  Created by Rex Karnufex on 5/4/21.
//

import UIKit

class Model {
    var title: String?
    var description: String?
    var locationline2: String?
    var image: String?
    var date: String?
    
    init(title: String?,
         description: String?,
         locationline2: String?,
         image: String?,
         date: String?) {
        self.title = title
        self.description = description
        self.locationline2 = locationline2
        self.image = image
        self.date = date
    }
}
