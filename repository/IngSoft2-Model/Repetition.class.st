Class {
	#name : #Repetition,
	#superclass : #Instantaneous,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Repetition >> actAt: aBoardGame [
	aBoardGame repeatlastEffectApplied.
]

{ #category : #actions }
Repetition >> actAt: aBoardGame on: aPlayer [ 
	aBoardGame repeatlastEffectAppliedOn:aPlayer.
]

{ #category : #actions }
Repetition >> apply: aMove at: aBoardGame [
	aMove playersAffected
		do: [ :player | aBoardGame repeatlastEffectAppliedOn: player ]
]

{ #category : #actions }
Repetition >> do: aMove at: aBoardGame [
	self apply: aMove at: aBoardGame.
	aMove currentPlayer lays: self.
	aBoardGame addToCardsRecord: self
]

{ #category : #actions }
Repetition >> wantsToBeThrownBy: currentPlayer at: aBoardGame [ 
	currentPlayer lays: self.
	aBoardGame repeatlastEffectApplied.
	aBoardGame addToCardsRecord: self.
]

{ #category : #actions }
Repetition >> wantsToBeThrownTo: player by: currentPlayer at: aBoardGame [ 
	currentPlayer lays: self.
	aBoardGame repeatlastEffectAppliedOn: player.
	aBoardGame addToCardsRecord: self.
]
