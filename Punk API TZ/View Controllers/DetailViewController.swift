//
//  DetailViewController.swift
//  Punk API TZ
//
//  Created by user on 22.06.2021.
//

import UIKit

class DetailViewController: UIViewController {

    var nameBeer: String?
    var imageBeer: UIImage?
    var descriptionBeer: String?
    let beerImageView = UIImageView()
    let beerNameLabel = UILabel()
    let beerDescriptionField = UILabel()
    
    override func loadView() {
        
        guard let name = nameBeer else { return }
        guard let description = descriptionBeer else { return }
        
        view = UIView()
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.init(patternImage: UIImage(named: "stone2")!)
        view.addSubview(scrollView)

        beerImageView.translatesAutoresizingMaskIntoConstraints = false
        beerImageView.image = imageBeer
        beerImageView.contentMode = .scaleAspectFit
        scrollView.addSubview(beerImageView)
        
        beerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        beerNameLabel.font = UIFont.systemFont(ofSize: 25)
        beerNameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        beerNameLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.4)
        beerNameLabel.text = name
        beerNameLabel.textAlignment = .center
        beerNameLabel.numberOfLines = 0
        beerNameLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        scrollView.addSubview(beerNameLabel)
        
        beerDescriptionField.translatesAutoresizingMaskIntoConstraints = false
        beerDescriptionField.font = UIFont.systemFont(ofSize: 20)
        beerDescriptionField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        beerDescriptionField.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.4)
        beerDescriptionField.text = description
        beerDescriptionField.textAlignment = .natural
        beerDescriptionField.numberOfLines = 0
        beerDescriptionField.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        scrollView.addSubview(beerDescriptionField)
        
        NSLayoutConstraint.activate([
             
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),

            beerImageView.widthAnchor.constraint(equalToConstant: 80),
            beerImageView.heightAnchor.constraint(equalToConstant: 200),
            beerImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            beerImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),

            beerNameLabel.topAnchor.constraint(equalTo:  beerImageView.bottomAnchor, constant: 10),
            beerNameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            beerNameLabel.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor, constant: 0),
            beerNameLabel.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor, constant: 0),
            
            beerDescriptionField.topAnchor.constraint(equalTo:  beerNameLabel.topAnchor, constant: 70),
            beerDescriptionField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            beerDescriptionField.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor, constant: 0),
            beerDescriptionField.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10)
            
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pi = CGFloat.pi
        let rotation = CATransform3DMakeRotation((90.0*pi)/180, 0, 0.5, 0.5)
        
        beerImageView.layer.transform = rotation
        beerImageView.layer.anchorPoint = CGPoint(x: 5, y: 0.1);
        beerNameLabel.alpha = 0
        beerDescriptionField.alpha = 0
        
        UIView.animate(withDuration: 0.7, animations: { [weak self] in
            guard let self = self else {return}
            
            self.beerImageView.layer.transform = CATransform3DIdentity
            self.beerImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            self.beerNameLabel.alpha = 1
            self.beerDescriptionField.alpha = 1
        })
    }

}
