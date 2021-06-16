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
