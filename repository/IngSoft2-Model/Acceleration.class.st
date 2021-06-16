Class {
	#name : #Acceleration,
	#superclass : #Permanent,
	#instVars : [
		'currentPlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Acceleration >> actAt: aBoardGame [ 
	aBoardGame applyToAllPlayers: self.
]

{ #category : #actions }
Acceleration >> action [
	^ 1.
]

{ #category : #actions }
Acceleration >> apply: aMove at: aBoardGame [
	aBoardGame verifyIfItIsTheTurnOf: (aMove currentPlayer).
	aMove playersAffected do: [ :player | player isInfluencedBy: self ]
]

{ #category : #actions }
Acceleration >> do: aMove at: aBoardGame [
	currentPlayer := aMove currentPlayer.
	self apply: aMove at: aBoardGame.
	currentPlayer lays: self.
	aBoardGame addToCardsRecord: self
]

{ #category : #actions }
Acceleration >> wantsToBeThrownBy: currentPlayer at: aBoardGame [
	self aCardWantsToBeThrownBy: currentPlayer at: aBoardGame.
	aBoardGame applyToAllPlayers: self.
]
