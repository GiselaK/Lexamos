//
//  LessonViewController.swift
//  Lexamos
//
//  Created by Gisela K on 11/21/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation
import UIKit


class LessonsViewController: UICollectionViewController {
    private let items: [Lesson]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Additional setup if needed
    }
    required init?(coder aDecoder: NSCoder) {
        // Map the previously completed ice creams to an array of `CollectionViewItem`s.
//        let reversedHistory = IceCreamHistory.load().reversed()

        let items: [Lesson] = [
            Lesson(sticker: UIImage(named: "openart-body-sticker")!, name: "Body Parts", comingSoon: false),
            Lesson(sticker: UIImage(named: "openart-clothes-sticker")!, name: "Clothes", comingSoon: false),
            Lesson(sticker: UIImage(named: "openart-communication-sticker")!, name: "Greetings", comingSoon: false),
            Lesson(sticker: UIImage(named: "openart-shopping-sticker")!, name: "Shopping", comingSoon: false),
            Lesson(sticker: UIImage(named: "openart-transportation-sticker")!, name: "Transportation", comingSoon: false),
            Lesson(sticker: UIImage(named: "openart-travel-sticker")!, name: "Travel", comingSoon: false),
            Lesson(sticker: UIImage(named: "openart-weather-sticker")!, name: "Weather", comingSoon: false),
            Lesson(sticker: UIImage(named: "openart-health-sticker")!, name: "Health", comingSoon: false),
            Lesson(sticker: UIImage(named: "openart-food-sticker")!, name: "Food", comingSoon: false),
            Lesson(sticker: UIImage(named: "openart-numbers-sticker")!, name: "Numbers", comingSoon: false),
            Lesson(sticker: UIImage(named: "openart-family-sticker")!, name: "Family", comingSoon: false)
            /*Game(sticker: UIImage(named: "openart-madlibs-sticker")!, name: "MadLibs", comingSoon: true)*/
        ]
        
//        self.items = [
//            Game(image: UIImage(named: "openart-memory-sticker")!, name: "Memory"), Game(image: UIImage(named: "openart-memory-sticker")!, name: "Coming Soon!")
//        ]

        // Add `CollectionViewItem` that the user can tap to start building a new ice cream.
//        items.insert(.create, at: 0)
        
        self.items = items
        super.init(coder: aDecoder)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LessonCell.reuseIdentifier, for: indexPath) as! LessonCell
        // Fetch the corresponding IceCream object
        let item = items[indexPath.item]
        
        // Configure the cell
        cell.sticker.image = item.sticker
        cell.name.text = item.name
//        cell.selectGame = { [weak self] in
//            self?.navigateToMemoryScreen(for: item)
//        }
//        
        return cell
        
//        // The item's type determines which type of cell to return.
//        switch item {
//        case .iceCream(let iceCream):
//            return dequeueIceCreamCell(for: iceCream, at: indexPath)
//
//        case .create:
//            return dequeueIceCreamAddCell(at: indexPath)
//        }
    }
}
