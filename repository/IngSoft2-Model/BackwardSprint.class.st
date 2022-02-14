Class {
	#name : #BackwardSprint,
	#superclass : #Effect,
	#instVars : [
		'reverse'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
BackwardSprint >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	aBoardGame moveBackwardsAsManyFieldsAsCardsInHandHas: aPlayer.
]

{ #category : #initialize }
BackwardSprint >> initialize [
	reverse:= Sprint.
]

{ #category : #accessing }
BackwardSprint >> reverse [
	^reverse new.
]
