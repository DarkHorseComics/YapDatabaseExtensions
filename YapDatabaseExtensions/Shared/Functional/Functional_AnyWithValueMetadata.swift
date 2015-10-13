//
//  Functional_AnyWithValueMetadata.swift
//  YapDatabaseExtensions
//
//  Created by Daniel Thorpe on 13/10/2015.
//
//

import Foundation
import ValueCoding
import YapDatabase

// MARK: - Reading

extension ReadTransactionType {

    /**
    Reads the metadata at a given index.

    - parameter index: a YapDB.Index
    - returns: an optional `MetadataType`
    */
    public func readMetadataAtIndex<
        MetadataType where
        MetadataType: ValueCoding,
        MetadataType.Coder: NSCoding,
        MetadataType.Coder.ValueType == MetadataType>(index: YapDB.Index) -> MetadataType? {
            return MetadataType.decode(readMetadataAtIndex(index))
    }

    /**
    Reads the metadata at the indexes.

    - parameter indexes: an Array<YapDB.Index>
    - returns: an array of `MetadataType`
    */
    public func readMetadataAtIndexes<
        MetadataType where
        MetadataType: ValueCoding,
        MetadataType.Coder: NSCoding,
        MetadataType.Coder.ValueType == MetadataType>(indexes: [YapDB.Index]) -> [MetadataType] {
            return indexes.flatMap(readMetadataAtIndex)
    }
}

extension ConnectionType {

    /**
    Reads the metadata at a given index.

    - parameter index: a YapDB.Index
    - returns: an optional `MetadataType`
    */
    public func readMetadataAtIndex<
        MetadataType where
        MetadataType: ValueCoding,
        MetadataType.Coder: NSCoding,
        MetadataType.Coder.ValueType == MetadataType>(index: YapDB.Index) -> MetadataType? {
            return read { $0.readMetadataAtIndex(index) }
    }

    /**
    Reads the metadata at the indexes.

    - parameter indexes: an Array<YapDB.Index>
    - returns: an array of `MetadataType`
    */
    public func readMetadataAtIndexes<
        MetadataType where
        MetadataType: ValueCoding,
        MetadataType.Coder: NSCoding,
        MetadataType.Coder.ValueType == MetadataType>(indexes: [YapDB.Index]) -> [MetadataType] {
            return read { $0.readMetadataAtIndexes(indexes) }
    }
}




