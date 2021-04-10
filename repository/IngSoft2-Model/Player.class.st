Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'actualPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Player class >> called: aName [
	^ self new initializeWith: aName.
]

{ #category : #actions }
Player >> actualPosition [
	^ actualPosition.
]

{ #category : #initialize }
Player >> initializeWith: aName [
	name:= aName.
	actualPosition := 0.
]

{ #category : #initialize }
Player >> name [
  ^ name
]

{ #category : #actions }
Player >> reportNameAndActualPosition [
	^ name,': ',(actualPosition asString).
]
