//
//  SimilarRecipesViewController.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 07/02/24.
//

import UIKit


protocol SimilarRecipeDelegate: AnyObject {
    func SimilarRecipeTableHeightDidChange(height: CGFloat)
}

protocol SimilarRecipesDisplayLogic {
    func displaySimilarRecipes(viewModel: SimilarRecipeViewModel)
}

class SimilarRecipesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , SimilarRecipesDisplayLogic {
    
    var interactor : SimilarRecipesInteractor?
    var viewModel : SimilarRecipeViewModel?
    var discoverRouter: DiscoverRouter?
   weak var delegate: SimilarRecipeDelegate?
    
    @IBOutlet weak var similarRecipesTable: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        interactor?.fetchSimilarRecipes()
        
        
    }
    
    func setupTable(){
        similarRecipesTable.delegate = self
        similarRecipesTable.dataSource = self
        similarRecipesTable.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    deinit {
        similarRecipesTable.removeObserver(self, forKeyPath: "contentSize")
    }

    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]
            {
                let newsize  = newvalue as! CGSize
                tableHeight.constant = newsize.height
            }
           
        }
        print("similartableHeight\(tableHeight.constant)")
    }
    
    public func setupCycle(){
        let viewController = self
        let worker = SimilarRecipesWorker()
        let presenter = SimilarRecipesPresenter()
        let router = DiscoverRouter()
        
        viewController.interactor = interactor
        interactor?.worker = worker
        interactor?.presenter = presenter
        presenter.viewController = viewController
        viewController.discoverRouter = router
        router.viewController = viewController
        
        
    }
    
    
    func displaySimilarRecipes(viewModel: SimilarRecipeViewModel){

        self.viewModel = viewModel
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.delegate?.SimilarRecipeTableHeightDidChange(height: self.tableHeight.constant)
        })
        DispatchQueue.main.async {
            self.similarRecipesTable.reloadData()
        }
        CATransaction.commit()
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        cell.viewModel = viewModel
        cell.router = discoverRouter
        cell.collectionView.reloadData()
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return RecipeCell.cellHeight * 3

    }
   
}
