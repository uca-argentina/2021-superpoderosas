Class {
	#name : #Cancellation,
	#superclass : #Instantaneous,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Cancellation >> apply: aMove at: aBoardGame [
	aMove apply: [ :player | aBoardGame removes: (aMove cardToBeCancelled) from: player ] at: aBoardGame.
]

{ #category : #actions }
Cancellation >> do: aMove at: aBoardGame [
	self apply: aMove at: aBoardGame.
	self laysFrom: aMove on: aBoardGame
]
