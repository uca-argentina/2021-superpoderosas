Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Card >> do: aMove at: aBoardGame [
	^ self subclassResponsibility
]

{ #category : #actions }
Card >> laysFrom: aMove on: aBoardGame [
	aBoardGame make: (aMove currentPlayer) lay: self.
	aBoardGame addToCardsRecord: self
]
