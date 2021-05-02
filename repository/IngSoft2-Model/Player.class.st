Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Player class >> called: aName [
	^ self new initializeCalled: aName.
]

{ #category : #initialize }
Player >> initializeCalled: aName [
	name:= aName.
]

{ #category : #accessing }
Player >> name [
  ^ name
]
