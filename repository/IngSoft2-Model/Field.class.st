Class {
	#name : #Field,
	#superclass : #Object,
	#instVars : [
		'effects'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Field class >> affectedBy: effect [ 
	^self new initializeAffectedBy: effect. 
	
]

{ #category : #actions }
Field >> add: effect [
	effects add: effect.
]

{ #category : #actions }
Field >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [ 
	effects do:[:effect | effect effectTriggeredBy: aPlayer on: aBoard of: aBoardGame ].
	^effects last.
]

{ #category : #initialize }
Field >> initializeAffectedBy: effect [ 
	effects := OrderedCollection newFrom: {effect}.
]
