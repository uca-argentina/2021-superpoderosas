Class {
	#name : #CardDealer,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
CardDealer >> effectTriggeredBy: player on: aBoardGame [ 
	aBoardGame dealACardTo: player.
	super.
]

{ #category : #actions }
CardDealer >> effectTriggeredBy: player on: aBoard of: aBoardGame [
	aBoardGame dealACardTo: player.
	super.
]
