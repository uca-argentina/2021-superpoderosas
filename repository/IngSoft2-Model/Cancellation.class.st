Class {
	#name : #Cancellation,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Cancellation >> thrownBy: aPlayer aims: aTarget on: aBoardGame handledBy: cardHandler [ 
	cardHandler cancel: aTarget with: self on: aBoardGame.
]
