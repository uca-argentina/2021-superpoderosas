Class {
	#name : #Permanent,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Permanent >> aCardWantsToBeThrownBy: currentPlayer at: aBoardGame [ 
	aBoardGame verifyIfItIsTheTurnOf: currentPlayer.
	currentPlayer lays: self.
	aBoardGame addToCardsRecord: self.
]

{ #category : #actions }
Permanent >> canBePlayedInAnyTurn [
	^false.
]

{ #category : #actions }
Permanent >> canBePlayedInAnyTurnAt: aBoardGame [
	^false.
]
