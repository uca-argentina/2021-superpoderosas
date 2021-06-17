Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Card >> do: arg1 at: arg2 [ 
	^ self subclassResponsibility
]

{ #category : #actions }
Card >> laysCardOf: aMove andAddsCardToRecordOf: aBoardGame [
	aMove currentPlayer lays: self.
	aBoardGame addToCardsRecord: self
]
