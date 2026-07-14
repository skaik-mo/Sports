//
//  ContainerData.swift
//  Sports
//
//  Created by Mohammed Skaik on 25/06/2026.
//

import FactoryKit
import Domain
import Data
import Networking
import SwiftData

extension Container {

    var leagueLocalDataSource: Factory<LeagueLocalDataSource> {
        self {
            MainActor.assumeIsolated {
                LeagueLocalDataSource(
                    context: SwiftDataStack.shared.mainContext
                )
            }
        }
    }

    var networkManager: Factory<NetworkManagerProtocol> {
        self {
            NetworkManager()
        }
    }

    var errorParser: Factory<APIErrorParserProtocol> {
        self {
            APIErrorParser()
        }
    }

    var client: Factory<APIClient> {
        self {
            APIClient(
                network: self.networkManager(),
                errorParser: self.errorParser()
            )
        }
    }

    var leagueRemoteDataSource: Factory<LeagueRemoteDataSource> {
        self {
            LeagueRemoteDataSource(client: self.client())
        }
    }

    var leagueRepository: Factory<LeagueRepository> {
        self {
            LeagueRepositoryImpl(
                remote: self.leagueRemoteDataSource(),
                local: self.leagueLocalDataSource()
            )
        }
    }

    var eventLocalDataSource: Factory<EventLocalDataSource> {
        self {
            MainActor.assumeIsolated {
                EventLocalDataSource(
                    context: SwiftDataStack.shared.mainContext
                )
            }
        }
    }

    var eventRemoteDataSource: Factory<EventRemoteDataSource> {
        self{
            EventRemoteDataSource(client: self.client())
        }
    }

    var eventRepository: Factory<EventRepository> {
        self {
            EventRepositoryImpl(
                remote: self.eventRemoteDataSource(),
                local: self.eventLocalDataSource()
            )
        }
    }

    var teamLocalDataSource: Factory<TeamLocalDataSource> {
        self {
            MainActor.assumeIsolated {
                TeamLocalDataSource(
                    context: SwiftDataStack.shared.mainContext
                )
            }
        }
    }

    var teamRemoteDataSource: Factory<TeamRemoteDataSource> {
        self {
            TeamRemoteDataSource(client: self.client())
        }
    }

    var teamRepository: Factory<TeamRepository> {
        self {
            TeamRepositoryImpl(
                remote: self.teamRemoteDataSource(),
                local: self.teamLocalDataSource()

            )
        }
    }

    var favoriteLocalDataSource: Factory<FavoriteLocalDataSource> {
        self {
            MainActor.assumeIsolated {
                FavoriteLocalDataSource(
                    context: SwiftDataStack.shared.mainContext
                )
            }
        }
    }


    var favoriteRepository: Factory<FavoriteRepository> {
        self {
            FavoriteRepositoryImpl(
                local: self.favoriteLocalDataSource()
            )
        }
    }
}
