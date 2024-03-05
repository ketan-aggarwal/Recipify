//
//  DicoverViewContoller.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 25/01/24.
//



import UIKit
import Lottie


protocol DiscoverRecipeDisplayLogic {
    func displayDashBoardData(viewModel: DashBoardScreenViewModel)
}


class DiscoverViewContoller: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,  DiscoverRecipeDisplayLogic,  CustomTableCellDelegate{
    
    
    @IBOutlet weak var recipesTable: UITableView!
    
    private var animationView: LottieAnimationView!
    var discoverInteractor: DiscoverInteractor?
    var viewModel: DashBoardScreenViewModel?
    var discoverRouter: DiscoverRouter?
    var searchField: String?
    var customCell: CustomTableCell?
    
    
    func displayDashBoardData(viewModel: DashBoardScreenViewModel) {
        self.viewModel = viewModel
        
        DispatchQueue.main.async() {
            self.recipesTable.reloadData()
            self.togglePlaceholderView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        let nib = UINib(nibName: "Header_SearchViewCell", bundle: nil)
        recipesTable.register(nib, forCellReuseIdentifier: "headerCell")
        
        recipesTable.delegate = self
        recipesTable.dataSource = self
        recipesTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        discoverInteractor?.fetchRecipes(query: "vegan", type: "vegan")
        print("vegan executed")
        discoverInteractor?.fetchRecipes(query: "desserts", type: "desserts")
        print("desserts executed")
        discoverInteractor?.fetchRecipes(query: "salad", type: "salad")
        print("quick and easy executed")
        discoverInteractor?.fetchRecipes(query: "StirFry", type: "StirFry")
        togglePlaceholderView()
        
    }
    
    func setup(){
        let viewContoller = self
        let discoverInteractor = DiscoverInteractor()
        let worker = DiscoverRecipesWorker()
        let presenter =  DashBoardPresenter()
        let router = DiscoverRouter()
        
        
        viewContoller.discoverInteractor = discoverInteractor
        discoverInteractor.worker = worker
        discoverInteractor.presenter = presenter
        presenter.viewController = viewContoller
        viewContoller.discoverRouter = router
        router.viewController = viewContoller
        
    }
    func togglePlaceholderView() {
        if viewModel?.dashboardTableItems.isEmpty ?? true {
            setupAnimationView()
        } else {
            animationView?.removeFromSuperview()
        }
    }
    
    func setupAnimationView() {
//        animationView = .init(name: "Animation - 1708949559398")
        animationView = .init(name: "Animation - 1708950405223")
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        view.addSubview(animationView)
        animationView.play()
    }

    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (viewModel?.dashboardTableItems.count ?? 0) + 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! Header_SearchViewCell
            headerCell.textFieldSearch.delegate = self
            return headerCell
        } else {
            let customCell = tableView.dequeueReusableCell(withIdentifier: "CustomTableCell", for: indexPath) as! CustomTableCell
            
            guard let viewModel = viewModel else {
                print("viemodel is nil")
                return UITableViewCell()
            }
            
            let dashboardItems = viewModel.dashboardTableItems[indexPath.section - 1].dashboardItems
            customCell.dashboardItems = dashboardItems
            customCell.router = discoverRouter
            customCell.delegate = self
            customCell.backgroundColor = .yellow
            customCell.collectionView.reloadData()
            return customCell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            let nib = UINib(nibName: "SectionHeaderView", bundle: nil)
            if let headerView = nib.instantiate(withOwner: nil, options: nil).first as? SectionHeaderView {

                let sectionNames = ["Cuisines","Vegan", "Desserts", "Quick & Easy", "StirFry"]

                // Ensure the section index is within the bounds of the sectionNames array
                if section - 1 < sectionNames.count {
                    headerView.LabelsectionHeader.text = sectionNames[section - 1]
                    headerView.searchText = sectionNames[section - 1]

                    // Disable the "See All" button for the "Cuisines" section
                    if sectionNames[section - 1] == "Cuisines" {
                        headerView.BtnSeeAll.isEnabled = false
                    } else {
                        headerView.BtnSeeAll.isEnabled = true
                    }
                } else {
                    headerView.LabelsectionHeader.text = "Unknown Category"
                }

                headerView.BtnSeeAll.setTitle("See All", for: .normal)

                return headerView
            }
            return nil
        }
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 120
        case 1:
            return 85
        default:
            return RecipeCell.cellHeight - 120
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.01 : 24
    }
    
   
        
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 0.01
        }
    
    
    func didSelectCuisine(with searchText: String) {
        navigateToFetchRecipes(searchText: searchText)
    }
    
    func navigateToFetchRecipes(searchText: String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let newViewController = storyboard.instantiateViewController(withIdentifier: "FetchRecipeViewController") as? FetchRecipeViewController {
            newViewController.searchText = searchText
            present(newViewController, animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let searchText = textField.text, !searchText.isEmpty {
           
            navigateToFetchRecipes(searchText: searchText)
        }
        return true
    }
}

extension DiscoverViewContoller {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let customCell = cell as? CustomTableCell {
            self.customCell = customCell
        }
    }
}


