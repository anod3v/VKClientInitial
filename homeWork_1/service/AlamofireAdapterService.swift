//
//  AlamofireAdapterService.swift
//  homeWork_1
//
//  Created by Andrey on 23/12/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation

class AlamofireAdapterService: VkApiFeedsDelegate {
    
    var didGetFeeds: (([VkFeed]) -> Void)?
    
    func returnFeeds(_ feeds: [VkFeed]) {
        didGetFeeds!(feeds)
    }
    
    func getFeedWithClosure(startFrom: String, completion: @escaping ([VkFeed]) -> Void) {
        getFeed(startFrom: startFrom)
        self.didGetFeeds = { [weak self] response in
            guard self != nil else { return }
            completion(response)
        }
    }
    
    private func getFeed(startFrom: String) {
        AlamofireService.instance.getNews(startFrom: "", delegate: self)
    }
    
}
