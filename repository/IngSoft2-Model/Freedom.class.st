Class {
	#name : #Freedom,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Freedom >> notifyCancellationRegarding: target on: aBoardGame [
]

{ #category : #actions }
Freedom >> thrownBy: aPlayer aims: aTarget on: aBoardGame handledBy: cardHandler [ 
	aBoardGame free: aTarget with: self.
]
