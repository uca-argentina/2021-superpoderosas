Class {
	#name : #DoOver,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
DoOver >> notifyCancellationRegarding: target on: aBoardGame [
]

{ #category : #actions }
DoOver >> thrownBy: aPlayer aims: aTarget on: aBoardGame handledBy: cardHandler [ 
	cardHandler repeatLastCardThrownBy: aPlayer affecting: aTarget on: aBoardGame.
]
