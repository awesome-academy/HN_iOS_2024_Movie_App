//
//  HomeViewControllerTest.swift
//  MovieHubTests
//
//  Created by Duy Nguyễn on 03/05/2024.
//

@testable import MovieHub
import XCTest
import Reusable

final class HomeViewControllerTest: XCTestCase {
    
    var viewController: HomeViewController!
    var mockMovieRepository: MovieRepositoryType!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(
            withIdentifier: "HomeViewController") as? HomeViewController
        let mockAPIService = MockAPIService.shared
        mockMovieRepository = MovieRepository(apiService: mockAPIService)
        viewController.movieRepository = mockMovieRepository
        viewController.loadViewIfNeeded()
    }

    func test_UI() {
        XCTAssertNotNil(viewController.tableView)
    }
    
    func test_Navigate() {
        viewController.toMovieDetailScreen(movieID: 1)
        viewController.toSearchMovieScreen()
        viewController.toListMovies(type: .nowPlaying)
    }
    
    func testFetchMoviesFromMockAPI() {
        let expectation = XCTestExpectation(description: "Fetch movies from mock API")
           viewController.getMovies()
                  
           viewController.dispatchGroup.notify(queue: .main) {
               XCTAssertEqual(self.viewController.popularMovies.count, 4)
               XCTAssertEqual(self.viewController.topRatedMovies.count, 4)
               XCTAssertEqual(self.viewController.upComingMovies.count, 4)
               XCTAssertEqual(self.viewController.nowPlayingMovies.count, 4)
               expectation.fulfill()
           }
                  
           wait(for: [expectation], timeout: 5.0)
    }
}
