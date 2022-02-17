Class {
	#name : #Reversal,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Reversal >> annulOutcomeAt: aFieldNumber on: aBoardGame handledBy: cardHandler [
	cardHandler with: self reverseTheEffectOf: aFieldNumber on: aBoardGame.
	
]

{ #category : #actions }
Reversal >> thrownBy: aPlayer aims: aTarget on: aBoardGame handledBy: cardHandler [ 
	aBoardGame validateThrownOfAPermanentCardBy: aPlayer.
	cardHandler with: self reverseTheEffectOf: aTarget on: aBoardGame.
	
]
