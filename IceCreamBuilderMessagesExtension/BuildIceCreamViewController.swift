/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The view controller shown to select an ice-cream part for a partially built ice cream.
*/

import UIKit
import Kingfisher

class BuildIceCreamViewController: UIViewController, IceCreamPartCellDelegate {
    
    // MARK: Properties
    
    static let storyboardIdentifier = "BuildIceCreamViewController"
    
    weak var delegate: BuildIceCreamViewControllerDelegate?
    
    @IBOutlet weak var gifImageView: UIImageView!  // UIImageView to display the GIF
    
    let klipyService = KlipyService()
    
    var iceCream: IceCream? {
        didSet {
            
            //            guard let iceCream = iceCream else { return }
            //            prompt = String(UnicodeScalar(Array(0x1F300...0x1F3F0).randomElement()!)!)
            
            //            let fruits = Emoji.fruits
            //            let randomFruit = fruits.randomElement()
            //            let emoji = randomFruit.emoji
            //            let name = randomFruit.name
            
            //            prompt = emoji
            //
            //            answers[2] = name
            //            print(foodEmojis)
            //            answers =
            //            // Determine the ice cream parts to show in the collection view.
            //            if iceCream.base == nil {
            //                iceCreamParts = Base.all.map { $0 }
            ////                prompt = NSLocalizedString("Select a base", comment: "")
            //            } else if iceCream.scoops == nil {
            //                iceCreamParts = Scoops.all.map { $0 }
            ////                prompt = NSLocalizedString("Add some scoops", comment: "")
            //            } else if iceCream.topping == nil {
            //                iceCreamParts = Topping.all.map { $0 }
            ////                prompt = NSLocalizedString("Finish with a topping", comment: "")
            //            }
        }
    }
    
    /// An array of `IceCreamPart`s to show in the collection view.
    
    //    fileprivate var iceCreamParts = [IceCreamPart]() {
    //        didSet {
    //            // Update the collection view to show the new ice cream parts.
    //            guard isViewLoaded else { return }
    //            collectionView.reloadData()
    //        }
    //    }
    

    
    
    //
    private var counter: Int = 0
    private var prompt: String?
    private var es_curriculum: [String: [String]] = [
        "body_parts": [
            "pelo", "ojo", "nariz", "cabeza", "cara", "brazo", "mano", "dedo", "pierna", "pie",
            "oído", "muela", "garganta", "estómago", "espalda"
        ]
    ]
    
    private var en_curriculum: [String: [String]] = [
        "body_parts": [
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
        // Handle the button tap
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        print("Button tapped in cell at index \(indexPath.row)")
        if (answer == answers[indexPath.row] ) {
            game_round()
        } else {
            print("YOU WRONG")
        }
        
    }
    //    @IBOutlet weak var promptLabel: UILabel!
    
    //    @IBOutlet weak var iceCreamView: IceCreamView!
    
    //    @IBOutlet weak var iceCreamViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: View lifecycle
    
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
        if let bodyParts = en_curriculum["body_parts"] {
            self.answers = Array(bodyParts.shuffled().prefix(4))
            self.answer = answers.randomElement()!
            collectionView.reloadData()
//            translateText(inputText: answers.first!, fromLanguage: "es", toLanguage: "en") { translatedText in
//                if let translatedText = translatedText {
                    // Trigger GIF fetch without using an iceCream object
            self.klipyService.fetchGIFs(query: answer) { [weak self] result in
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game_round()
//            }
//
//
//        }


        

        // Make sure the prompt and ice cream view are showing the correct information.
//        promptLabel.text = prompt
//        iceCreamView.iceCream = iceCream
        
        // We want the collection view to decelerate faster than normal so comes to rest on a body part more quickly.
//        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // There is nothing to layout of there are no ice cream parts to pick from.
                guard !answers.isEmpty else { return }

        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        // Set reasonable cell size
        layout.itemSize = CGSize(width: 120, height: 50) // Adjust as needed
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10

        
//        guard !iceCreamParts.isEmpty else { return }
//        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
//            else { fatalError("Expected the collection view to have a UICollectionViewFlowLayout") }
        
        // The ideal cell width is 1/3 of the width of the collection view.
//        layout.itemSize.width = floor(view.bounds.size.width / 3.0)

        // Set the cell height using the aspect ratio of the ice cream part images.
//        let iceCreamPartImageSize = iceCreamParts[0].image.size
//        guard iceCreamPartImageSize.width > 0 else { return }
//        let imageAspectRatio = iceCreamPartImageSize.width / iceCreamPartImageSize.height
//        
//        layout.itemSize.height = floor(layout.itemSize.width / imageAspectRatio)
//        
//        // Set the collection view's height constraint to match the cell size.
//        collectionViewHeightConstraint.constant = layout.itemSize.height
//        
//        // Adjust the collection view's `contentInset` so the first item is centered.
//        var contentInset = collectionView.contentInset
//        contentInset.left = (view.bounds.size.width - layout.itemSize.width) / 2.0
//        contentInset.right = contentInset.left
//        collectionView.contentInset = contentInset
        
        // Calculate the ideal height of the ice cream view.
//        let iceCreamViewContentHeight = iceCreamView.arrangedSubviews.reduce(0.0) { total, arrangedSubview in
//            return total + arrangedSubview.intrinsicContentSize.height
//        }
        
//        let iceCreamPartImageScale = layout.itemSize.height / iceCreamPartImageSize.height
//        iceCreamViewHeightConstraint.constant = floor(iceCreamViewContentHeight * iceCreamPartImageScale)
    }
    
    // MARK: Interface Builder actions
    
    @IBAction func didTapSelect(_: AnyObject) {
        // Determine the index path of the centered cell in the collection view.
//        guard let layout = collectionView.collectionViewLayout as? IceCreamPartCollectionViewLayout
//            else { fatalError("Expected the collection view to have a IceCreamPartCollectionViewLayout") }
//        
//        let halfWidth = collectionView.bounds.size.width / 2.0
//        guard let indexPath = layout.indexPathForVisibleItemClosest(to: collectionView.contentOffset.x + halfWidth) else { return }
//        
//        // Call the delegate with the body part for the centered cell.
//        delegate?.buildIceCreamViewController(self, didSelect: iceCreamParts[indexPath.row])
        
    }

}

/// A delegate protocol for the `BuildIceCreamViewController` class.

protocol BuildIceCreamViewControllerDelegate: AnyObject {

    /// Called when the user taps to select an `IceCreamPart` in the `BuildIceCreamViewController`.

    func buildIceCreamViewController(_ controller: BuildIceCreamViewController, didSelect iceCreamPart: IceCreamPart)

}

/// Extends `BuildIceCreamViewController` to conform to the `UICollectionViewDataSource` protocol.

extension BuildIceCreamViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IceCreamPartCell.reuseIdentifier,
                                                            for: indexPath as IndexPath) as? IceCreamPartCell
            else { fatalError("Unable to dequeue a BodyPartCell") }
        let answer = answers[indexPath.row]
        print("hi")
        cell.delegate = self
        print("Answer: \(answer)")
        print("Cell Frame: \(cell.frame)")
        print("Button Frame: \(cell.answer.frame)")
        cell.answer.setTitle(answer, for: .normal)//        cell.imageView.image = iceCreamPart.image
        
        cell.answer.setTitleColor(.white, for: .normal)
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()

        return cell
    }

}
