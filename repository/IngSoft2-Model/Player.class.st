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
	self new initializeWith: aName.
]

{ #category : #'as yet unclassified' }
Player class >> isCalled: aString [ 
	self shouldBeImplemented.
]

{ #category : #initialize }
Player >> initializeWith: aName [
	name:= aName.
]

{ #category : #initialize }
Player >> name [
  ^ name
]
