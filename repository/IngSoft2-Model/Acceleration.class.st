Class {
	#name : #Acceleration,
	#superclass : #Permanent,
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
Acceleration >> wantsToBeThrownBy: currentPlayer at: aBoardGame [ 
	aBoardGame verifyIfItIsTheTurnOf: currentPlayer.
	currentPlayer lays: self.
	aBoardGame applyToAllPlayers: self.
	aBoardGame addToCardsRecord: self.
]
