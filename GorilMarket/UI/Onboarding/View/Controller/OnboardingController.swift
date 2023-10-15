//
//  OnboardingController.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 9.10.2023.
//

import UIKit

class OnboardingController: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak private var pageControl: UIPageControl!
    @IBOutlet weak private var nextButton: UIButton!
    @IBOutlet weak private var collectionView: UICollectionView!
    
    // MARK: - Properties
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            updateNextButton(for: currentPage)
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        registerCollectionView()
        setCollectionView()
        setPageControl()
    }
    
    // MARK: - SetUI
    private func setUI() {
        //Button
        nextButton.setCorner(radius: 10)
        nextButton.setBorder(width: 1, color: UIColor.primaryColor ?? .clear)
    }
    
    // MARK: - Register CollectionView
    private func registerCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: OnboardingCell.nameOfClass, bundle: nil), forCellWithReuseIdentifier: OnboardingCell.nameOfClass)
    }

    // MARK: - Setup CollectionView
    private func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    // MARK: - Set PageControl
    private func setPageControl() {
        pageControl.numberOfPages = Slide.collection.count
        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
    }
    
    // MARK: - Selector Func
    @objc private func pageControlValueChanged() {
        let currentPage = pageControl.currentPage
        let xOffset = CGFloat(currentPage) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
    }
    
    // MARK: - Next Button Update
    private func updateNextButton(for index: Int) {
        if index == Slide.collection.count - 1 {
            nextButton.setTitle("Kaydol ve Başla", for: .normal)
            nextButton.backgroundColor = UIColor.primaryColor
            nextButton.setTitleColor(.white, for: .normal)
        } else {
            nextButton.setTitle("Sonraki", for: .normal)
            nextButton.backgroundColor = .clear
            nextButton.setTitleColor(UIColor.primaryColor, for: .normal)
        }
    }
  
    // MARK: - IBAction
    @IBAction func nextButtonClicked(_ sender: Any) {
        if currentPage == Slide.collection.count - 1 {
            let loginVC = LoginController(nibName: "LoginController", bundle: nil)
            let loginNC = UINavigationController(rootViewController: loginVC)
            loginNC.modalPresentationStyle = .fullScreen
            loginNC.modalTransitionStyle = .flipHorizontal
            present(loginNC, animated: true, completion: nil)

        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension OnboardingController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Slide.collection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.nameOfClass, for: indexPath) as? OnboardingCell else {
            return UICollectionViewCell()
        }
        
        cell.setCell(slide: Slide.collection[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OnboardingController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        self.pageControl.currentPage = index
        updateNextButton(for: index)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        self.pageControl.currentPage = index
        updateNextButton(for: index)
    }
}
