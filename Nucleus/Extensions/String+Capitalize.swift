//
//  String+Capitalize.swift
//  Nucleus
//
//  Created by Bezaleel Ashefor on 11/12/2017.
//  Copyright © 2017 Ephod. All rights reserved.
//

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}



