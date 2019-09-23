//
//  Fifth_MVVM_ViewController.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/19.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit

//MVVM pattern View层应该再摘出去
class Fifth_MVVM_ViewController: UIViewController {

    let minimumUserNameLength = 5
    let minimumPasswordLength = 5
    let disposeBag = DisposeBag()
    
    private var viewModel : FifthViewModel!
    
    let userNameTf : UITextField = {
        
        let tf = UITextField.init(frame: CGRect(x: 20, y: 70, width: kScreenWidth-40, height: 40))
        tf.borderStyle = .roundedRect
        
        return tf
    }()
    
    let userNameOutlet : UILabel = {
        
        let label = UILabel.init(frame: CGRect(x: 20, y: 120, width: kScreenWidth-40, height: 40))
        label.textColor = .red
        return label
    }()
    
    
    let passwordTf : UITextField = {
        
        let tf = UITextField.init(frame: CGRect(x: 20, y: 200, width: kScreenWidth-40, height: 40))
        tf.borderStyle = .roundedRect
        
        return tf
    }()
    
    let passwordOutlet : UILabel = {
        
        let label = UILabel.init(frame: CGRect(x: 20, y: 250, width: kScreenWidth-40, height: 40))
        label.textColor = .red
        
        return label
    }()
    
    let submitBtn : UIButton = {
        
        let btn = UIButton.init(frame: CGRect(x: 20, y: 320, width: kScreenWidth - 40, height: 40))
        btn.setTitle("do something", for: .normal)
        btn.setTitleColor(.gray, for: .disabled)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .green
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.userNameOutlet.text = "userName has to be at least \(self.minimumUserNameLength) characters"
        self.passwordOutlet.text = "password has to be at least \(self.minimumPasswordLength) characters"
        
        self.view.addSubview(self.userNameTf)
        self.view.addSubview(self.userNameOutlet)
        self.view.addSubview(self.passwordTf)
        self.view.addSubview(self.passwordOutlet)
        self.view.addSubview(self.submitBtn)
        
        self.setup()
    }
    
    func setup(){
        
        viewModel = FifthViewModel.init(userName: self.userNameTf.rx.text.orEmpty.asObservable(), password: self.passwordTf.rx.text.orEmpty.asObservable())
        
        viewModel.userNameValid.bind(to: self.userNameOutlet.rx.isHidden).disposed(by: disposeBag)
        
        viewModel.userNameValid.bind(to: self.passwordTf.rx.isEnabled).disposed(by: disposeBag)
        
        viewModel.passwordValid.bind { [weak self] valid in
            
            self?.passwordOutlet.isHidden = valid
            
        }.disposed(by: disposeBag)
        
        viewModel.everythingValid.bind(to: self.submitBtn.rx.isEnabled).disposed(by: disposeBag)
        
        self.submitBtn.rx.tap.subscribe(onNext: {
            
            [weak self] in
            self?.showAlert()
            
        }).disposed(by: disposeBag)
        
    }
    
    func showAlert(){
        
        SCLAlertView().showInfo("Important info", subTitle: "You are great")
        self.view.endEditing(true)
    }


}
