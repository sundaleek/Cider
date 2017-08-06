//
//  AmpUrlBuilderTests.swift
//  AmpKitTests
//
//  Created by Scott Hoyt on 8/1/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import XCTest
@testable import AmpKit

class AmpUrlBuilderTests: XCTestCase {

    let limit = 10
    let devToken = "devToken"
    let storefront = Storefront.unitedStates

    var builder: AmpUrlBuilder {
        return AmpUrlBuilder(storefront: storefront, developerToken: devToken)
    }

    // MARK: - Search

    let term = "search term"
    let types = [MediaType.albums, MediaType.songs]

    var searchRequest: URLRequest {
        return builder.searchRequest(term: term, limit: limit, types: types)
    }
    
    func testSearchRequestUrl() {
        XCTAssertEqual(searchRequest.url?.absoluteString, "https://api.music.apple.com/v1/catalog/us/search?term=search+term&limit=10&types=albums,songs")
    }

    func testSearchRequestHeaders() {
        XCTAssertEqual(searchRequest.allHTTPHeaderFields!, ["Authorization": "Bearer devToken"])
    }

    func testSearchRequestMethod() {
        XCTAssertEqual(searchRequest.httpMethod, "GET")
    }

    // MARK: - Fetch

    func testFetchArtistRequest() {
        var request = builder.fetchRequest(mediaType: .artists, id: "id123")
        XCTAssertEqual(request.url, URL(string: "https://api.music.apple.com/v1/catalog/us/artists/id123")!)
        XCTAssertEqual(request.allHTTPHeaderFields!, ["Authorization": "Bearer devToken"])
    }

    func testFetchAlbumRequest() {
        var request = builder.fetchRequest(mediaType: .albums, id: "id123")
        XCTAssertEqual(request.url, URL(string: "https://api.music.apple.com/v1/catalog/us/albums/id123")!)
        XCTAssertEqual(request.allHTTPHeaderFields!, ["Authorization": "Bearer devToken"])
    }

    func testFetchSongRequest() {
        var request = builder.fetchRequest(mediaType: .songs, id: "id123")
        XCTAssertEqual(request.url, URL(string: "https://api.music.apple.com/v1/catalog/us/songs/id123")!)
        XCTAssertEqual(request.allHTTPHeaderFields!, ["Authorization": "Bearer devToken"])
    }
}