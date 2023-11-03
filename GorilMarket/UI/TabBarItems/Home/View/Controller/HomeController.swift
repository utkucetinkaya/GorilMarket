//
//  HomeController.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 15.10.2023.
//

import UIKit

class HomeController: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak private var campaignPageControl: UIPageControl!
    @IBOutlet weak private var campaignCollectionView: UICollectionView!
    @IBOutlet weak private var menuCollectionView: UICollectionView!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var  loadingView: UIView! {
        didSet {
            loadingView.setCorner(radius: 6)
        }
    }
    
    // MARK: - CollectionViewType
    enum CollectionViewType: Int {
        case campaign
        case menu
    }
    
    // MARK: - Properties
    var currentPage: Int = 0
    var timer: Timer?
    private let viewModel = MealsViewModel()
    var mealsModel: [Food]?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerViewModel()
        registerCollectionView()
        setupCampaignCollectionView()
        setupMenuCollectionView()
        setupPageControl()
        startTimer()
        showSpinner()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUI()
    }
    
    // MARK: - SetUI
    private func setUI() {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - ActivityIndicator
    private func showSpinner() {
        activityIndicator.startAnimating()
        loadingView.isHidden = false
    }

    private func hideSpinner() {
        activityIndicator.stopAnimating()
        loadingView.isHidden = true
    }
    
    // MARK: - RegisterViewModel
    
    private func registerViewModel() {
        viewModel.delegate = self
        viewModel.fetchAllMeals()
    }
    
    // MARK: - SetCollectionView
    private func registerCollectionView() {
        // Campaign
        campaignCollectionView.delegate = self
        campaignCollectionView.dataSource = self
        campaignCollectionView.register(UINib(nibName: CampaignCell.nameOfClass, bundle: nil), forCellWithReuseIdentifier: CampaignCell.nameOfClass)
        
        campaignCollectionView.tag = 0
        
        // Menu
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        menuCollectionView.register(UINib(nibName: MenuCell.nameOfClass, bundle: nil), forCellWithReuseIdentifier: MenuCell.nameOfClass)
        
        menuCollectionView.tag = 1
    }
    
    // MARK: - SetupCollectionView
    private func setupCampaignCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
 
        campaignCollectionView.backgroundColor = UIColor.clear
        campaignCollectionView.collectionViewLayout = layout
        campaignCollectionView.isPagingEnabled = true
        campaignCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func setupMenuCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        menuCollectionView.backgroundColor = UIColor.clear
        menuCollectionView.collectionViewLayout = layout
    }
    
    // MARK: - StartTimer
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    // MARK: - SetPageControl
    private func setupPageControl() {
        campaignPageControl.numberOfPages = CampaignSlide.collection.count
        campaignPageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
    }
    
    // MARK: - Selector Func
    
    // PageControl Selector
    @objc private func pageControlValueChanged() {
        let currentPage = campaignPageControl.currentPage
        let xOffset = CGFloat(currentPage) * campaignCollectionView.frame.width
        campaignCollectionView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
    }
    
    // Timer Selector
    @objc private func autoScroll() {
        let nextPage = currentPage + 1
        if nextPage < CampaignSlide.collection.count {
            let xOffset = CGFloat(nextPage) * campaignCollectionView.frame.width
            campaignCollectionView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
            currentPage = nextPage
            campaignPageControl.currentPage = nextPage
        } else {
            campaignCollectionView.setContentOffset(CGPoint.zero, animated: true)
            currentPage = 0
            campaignPageControl.currentPage = 0
        }
    }
    
    // MARK: - NavigateDetail
    private func navigateDetail(for indexPath: IndexPath) {
        let item = mealsModel?[indexPath.row]
        let detailController = DetailController()
        detailController.item = item
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}

// MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let collectionViewType = CollectionViewType(rawValue: collectionView.tag)!
        
        switch collectionViewType {
        case .campaign:
            // Return the number of items for campaign collection view
            return CampaignSlide.collection.count
        case .menu:
            // Return the number of items for menu collection view
            return mealsModel?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionViewType = CollectionViewType(rawValue: collectionView.tag)!
        
        switch collectionViewType {
        case .campaign:
            // Get the campaign cell
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CampaignCell.nameOfClass, for: indexPath) as? CampaignCell else {
                return UICollectionViewCell()
            }
            
            let imageName = CampaignSlide.collection[indexPath.item].imageName
            let image = UIImage(named: imageName ?? "") ?? UIImage()
            
            cell.setCell(image: image)
            
            return cell
        case .menu:
            // Get the menu cell
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.nameOfClass, for: indexPath) as? MenuCell else {
                return UICollectionViewCell()
            }
            
            let meals = mealsModel?[indexPath.item]
            let name = meals?.name
            let price = meals?.price
            let id = meals?.imageName
           
            cell.setCell(price: price ?? "", name: name ?? "",id: id ?? "")
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        let collectionViewType = CollectionViewType(rawValue: collectionView.tag)!
        
        switch collectionViewType {
        case .campaign:
            return 0
        case .menu:
            return 30
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateDetail(for: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Get the collection view type from the tag value
        let collectionViewType = CollectionViewType(rawValue: collectionView.tag)!
        
        switch collectionViewType {
        case .campaign:
            return campaignCollectionView.frame.size
        case .menu:
            return CGSize(width: 170, height: 200)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let collectionViewType = CollectionViewType(rawValue: collectionView.tag)!

        switch collectionViewType {
        case .campaign:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case .menu:
            return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        }
    }
}

// MARK: - Fetch Meals Response
extension HomeController: MealsResponseProtocol {
    func mealsFetchSuccess(meals: [Food]) {
        self.mealsModel = meals
        menuCollectionView.reloadData()
        hideSpinner()
    }
    
    func mealsFail(error: String) {
        print(error)
        hideSpinner()
    }
}
