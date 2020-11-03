//
//  TournamentsVC.swift
//  ChessAggregator
//
//  Created by Administrator on 02.11.2020.
//

import UIKit

class TournamentsVC: UIViewController {

    private var tournamentsView: TournamentsView {
        self.view as! TournamentsView
    }
    
    override func loadView() {
        self.view = TournamentsView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tournamentsView.backgroundColor = .black

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class TournamentsView: AutoLayoutView {
    
    init() {
        super.init(frame: .zero)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
