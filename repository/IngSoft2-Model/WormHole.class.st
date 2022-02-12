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

{ #category : #initialize }
WormHole >> initialize [
	reverse := SpeedUp.

]

{ #category : #accessing }
WormHole >> reverse [
	^ reverse new.

]
