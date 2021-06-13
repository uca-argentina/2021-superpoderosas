Class {
	#name : #DoOver,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
DoOver >> actAt: aBoardGame [ 
	aBoardGame applyLastCardThrownToAllPlayer.
]

{ #category : #actions }
DoOver >> actAt: aBoardGame on: aPlayer [
	aBoardGame applyLastCardThrownTo: aPlayer.
	
]

{ #category : #actions }
DoOver >> canBePlayedInAnyTurnAt: aBoardGame [
	^ (aBoardGame theLastCardThrownCanBePlayedInAnyTurn).
]