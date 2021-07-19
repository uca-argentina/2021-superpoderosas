Class {
	#name : #Freedom,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Freedom >> thrownBy: aPlayer aims: aTarget on: aBoardGame handledBy: cardHandler [ 
	aBoardGame free: aTarget with: self.
]
