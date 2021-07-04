Class {
	#name : #SpeedUp,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
SpeedUp >> effectTriggeredBy: player on: aBoard [
	aBoard move: player over: 4.
	super
]

{ #category : #actions }
SpeedUp >> effectTriggeredBy: newPosition on: aBoard of: aBoardGame [
	aBoard move: newPosition over: 4.
	super
]
