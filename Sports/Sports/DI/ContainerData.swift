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

    var client: Factory<APIClient> {
        self {
            APIClient(network: self.networkManager())
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

    var eventRemoteDataSource: Factory<EventRemoteDataSource> {
        self{
            EventRemoteDataSource(client: self.client())
        }
    }

    var eventRepository: Factory<EventRepository> {
        self {
            EventRepositoryImpl(remote: self.eventRemoteDataSource())
        }
    }
}
