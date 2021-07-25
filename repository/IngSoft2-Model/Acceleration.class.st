Class {
	#name : #Acceleration,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Acceleration >> action [
	^ 1.
]

{ #category : #actions }
Acceleration >> notifyCancellationRegarding: target on: aBoardGame [
]

{ #category : #actions }
Acceleration >> thrownBy: aPlayer aims: aTarget on: aBoardGame handledBy: cardHandler [ 
	aBoardGame verifyIfItIsTheTurnOf: aPlayer.
	cardHandler influenceAllPlayers: self.
	
]
