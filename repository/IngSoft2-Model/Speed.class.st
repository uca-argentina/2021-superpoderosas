Class {
	#name : #Speed,
	#superclass : #Permanent,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Speed >> actAt: aBoardGame on: aPlayer [
	aBoardGame apply: self on: aPlayer.
]

{ #category : #actions }
Speed >> action [
	^ 1.
]

{ #category : #actions }
Speed >> apply: aMove at: aBoardGame [
	aBoardGame verifyIfItIsTheTurnOf: aMove currentPlayer.
	aMove playersAffected first isInfluencedBy: self
]

{ #category : #actions }
Speed >> do: aMove at: aBoardGame [
	self apply: aMove at: aBoardGame.
	aMove currentPlayer lays: self.
	aBoardGame addToCardsRecord: self
]

{ #category : #actions }
Speed >> wantsToBeThrownTo: player by: currentPlayer at: aBoardGame [ 
	self aCardWantsToBeThrownBy: currentPlayer at: aBoardGame .
	player isInfluencedBy: self.
]
