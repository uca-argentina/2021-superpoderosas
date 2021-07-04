Class {
	#name : #ExtraFields,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
ExtraFields >> action [
	^self subclassResponsibility.
]

{ #category : #actions }
ExtraFields >> thrownBy: aPlayer aims: aTarget on: aBoardGame handledBy: cardHandler [ 
	aBoardGame validateThrowOfAPermanent: self by: aPlayer.
	cardHandler influence: aTarget with: self.
]
