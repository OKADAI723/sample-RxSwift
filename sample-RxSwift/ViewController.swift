//
//  ViewController.swift
//  sample-RxSwift
//
//  Created by Yudai Fujioka on 2021/08/12.
//

import UIKit
import RxCocoa
import RxSwift

final class ViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = ViewModel()
    
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var cardView: UIView! {
        didSet {
            cardView.layer.cornerRadius = cardView.layer.frame.height / 16
        }
    }
    @IBOutlet private weak var textField: UITextField!
    
    @IBOutlet private weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView))
        cardView.addGestureRecognizer(panGesture)
        setTextField()
        
    }
    
    private func setTextField() {
        textField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.label.text = text
                self?.viewModel.textInput.onNext(text ?? "")
            }
            .disposed(by: disposeBag )
    }
    
    private func setupBindings() {
        button.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                print(#function)
            })
            .disposed(by: disposeBag )
    }
}

@objc private extension ViewController {
    func panCardView(panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: cardView)
        
        if panGesture.state == .changed {
            cardView.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        } else if panGesture.state == .ended {
            UIView.animate(withDuration: 0.3) {
                self.cardView.transform = .identity
                self.cardView.layoutIfNeeded()
            }
        }
    }
}

