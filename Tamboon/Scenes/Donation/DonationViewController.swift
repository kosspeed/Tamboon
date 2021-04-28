//
//  DonationViewController.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 23/4/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import AnimatedCardInput
import ProgressHUD

class DonationViewController: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet private weak var containerCardView: UIView!
    @IBOutlet private weak var containerCardInputsView: UIView!
    @IBOutlet private weak var charityNameLabel: UILabel!
    @IBOutlet private weak var amountTextField: UITextField!
    @IBOutlet private weak var donateButton: UIButton!
    
    //MARK: VIP Cycle
    var interactor: DonationBusinessLogic!
    var router: (DonationRoutable & DonationDataPassing)!
    
    //MARK: Static
    private static var storyboardName: String {
        return "Donation"
    }
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: nil)
    }
    
    //MARK: Properties
    private var cardView: CardView?
    private var cardInputsView: CardInputsView?
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        initialize()
    }
    
    @IBAction private func didTappedDonate(_ sender: Any) {
        ProgressHUD.show()
        
        performDonate(creditCardNumber: cardInputsView?.creditCardData.cardNumber,
                      creditCardHolder: cardInputsView?.creditCardData.cardholderName,
                      creditCardValidDate: cardInputsView?.creditCardData.validityDate,
                      creditCardCVV: cardInputsView?.creditCardData.CVVNumber,
                      amount: amountTextField.text)
    }
}

//MARK: Setup & Configuration
private extension DonationViewController {
    func configure() {
        let viewController = self
        let router = DonationRouter(viewController: viewController)
        let presenter = DonationPresenter(displayable: viewController)
        let interactor = DonationInteractor(presenter: presenter)
        
        viewController.interactor = interactor
        viewController.router = router
        viewController.router.dataStore = interactor
    }
    
    func setup() {
        setupDonateButton()
        setupAmountTextField()
        setupCardComponents()
    }
    
    func setupAmountTextField() {
        amountTextField
            .layer
            .cornerRadius(radius: 8)
            .border(width: 1, color: .gray)
    }
    
    func setupDonateButton() {
        donateButton
            .layer
            .cornerRadius(radius: 8)
            .shadow(color: .black,
                    opacity: 0.3,
                    offset: .zero,
                    radius: 10)
    }
    
    func setupCardComponents() {
        cardView = CardView(cardNumberDigitsLimit: 16,
                            cardNumberChunkLengths: [4, 4, 4, 4],
                            CVVNumberDigitsLimit: 3)
        
        cardInputsView = CardInputsView(cardNumberDigitLimit: 16)
        
        if let cardView = cardView, let cardInputsView = cardInputsView {
            containerCardView.addSubview(cardView)
            containerCardInputsView.addSubview(cardInputsView)
            
            containerCardView.allEqualConstraint(pluginView: cardView)
            containerCardInputsView.allEqualConstraint(pluginView: cardInputsView)
            
            cardView.creditCardDataDelegate = cardInputsView
            cardInputsView.creditCardDataDelegate = cardView
        }
    }
}

//MARK: Logics
private extension DonationViewController {
    func initialize() {
        let request = Donation.Initialize.Request()
        interactor.initialize(request: request)
    }
    
    func performDonate(creditCardNumber: String?,
                       creditCardHolder: String?,
                       creditCardValidDate: String?,
                       creditCardCVV: String?,
                       amount: String?) {
        let request = Donation.PerformDonate.Request(creditCardNumber: creditCardNumber,
                                                     creditCardHolder: creditCardHolder,
                                                     creditCardValidDate:
                                                        creditCardValidDate,
                                                     creditCardCVV: creditCardCVV,
                                                     amount: amount)
        interactor.performDonate(request: request)
    }
    
    func donate(creditCardNumber: String,
                creditCardHolder: String,
                creditCardValidDate: String,
                creditCardCVV: String,
                amount: String) {
        let request = Donation.Donate.Request(creditCardNumber: creditCardNumber,
                                              creditCardHolder: creditCardHolder,
                                              creditCardValidDate:
                                                creditCardValidDate,
                                              creditCardCVV: creditCardCVV,
                                              amount: amount)
        interactor.donate(request: request)
    }
    
    func routeToSuccessSplash(dismissHandler: @escaping (() -> Void)) {
        router.routeToSuccessSplash(dismissHandler: dismissHandler)
    }
}

//MARK: Displayable
extension DonationViewController: DonationDisplayable {
    func displayInitialize(viewModel: Donation.Initialize.ViewModel) {
        charityNameLabel.text = viewModel.charityName
    }
    
    func displayPerformDonate(viewModel: Donation.PerformDonate.ViewModel) {
        if viewModel.validate == .fine {
            if let cardInputsView = cardInputsView, let amount = amountTextField.text {
                donate(creditCardNumber: cardInputsView.creditCardData.cardNumber,
                       creditCardHolder: cardInputsView.creditCardData.cardholderName,
                       creditCardValidDate: cardInputsView.creditCardData.validityDate,
                       creditCardCVV: cardInputsView.creditCardData.CVVNumber,
                       amount: amount)
            }
        } else {
            ProgressHUD.dismiss()
            alert(message: viewModel.error?.description ?? "")
        }
    }
    
    func displayDonate(viewModel: Donation.Donate.ViewModel) {
        ProgressHUD.dismiss()
        
        if viewModel.status == .success {
            routeToSuccessSplash { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        } else {
            alert(message: viewModel.error?.description ?? "")
        }
    }
}

