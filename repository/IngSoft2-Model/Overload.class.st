Class {
	#name : #Overload,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Overload >> action [
	^ -2.
]

{ #category : #actions }
Overload >> notifyCancellationRegarding: target on: aBoardGame [
]

{ #category : #actions }
Overload >> thrownBy: aPlayer aims: aTarget on: aBoardGame handledBy: cardHandler [ 
	aBoardGame verifyIfItIsTheTurnOf: aPlayer.
	cardHandler influence: aTarget with: self.
]
