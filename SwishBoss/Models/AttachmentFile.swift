//
//  AttachmentFile.swift
//  SwishBoss
//
//  Created by William Lin on 25/02/2023.
//

import Foundation

class AttachmentFile {
    
    let fileDate: Data
    let key: String
    let filename: String
    
    init(fileDate: Data, key: String, filename: String) {
        self.fileDate = fileDate
        self.key = key
        self.filename = filename
    }
    
}
