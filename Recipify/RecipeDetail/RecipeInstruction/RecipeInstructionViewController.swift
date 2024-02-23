//
//  RecipeInstructionViewController.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 05/02/24.
//

import UIKit

protocol RecipeInstructionDelegate: AnyObject {
    func instructionTableHeightDidChange(height: CGFloat)
}

protocol RecipeInstructionDisplayLogic {
    func displayInstructions(viewModel: RecipeInstructionViewModel)
}

class RecipeInstructionViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, RecipeInstructionDisplayLogic {
    
   
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var recipeInstructionTable: UITableView!
    
    var viewModel:RecipeInstructionViewModel?
    var interactor: RecipeInstructionInteractor?
    weak var delegate: RecipeInstructionDelegate?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTable()
        
        //setupCycle()
//        interactor?.getRecipeInstruction(ID: RecipeDetailViewController.itemId ?? 0)
        interactor?.getRecipeInstruction()
        recipeInstructionTable.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }

    deinit{
        recipeInstructionTable.removeObserver(self, forKeyPath: "contentSize")
    }
   

    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]
            {
                let newsize  = newvalue as! CGSize
                tableHeight.constant = newsize.height
            }
           
        }
        //print("tableHeight\(tableHeight.constant)")
    }
    
    func setupTable(){
        recipeInstructionTable.delegate = self
        recipeInstructionTable.dataSource = self
        recipeInstructionTable.register(UINib(nibName: "InstructionsTableCell", bundle: nil), forCellReuseIdentifier: "InstructionCell")
        recipeInstructionTable.isScrollEnabled = false
    }
    
    func setupCycle(){
        let viewController = self
        //let interactor = RecipeInstructionInteractor()
        let worker = RecipeInstructionWorker()
        let presenter = RecipeInstructionPresenter()
        
        viewController.interactor = interactor
        interactor?.worker = worker
        interactor?.presenter = presenter
        presenter.viewController = viewController
    }
    
   
    func displayInstructions(viewModel: RecipeInstructionViewModel) {
        self.viewModel = viewModel
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.delegate?.instructionTableHeightDidChange(height: self.tableHeight.constant)
        })
        DispatchQueue.main.async {
            self.recipeInstructionTable.reloadData()
        }
        CATransaction.commit()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.instructionsList.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionCell", for: indexPath) as! InstructionsTableCell
        
        if let instructionsList = viewModel?.instructionsList {
            if indexPath.row < instructionsList.count {
                let instruction = instructionsList[indexPath.row]
                
                
                cell.stepNumber.text = "\(instruction.number)"
                print(instruction.number)
                
                cell.title.text = instruction.step
                print(instruction.step)
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
   


}
