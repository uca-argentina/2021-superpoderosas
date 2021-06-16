Class {
	#name : #Cancellation,
	#superclass : #Instantaneous,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Cancellation >> actAt: aBoardGame on: aPlayer with: aCard [ 
	aBoardGame removes: aCard from: aPlayer.
]

{ #category : #actions }
Cancellation >> actAt: aBoardGame with:  card [ 
	aBoardGame removesEveryPlayers: card .
]

{ #category : #actions }
Cancellation >> apply: aMove at: aBoardGame [
	aMove playersAffected
		do: [ :player | aBoardGame removes: aMove cardToBeCancelled from: player ]
]

{ #category : #actions }
Cancellation >> do: aMove at: aBoardGame [
	self apply: aMove at: aBoardGame.
	aMove currentPlayer lays: self.
	aBoardGame addToCardsRecord: self
]
