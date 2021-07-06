Class {
	#name : #Speed,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Speed >> action [
	^ 1.
]

{ #category : #actions }
Speed >> thrownBy: aPlayer aims: aTarget on: aBoardGame handledBy: cardHandler [ 
	aBoardGame validateThrowOfAPermanent: self by: aPlayer.
	cardHandler influence: aTarget with: self.
]
