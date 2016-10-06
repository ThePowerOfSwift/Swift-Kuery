/**
 Copyright IBM Corporation 2016
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */


import Foundation

public struct Delete: Query {
    public let table: Table
    public private (set) var whereClause: Where?
    public private (set) var rawWhereClause: String?
       
    public func build(queryBuilder: QueryBuilder) -> String {
        var result = "DELETE FROM " + table.build(queryBuilder: queryBuilder)
        if let whereClause = whereClause {
            result += " WHERE " + whereClause.build(queryBuilder: queryBuilder)
        }
        else if let rawWhereClause = rawWhereClause {
            result += " WHERE " + rawWhereClause
        }
        return result
    }
    
    public init(from table: Table) {
        self.table = table
    }
    
    public func `where`(_ conditions: Where) -> Delete {
        var new = self
        new.whereClause = conditions
        return new
    }

    public func `where`(_ raw: String) -> Delete {
        var new = self
        new.rawWhereClause = raw
        return new
    }
    

//    public mutating func `where`(_ conditions: Where) {
//        whereClause = conditions
//    }
}