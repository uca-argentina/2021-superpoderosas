Class {
	#name : #DoOver,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
DoOver >> do: aMove at: aBoardGame [
	aBoardGame make: (aMove currentPlayer) lay: self.
	aBoardGame letTheLastCardPlayedDo: aMove.
]
