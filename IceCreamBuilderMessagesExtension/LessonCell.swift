//
//  LessonCell.swift
//  Lexamos
//
//  Created by Gisela K on 11/21/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation
/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A `UICollectionViewCell` subclass used to display an `IceCream` in the `IceCreamsViewController`.
*/

import UIKit
import Messages

class LessonCell: UICollectionViewCell {
    
    static let reuseIdentifier = "LessonCell"
    
//    var representedIceCream: IceCream?
    var selectLesson: (() -> Void)?
    @IBOutlet weak var sticker: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBAction func buttonTapped(_ sender: UIButton) {
        selectLesson?()
    }
}

