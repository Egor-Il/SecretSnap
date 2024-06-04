//
//  LaunchScreen.swift
//  SecretSnap
//
//  Created by Egor Ilchenko on 6/1/24.
//

import UIKit
import SnapKit

class LaunchScreen: UIViewController {
    // MARK: - Property
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        let nextImage = UIImage(systemName: "photo.stack", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .medium))
       button.setImage(nextImage, for: .normal)
        button.setTitle(" Gallery", for: .normal)
        return button
    }()
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        let addImage = UIImage(systemName: "plus.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .medium))
       button.setImage(addImage, for: .normal)
        button.setTitle(" Add", for: .normal)
        return button
    }()
    private let bottomButtonContainer: UIView = {
        let container = UIView()
        return container
    }()
    // MARK: - Life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        configuratUI()
    }
    // MARK: - Configurat UI function
    private func configuratUI() {
        view.addSubview(bottomButtonContainer)
        bottomButtonContainer.addSubview(nextButton)
        bottomButtonContainer.addSubview(addButton)
        bottomButtonContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(Offsets.bottomButtonContainerHeight)
        }
        nextButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(Offsets.righttOffset)
        }
        addButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Offsets.leftOffset)
            make.centerY.equalToSuperview()
        }
        let nextAction = UIAction  { _ in
            self.nextButtonPushed()
        }
        let addAction = UIAction { _ in
            self.addButtonPushed()
        }
        nextButton.addAction(nextAction, for: .touchUpInside)
        addButton.addAction(addAction, for: .touchUpInside)
    }
    // MARK: - Action functions
    private func nextButtonPushed() {
        let controller = ViewingScreen()
        navigationController?.pushViewController(controller, animated: true)
    }
    private func addButtonPushed() {
        let controller = AddPicturesScreen()
        navigationController?.pushViewController(controller, animated: true)
    }
}
