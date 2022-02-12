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

{ #category : #initialize }
BackwardsSprint >> initialize [
	reverse:= Sprint.
]

{ #category : #accessing }
BackwardsSprint >> reverse [
	^reverse new.
]
