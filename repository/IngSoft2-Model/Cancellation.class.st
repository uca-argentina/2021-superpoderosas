Class {
	#name : #Cancellation,
	#superclass : #Card,
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
