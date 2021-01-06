//
//  NewsFeedModelFactory.swift
//  homeWork_1
//
//  Created by Andrey on 23/12/2020.
//  Copyright © 2020 Марат Нургалиев. All rights reserved.
//

import UIKit

class NewsFeedViewModelFactory {
    
    func constructViewModel(from feeds: [VkFeed]) -> [VkFeedViewModel] {
        return feeds.compactMap(getViewModel)
    }
    
    private func getViewModel(from feed: VkFeed) -> VkFeedViewModel {
        
        let sourceImageView = UIImageView()
        sourceImageView.sd_setImage(with: URL(string: feed.sourceUrl), placeholderImage: UIImage(named: "noPhoto"))
        
        let feedItemImageView = UIImageView()
        if let attachment = feed.attachments.first {
            feedItemImageView.sd_setImage(with: URL(string: attachment.imageUrl), placeholderImage: UIImage(named: "noPhoto"))
        } else {
            feedItemImageView.image = UIImage(named: "noPhoto")
        }
        
        let labelLikeText = feed.getStringFrom(count: feed.countLikes)
        let labelViewsText = feed.getStringFrom(count: feed.countViews)
        let labelShareText = feed.getStringFrom(count: feed.countReposts)
        let labelCommentText = feed.getStringFrom(count: feed.countComments)
        
        var ratio: CGFloat = 0
        
        if let attachment = feed.attachments.first { ratio = CGFloat(attachment.height) / CGFloat(attachment.width) }
        
        let viewModel = VkFeedViewModel(feedSourceName: feed.sourceName,
                                        feedDate: feed.getFeedDate(),
                                        feedText: feed.feedText,
                                        feedSourceImageView: sourceImageView,
                                        feedItemImageView: feedItemImageView,
                                        likesCount: labelLikeText,
                                        viewsCount: labelViewsText,
                                        repostsCount: labelShareText,
                                        commentsCount: labelCommentText,
                                        viewRatio: ratio)
        return viewModel
    }
}
