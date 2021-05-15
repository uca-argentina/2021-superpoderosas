Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'fields'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> size: aNumberOfFields [ 
	^ self new initializeSize: aNumberOfFields .
]

{ #category : #initialize }
Board >> initializeSize: aNumberOfFields [ 
	fields := OrderedCollection new: aNumberOfFields withAll: NoEffect new.
	fields at: 17 put: WormHoleEffect new.
	

	
]
