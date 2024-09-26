//
//  Service.swift
//  Punk API TZ
//
//  Created by user on 22.06.2021.
//

import Foundation
import Alamofire


class BeerService {
    
    func getBeersList(page: Int, completion: @escaping ([BeerElement]) -> Void) {
        let url = "https://api.punkapi.com/v2/beers?page=\(page)"
        AF.request(url, method: .get).responseData { repsonse in
            guard let data = repsonse.value else { return }
            guard let beer = try? JSONDecoder().decode([BeerElement].self, from: data) else { return }
            DispatchQueue.main.async {
                completion(beer)
            }
        }
    }
    
}

