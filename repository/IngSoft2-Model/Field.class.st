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
Field >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [ 
	effects do:[:effect | effect effectTriggeredBy: aPlayer on: aBoard of: aBoardGame ].
	^effects last.
]

{ #category : #actions }
Field >> effects [
	^effects.
]

{ #category : #initialize }
Field >> initializeAffectedBy: someEffects [ 
	effects := someEffects asOrderedCollection.
]
