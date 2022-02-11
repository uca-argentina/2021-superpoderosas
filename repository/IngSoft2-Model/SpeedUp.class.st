Class {
	#name : #SpeedUp,
	#superclass : #Effect,
	#instVars : [
		'reverse'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
SpeedUp >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	aBoard move: aPlayer over: 4.

]

{ #category : #'as yet unclassified' }
SpeedUp >> initialize [
	reverse := WormHole.
]

{ #category : #'as yet unclassified' }
SpeedUp >> reverse [
	^ reverse new.
]
