Class {
	#name : #BackwardsSprint,
	#superclass : #Effect,
	#instVars : [
		'reverse'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
BackwardsSprint >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	aBoardGame moveBackwardsAsManyFieldsAsCardsInHandHas: aPlayer.
]

{ #category : #actions }
BackwardsSprint >> initialize [
	reverse:= Sprint.
]

{ #category : #actions }
BackwardsSprint >> reverse [
	^reverse new.
]
