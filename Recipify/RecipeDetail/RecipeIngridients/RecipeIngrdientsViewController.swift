//
//  RecipeIngrdientsViewController.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 05/02/24.
//

import UIKit

protocol RecipeIngridientDelegate: AnyObject {
    func ingridientTableHeightDidChange(height: CGFloat)
}

protocol RecipeIngrdientDisplayLogic {
    func displayRecipeIngredients(viewModel : RecipeIngridientViewModel)
}

class RecipeIngrdientsViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource,  RecipeIngrdientDisplayLogic{
    
    
    
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var recipeIngridientTable: UITableView!
    
    var interactor: RecipeIngridientInteractor?
    var viewModel : RecipeIngridientViewModel?
    var totalTableHeight: CGFloat = 0.0
    var delegate: RecipeIngridientDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        interactor?.getRecipeIngridients()
        recipeIngridientTable.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
    }
    
    
    
    func setupTable(){
        recipeIngridientTable.delegate = self
        recipeIngridientTable.dataSource = self
        recipeIngridientTable.register(UINib(nibName: "IngredientsTableCell", bundle: nil), forCellReuseIdentifier: "IngridientCell")
        recipeIngridientTable.isScrollEnabled = false
    }
    
    func setupCycle(){
        let viewController = self
        let worker = RecipeIngridientWorker()
        let presenter = RecipeIngridientPresenter()
        
        viewController.interactor = interactor
        interactor?.worker = worker
        interactor?.presenter = presenter
        presenter.viewController = viewController
    }
    
    
    
    deinit {
        recipeIngridientTable.removeObserver(self, forKeyPath: "contentSize")
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]
            {
                let newsize  = newvalue as! CGSize
                tableHeight.constant = newsize.height
            }
            
        }
        // print("tableHeight\(tableHeight.constant)")
    }
    
    func displayRecipeIngredients(viewModel : RecipeIngridientViewModel){
        self.viewModel = viewModel
        DispatchQueue.main.async {
            
            self.recipeIngridientTable.reloadData()
            self.delegate?.ingridientTableHeightDidChange(height: self.tableHeight.constant)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.ingridientList.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngridientCell", for: indexPath) as! IngredientsTableCell
        
        
        if let ingridientList = viewModel?.ingridientList {
            
            if indexPath.row < ingridientList.count {
                
                let ingridient = ingridientList[indexPath.row]
                
                let unit = ingridient.unit
                if let name = ingridient.name{
                    print(name)
                    cell.title.text = name
                    
                }else{
                    cell.title.text = "hello"
                }
                if let amount = ingridient.amount, let unit = ingridient.unit {
                    cell.amount.text = "\(amount) \(unit)"
                } else {
                    cell.amount.text = "N/A"
                }
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    
    
}
