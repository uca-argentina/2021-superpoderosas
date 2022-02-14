Class {
	#name : #NoEffect,
	#superclass : #Effect,
	#instVars : [
		'reverse'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
NoEffect >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
]

{ #category : #initialize }
NoEffect >> initialize [ 
	reverse:= self.
]

{ #category : #accessing }
NoEffect >> reverse [
	^ reverse.
]
