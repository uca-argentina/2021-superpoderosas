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

{ #category : #initialize }
SpeedUp >> initialize [
	reverse := WormHole.
]

{ #category : #accessing }
SpeedUp >> reverse [
	^ reverse new.
]
