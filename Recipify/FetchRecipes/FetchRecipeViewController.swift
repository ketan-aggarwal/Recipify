//
//  FetchRecipeViewController.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 08/02/24.
//

import UIKit
import Lottie


protocol FetchRecipeDisplayLogic{
    func displayRecipes(viewModel: FetchRecipeViewModel)
}

class FetchRecipeViewController: UIViewController, FetchRecipeDisplayLogic , UITableViewDelegate, UITableViewDataSource{
   
    @IBOutlet weak var headerLabel: UILabel!
   // @IBOutlet weak var searchField: UITextField!
   
    
    private var animationView: LottieAnimationView!
    var interactor : FetchRecipeInteractor?
    var viewModel: FetchRecipeViewModel?
    var discoverRouter: DiscoverRouter?

    @IBOutlet weak var fetchRecipeTable: UITableView!
    var searchText: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //searchField.text = searchText
        headerLabel.text = "\(searchText) Recipes"
        setupCylce()
        setupTable()
        interactor?.fetchRecipes(inputString: searchText)
    }
    
    func setupTable(){
        fetchRecipeTable.delegate = self
        fetchRecipeTable.dataSource = self
    }

    func setupCylce(){
        let viewController = self
        let interactor = FetchRecipeInteractor()
        let worker  = FetchRecipeWorker()
        let presenter = FetchRecipePresenter()
        let router = DiscoverRouter()
        
        viewController.interactor = interactor
        interactor.worker = worker
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.discoverRouter = router
        router.viewController = viewController
       
    }
    func displayRecipes(viewModel: FetchRecipeViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.fetchRecipeTable.reloadData()
            self.togglePlaceholderView()
        }
    }
    

    func togglePlaceholderView() {
        if viewModel?.searchList.isEmpty ?? true {
            setupAnimationView(on: self.view)
            
        }
    }

    func setupAnimationView(on view: UIView) {
        animationView = .init(name: "Animation - 1708948227887")
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        view.addSubview(animationView)
        animationView.play()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FetchRecipeTableCell", for: indexPath) as! FetchRecipeTableCell
        cell.router  = discoverRouter
        cell.viewModel = viewModel
        cell.collectionView.reloadData()
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fetchRecipeTable.frame.height
    }
}
