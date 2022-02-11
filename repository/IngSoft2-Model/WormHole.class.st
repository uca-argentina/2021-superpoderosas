Class {
	#name : #WormHole,
	#superclass : #Effect,
	#instVars : [
		'reverse'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
WormHole >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	aBoard move: aPlayer over: -4.

]

{ #category : #actions }
WormHole >> initialize [
	reverse := SpeedUp.

]

{ #category : #actions }
WormHole >> reverse [
	^ reverse new.

]
