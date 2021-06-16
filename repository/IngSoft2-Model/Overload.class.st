Class {
	#name : #Overload,
	#superclass : #Permanent,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Overload >> actAt: aBoardGame on: aPlayer [
	aBoardGame apply: self on: aPlayer.
]

{ #category : #actions }
Overload >> action [
	^ -2.
]

{ #category : #actions }
Overload >> apply: aMove at: aBoardGame [
	aBoardGame verifyIfItIsTheTurnOf: aMove currentPlayer.
	aMove playersAffected first isInfluencedBy: self
]

{ #category : #actions }
Overload >> do: anOverloadCardMove [ 
	self shouldBeImplemented.
]

{ #category : #actions }
Overload >> do: aMove at: aBoardGame [
	self apply: aMove at: aBoardGame.
	aMove currentPlayer lays: self.
	aBoardGame addToCardsRecord: self
]

{ #category : #actions }
Overload >> wantsToBeThrownTo: player by: currentPlayer at: aBoardGame [ 
	self aCardWantsToBeThrownBy: currentPlayer at: aBoardGame .
	player isInfluencedBy: self.
]
