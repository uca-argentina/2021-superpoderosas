Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'spin'
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
	spin:= 1.
]

{ #category : #accessing }
Player >> name [
  ^ name
]

{ #category : #accesing }
Player >> spin [
	^ spin
]

{ #category : #actions }
Player >> startsANewSpin [
	 spin := spin +1.
]
