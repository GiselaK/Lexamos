//
//  LessonViewController.swift
//  Lexamos
//
//  Created by Gisela K on 11/21/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation
import UIKit

protocol LessonsViewControllerDelegate: AnyObject {
    func didSelectLesson(_ lesson: Lesson)
}

class LessonsViewController: UICollectionViewController {
     var delegate: LessonsViewControllerDelegate?
//    TODO: Issue#27 Prefer weak over strong delegates
    private let items: [Lesson]
    
    required init?(coder aDecoder: NSCoder) {

        let items: [Lesson] = [
            Lesson(sticker: UIImage(named: "openart-body-sticker")!, name: "Body Parts",
                   key: "person", comingSoon: false),
            Lesson(sticker: UIImage(named: "openart-clothes-sticker")!, name: "Clothes", key: "clothes", comingSoon: false),
            Lesson(sticker: UIImage(named: "openart-communication-sticker")!, name: "Greetings", key: "greetings", comingSoon: false),
            Lesson(sticker: UIImage(named: "openart-shopping-sticker")!, name: "Shopping", key: "shopping", comingSoon: false),
            Lesson(sticker: UIImage(named: "openart-transportation-sticker")!, name: "Transportation", key: "transportation", comingSoon: false),
            Lesson(sticker: UIImage(named: "openart-travel-sticker")!, name: "Travel", key: "travel", comingSoon: false),
            Lesson(sticker: UIImage(named: "openart-weather-sticker")!, name: "Weather", key: "weather", comingSoon: false),
            Lesson(sticker: UIImage(named: "openart-health-sticker")!, name: "Health", key: "health", comingSoon: false),
            Lesson(sticker: UIImage(named: "openart-food-sticker")!, name: "Food", key: "food", comingSoon: false),
            Lesson(sticker: UIImage(named: "openart-numbers-sticker")!, name: "Numbers", key: "numbers", comingSoon: false),
            Lesson(sticker: UIImage(named: "openart-family-sticker")!, name: "Family", key: "family", comingSoon: false)
            /*Game(sticker: UIImage(named: "openart-madlibs-sticker")!, name: "MadLibs", comingSoon: true)*/
        ]
        
        self.items = items
        super.init(coder: aDecoder)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    private func navigateToGameScreen(for lesson: Lesson) {
        print("Navigating to game screen with lesson: \(lesson.key)")
        
        let storyboard = UIStoryboard(name: "MainInterface", bundle: nil)
        guard let lessonsVC = storyboard.instantiateViewController(withIdentifier: "FlashcardsGameViewController") as? FlashcardsGameViewController else {
            fatalError("Controllers not found")
        }
        
        lessonsVC.lesson = lesson
        self.present(lessonsVC, animated: true, completion: nil)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LessonCell.reuseIdentifier, for: indexPath) as! LessonCell

        let item = items[indexPath.item]
        
        cell.sticker.image = item.sticker
        cell.name.text = item.name
        cell.key = item.key
        cell.selectLesson = { [weak self] in
            self?.navigateToGameScreen(for: item)
        }
        return cell
    }
}
