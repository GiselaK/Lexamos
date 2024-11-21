//
//  FlashcardsGameViewController.swift
//  LexamosMessagesExtension
//
//  Created by Gisela K on 11/21/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation
/*
See the LICENSE.txt file for this sample’s licensing information.

*/

import UIKit
import Kingfisher

class FlashcardsGameViewController: UIViewController, IceCreamPartCellDelegate {
    
    static let storyboardIdentifier = "FlashcardsGameViewController"
    
    @IBOutlet weak var gifImageView: UIImageView!
    
    let klipyService = KlipyService()

    override func viewDidLoad() {
        super.viewDidLoad()
        game_round()
    }

    
    public var lesson: Lesson?
    private var counter: Int = 0
    private var prompt: String?
    private var es_curriculum: [String: [String]] = [
        "person": [
            "pelo", "ojo", "nariz", "cabeza", "cara", "brazo", "mano", "dedo", "pierna", "pie",
            "oído", "muela", "garganta", "estómago", "espalda"
        ]
    ]
    
    private var en_curriculum: [String: [String]] = [
        "person": [
            "hair", "eye", "nose", "head", "face", "arm", "hand", "finger", "leg", "foot",
            "ear", "muela", "throat", "stomach", "back"
        ]
    ]

    
    private var answers: [String] = []
    private var answer: String = ""

    @IBOutlet weak var refresh: UIButton!
    @IBAction func didTapRefresh(_ sender: UIButton) {
        counter+=1
        if (counter > gifURLs.count - 1) {
            counter = 0
        }
        setGIF(index: counter)
    }
    
    func didTapAnswer(in cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        print("Button tapped in cell at index \(indexPath.row)")
        if (answer == answers[indexPath.row] ) {
            game_round()
        } else {
            print("YOU WRONG")
        }
        
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var gifURLs: [String] = []
    
    private func setGIF(index: Int) {
        if let gifURLString = gifURLs[index] ?? gifURLs.first, let url = URL(string: gifURLString) {
            DispatchQueue.main.async {
                self.gifImageView.kf.setImage(with: url, options: [.transition(.fade(0.3))]) { result in
                    switch result {
                    case .success:
                        print("GIF loaded successfully.")
                    case .failure(let error):
                        print("Error loading GIF: \(error.localizedDescription)")
                        self.gifImageView.image = UIImage(named: "placeholderImage")
                    }
                }
            }
        } else {
            print("No GIF found.")
            self.gifImageView.image = UIImage(named: "placeholderImage")
        }
    }
    
    func game_round() {
        if let vocabulary = en_curriculum[lesson!.key] {
            self.answers = Array(vocabulary.shuffled().prefix(4))
            self.answer = answers.randomElement()!
            collectionView.reloadData()

            self.klipyService.fetchGIFs(query: "\(answer)") { [weak self] result in
                        switch result {
                        case .success(let gifs):
                            self?.gifURLs = gifs
                            self?.setGIF(index: 0)
                        case .failure(let error):
                            print("Error fetching GIFs: \(error.localizedDescription)")
                            self?.gifImageView.image = UIImage(named: "placeholderImage")
                        }
                    }
                } else {
                    print("Failed to translate text")
                }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
                guard !answers.isEmpty else { return }

        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        // Set reasonable cell size
        layout.itemSize = CGSize(width: 120, height: 50)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10

    }
}


extension FlashcardsGameViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IceCreamPartCell.reuseIdentifier,
                                                            for: indexPath as IndexPath) as? IceCreamPartCell
            else { fatalError("Unable to dequeue a BodyPartCell") }
        let answer = answers[indexPath.row]
        cell.delegate = self
//        print("Cell Frame: \(cell.frame)")
//        print("Button Frame: \(cell.answer.frame)")
        cell.answer.setTitle(answer, for: .normal)
        
        cell.answer.setTitleColor(.white, for: .normal)
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()

        return cell
    }

}
