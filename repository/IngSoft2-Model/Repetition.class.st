Class {
	#name : #Repetition,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Repetition >> thrownBy: aPlayer aims: aTarget on: aBoardGame handledBy: cardHandler [ 
	cardHandler with: self repeatLastEffectAppliedOn: aBoardGame targeting: aTarget.
]
