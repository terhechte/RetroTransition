import UIKit
import RetroTransition

class PhotosGridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var images : [UIImage]!
    let transitionLabel = UILabel()
    
    let transitionClasses = [
        SwingInRetroTransition.self,
        SplitFromCenterRetroTransition.self,
        ShrinkingGrowingDiamondsRetroTransition.self,
        CollidingDiamondsRetroTransition.self,
        StraightLineRetroTransition.self,
        AngleLineRetroTransition.self,
        MultiFlipRetroTransition.self,
        ImageRepeatingRetroTransition.self,
        ClockRetroTransition.self,
        CircleRetroTransition.self,
        RectanglerRetroTransition.self,
        TiledFlipRetroTransition.self,
        FlipRetroTransition.self,
        MultiCircleRetroTransition.self,
        CrossFadeRetroTransition.self
    ]
    var transitionIndex : Int = 0 {
        didSet {
            transitionLabel.text = String(describing: transitionClasses[transitionIndex])
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let repeatedImages = ["photo1.jpg", "photo2.jpg", "photo3.jpg", "photo4.jpg"]
        images = []
        for _ in (0...6) {
            images.append(contentsOf: repeatedImages.compactMap({ UIImage.init(named: $0) }))
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let cellWidth = view.bounds.width / 2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        var isFullscreen = false
        if #available(iOS 11.0,  *) {
            isFullscreen = UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        
        let bottomBar = UIView(frame: CGRect(x:0, y:view.bounds.size.height - (64 + (isFullscreen ? 20 : 0)), width: view.bounds.size.width, height: 64 + (isFullscreen ? 20 : 0)))
        bottomBar.backgroundColor = UIColor.black
        
        let previousTransitionButton = UIButton()
        previousTransitionButton.setImage(#imageLiteral(resourceName: "leftarrow").maskWithColor(color: UIColor.white), for: .normal)
        previousTransitionButton.frame = CGRect.init(x: 10, y: 0, width: 44, height: 44)
        previousTransitionButton.center = CGPoint(x: previousTransitionButton.center.x, y: 64 / 2)
        previousTransitionButton.addTarget(self, action: #selector(self.previousTranstionPressed), for: .touchUpInside)
        bottomBar.addSubview(previousTransitionButton)
        
        let nextTransitionButton = UIButton()
        nextTransitionButton.setImage(#imageLiteral(resourceName: "leftarrow").maskWithColor(color: UIColor.white)?.flipHorizontal(), for: .normal)
        nextTransitionButton.frame = CGRect.init(x: bottomBar.frame.size.width - 44 - 10, y: 0, width: 44, height: 44)
        nextTransitionButton.center = CGPoint(x: nextTransitionButton.center.x, y: 64 / 2)
        nextTransitionButton.addTarget(self, action: #selector(self.nextTranstionPressed), for: .touchUpInside)
        bottomBar.addSubview(nextTransitionButton)
        
        transitionLabel.frame = CGRect(x: 0, y: 0, width: bottomBar.frame.size.width - (2 * (nextTransitionButton.frame.size.width + 20)), height: 64)
        transitionLabel.center.x = bottomBar.frame.size.width / 2
        transitionLabel.textColor = UIColor.white
        transitionLabel.textAlignment = .center
        transitionLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        bottomBar.addSubview(transitionLabel)
        
        let collectionView : UICollectionView = UICollectionView(frame: CGRect(x:0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height - bottomBar.bounds.size.height), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.black
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        view.addSubview(collectionView)
        view.addSubview(bottomBar)
        
        self.transitionIndex = 0
    }
    
    @objc func nextTranstionPressed() {
        self.transitionIndex = (self.transitionIndex + 1) % transitionClasses.count
    }
    
    @objc func previousTranstionPressed() {
        var newIndex = (self.transitionIndex - 1)
        while (newIndex < 0) {
            newIndex += transitionClasses.count
        }
        
        self.transitionIndex = newIndex
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath as IndexPath) as! PhotoCell
        
        cell.imageView.image = images[indexPath.row]
        
        return cell
    }
 
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoViewController.init(image: images[indexPath.row])
        let transition = transitionClasses[transitionIndex].init()
        navigationController?.pushViewController(vc, withRetroTransition: transition)
    }
}

