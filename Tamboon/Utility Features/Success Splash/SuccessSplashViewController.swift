//
//  SuccessSplashViewController.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 25/4/2564 BE.
//

import UIKit

class SuccessSplashViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet private weak var dismissButton: UIButton!
    
    //MARK: Static
    private static var storyboardName: String {
        return "SuccessSplash"
    }
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: nil)
    }
    
    //MARK: Properties
    var didTappedDismiss: Delegated<Void> = Delegated<Void>()
    
    required init?(coder: NSCoder) {
        didTappedDismiss = Delegated<Void>()
        
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: IBAction
    @IBAction func didTappedDismiss(_ sender: Any) {
        dismiss(animated: true) { [weak self] in
            self?.didTappedDismiss.callback?(())
        }
    }
}

//MARK: Setup
private extension SuccessSplashViewController {
    func setup() {
        dismissButton
            .layer
            .cornerRadius(radius: 8)
            .shadow(color: .black,
                    opacity: 0.3,
                    offset: .zero,
                    radius: 10)
    }
}
