Class {
	#name : #DoOver,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
DoOver >> do: aMove at: aBoardGame [
	(aMove currentPlayer) lays: self.
	aBoardGame letTheLastCardPlayedDo: aMove.
]
