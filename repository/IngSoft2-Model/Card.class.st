Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Card >> laysCardOf: aMove andAddsCardToRecordOf: aBoardGame [
	aMove currentPlayer lays: self.
	aBoardGame addToCardsRecord: self
]
