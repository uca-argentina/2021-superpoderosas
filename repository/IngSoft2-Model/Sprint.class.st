Class {
	#name : #Sprint,
	#superclass : #Effect,
	#instVars : [
		'reverse'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Sprint >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	aBoardGame moveAsManyFieldsAsCardsInHandHas: aPlayer.
]

{ #category : #actions }
Sprint >> initialize [
	reverse:= BackwardsSprint.
]

{ #category : #actions }
Sprint >> reverse [
	^reverse new.
]
