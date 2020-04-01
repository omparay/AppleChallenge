//
//  iTunesSearch.swift
//  Library
//
//  Created by Oliver Paray on 6/24/19.
//  Copyright © 2019 Oliver Paray. All rights reserved.
//

import Foundation

public class iTunesSearch {

    public static let searchURL = "https://itunes.apple.com/search"

    public enum SearchKeys: String, CaseIterable {
        case term,country,media,limit,explicit
    }

    public enum CountryKeys: String, CaseIterable {
        case US,UM,JP,AU,CA,CN,DE,GB,IL,IT,KR,ZA,ES,FR
    }

    public enum MediaKeys: String,CaseIterable{
        case movie,podcast,music,musicVideo,audiobook,shortFilm,tvShow,software,ebook,all
    }

    public enum ResultKeys: String,CaseIterable{
        case resultCount,results

        public enum CommonKeys: String,CaseIterable{
            case
            kind,
            trackId,
            artistName,
            trackName,
            trackCensoredName,
            artworkUrl100,
            trackPrice,
            price,
            primaryGenreName
        }

        public enum PreviewableKeys: String,CaseIterable{
            case
            trackViewUrl,
            previewUrl,
            releaseDate,
            currency
        }

        public enum DescribableKeys: String,CaseIterable{
            case
            trackViewUrl,
            releaseDate,
            currency,
            description
        }
    }

    public enum ErrorKeys: String,CaseIterable{
        case errorMessage,queryParameters

        public enum QueryParameterKeys: String,CaseIterable{
            case output,callback,country,limit,term,lang
        }
    }

    public static func performSearch(withTerm: String,
                              andCountry: String = iTunesSearch.CountryKeys.US.rawValue,
                              andMedia: String = iTunesSearch.MediaKeys.all.rawValue,
                              andLimit: Int? = 200,
                              isExplicit: Bool? = nil,
                              handler: ExecutionBlock) {
        var searchParams = [iTunesSearch.SearchKeys.term:withTerm,
                            iTunesSearch.SearchKeys.country:andCountry,
                            iTunesSearch.SearchKeys.media:andMedia]
        if let limit = andLimit{
            searchParams[iTunesSearch.SearchKeys.limit] = "\(limit)"
        }
        if let explicit = isExplicit{
            searchParams[iTunesSearch.SearchKeys.explicit] = (explicit) ? "Yes" : "No"
        }
        let params = String(queryStringFromDictionary: searchParams)
        let urlString = iTunesSearch.searchURL + params
        HttpClient.sharedInstance.execute(serviceUrl: urlString, webMethod: .Get, executionHandler: handler)
    }
}
