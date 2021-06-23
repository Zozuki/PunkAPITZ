//
//  ViewController.swift
//  Punk API TZ
//
//  Created by user on 22.06.2021.
//

import UIKit

class BeerViewController: UITableViewController, UINavigationControllerDelegate {

    var service = BeerService()
    var beers = [BeerClass]()
    
    var isLoading = true
    var page = 1
    
    func fillBeersArr(elemsBeer: [BeerElement] ) {
        for beer in elemsBeer {
            guard let url = URL(string: beer.imageURL),
                  let data = try? Data(contentsOf: url),
                  let imageBeer = UIImage(data: data)
            else { return }
            let beerClass = BeerClass(name: beer.name, image: imageBeer, description: beer.beerDescription)
            beers.append(beerClass)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.getBeersList(page: page) { [weak self] elementsBeer in
            self?.fillBeersArr(elemsBeer: elementsBeer)
            self?.tableView.reloadData()
            self?.isLoading = false
        }
        
        navigationController?.navigationBar.setBackgroundImage( UIImage(named: "stone2")!, for: UIBarMetrics(rawValue: 20)!)
        navigationController?.navigationItem.backBarButtonItem?.tintColor = .black
        self.navigationController?.delegate = self
        
        let nibFile = UINib(nibName: "BeerTableViewCell", bundle: nil)
        tableView.register(nibFile, forCellReuseIdentifier: "BeerCell")
        
        let tableViewLoadingCellNib = UINib(nibName: "LoadingCell", bundle: nil)
        self.tableView.register(tableViewLoadingCellNib, forCellReuseIdentifier: "LoadingCell")
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if (offsetY > contentHeight - scrollView.frame.height ) && !isLoading {
            loadMoreData()
        }
    }
    
    func loadMoreData() {
            if !self.isLoading {
                self.isLoading = true
                DispatchQueue.global().async { [weak self] in
                    self?.page += 1
                    guard let guardPage = self?.page else { return }
                    DispatchQueue.main.async {
                        self?.service.getBeersList(page: guardPage) { elementsBeer in
                            self?.fillBeersArr(elemsBeer: elementsBeer)
                            self?.tableView.reloadData()
                            self?.isLoading = false
                        }
                    }
                    
                }
            }
        }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 70 //Item Cell height
        } else {
            return 81 //Loading Cell height
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        if beers.count == 225 {
            return 1
        } else {
            return 2
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return beers.count
        } else if section == 1  {
            return 1
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BeerCell", for: indexPath) as? BeerTableViewCell
            cell?.configure(text: beers[indexPath.row].name, image: beers[indexPath.row].image)
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
            cell.activityIndicator.startAnimating()
            return cell
        }
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as? BeerTableViewCell
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail")
            as? DetailViewController {
            cell?.beerName.alpha = 0
            UIView.animate(withDuration: 0.4, animations: {
                cell?.beerImage.frame.origin.x += UIScreen.main.bounds.width / 1.1
            }, completion: {[weak self]_ in
                guard let self = self else {return}
                vc.imageBeer = self.beers[indexPath.row].image
                vc.nameBeer = self.beers[indexPath.row].name
                vc.descriptionBeer = self.beers[indexPath.row].description
                self.navigationController?.pushViewController(vc, animated: true)
                UIView.animate(withDuration: 0.15, delay: 1, animations: {
                    cell?.beerImage.frame.origin.x -= UIScreen.main.bounds.width / 1.1
                    cell?.beerName.alpha = 1
                })
            })
        }
    }
    
}

